from rest_framework import generics
from .models import Lifesaver, Citizen, PostInfoCitizen, PostInfoLifesaver, Incident, Request, User
from .serializers import  LifesaverRegistrationSerializer, CitizenRegistrationSerializer, PostInfoCitizenSerializer, PostInfoLifesaverSerializer, RequestSerializer, IncidentSerializer, LifesaverSerializer, CitizenSerializer, UserLoginSerializer, UserSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework import permissions
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from rest_framework import status
from django.http import Http404
from rest_framework.views import APIView
import requests
import json
from django.shortcuts import render
from rest_framework.parsers import MultiPartParser
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.http import HttpResponse
import time
import redis
import asyncio
from multiprocessing import Process
# incident.id, request.data['latitude'], request.data['longitude'], request.data['info'], request.data['no_of_patients'], f'{citizen.first_name} {citizen.last_name}', citizen.contact_no 
def send_notification(registration_token, request_id, incident_id, latitude, longitude, info, no_of_patients, citizen_name, citizen_contact):
    r = requests.post('https://fcm.googleapis.com/fcm/send', headers={"Authorization":"key=AAAAT3R6Eao:APA91bHKhCyVHijluBFFxBoYdNt8tVvmZ1vpYlDbm0W8JSpQLg7RHG6kX-p09dIJXteunsi4CTfbIK47J_3dROjOSVWK4EbWjOgiJSj5zD5Epb4J48dVTAnyTGd_IuQOL82hcujLHjb9",
    "Content-Type":"application/json"}, data=json.dumps({
    "to" : registration_token,
    "mutable_content": True,
    "priority": "high",
    "notification": {
        "badge": 50,
        "title": "'Emergency! Urgent help is required!'",
        "body": "There is an accident in your vicinity. Accept and help!"
    },
    "data" : {
        "content": {
            "id": 1,
            "badge": 50,
            "channelKey": "alerts",
            "displayOnForeground": True,
            "notificationLayout": "BigPicture",
            "largeIcon": "https://cdn-icons-png.flaticon.com/512/3393/3393714.png",
            "bigPicture": "https://cdn-icons-png.flaticon.com/256/9284/9284033.png",
            "showWhen": True,
            "autoDismissible": True,
            "privacy": "Private",
            "payload": {
                "incident": str(incident_id),
                "latitude": str(latitude),
                "longitude": str(longitude),
                "no_of_patients":str(no_of_patients),
                "info": str(info),
                "citizen_name":str(citizen_name),
                "citizen_contact":str(citizen_contact),
                "request_id":str(request_id)
            },
        },
        "actionButtons": [
            {
                "key": "REDIRECT",
                "label": "View"
            },
            {
                "key": "DISMISS",
                "label": "Dismiss",
                "actionType": "DismissAction",
                "isDangerousOption": True,
                "autoDismissible": True
            }
        ]
    }
    }))
    print("Status Code", r.status_code)
    print("JSON Response ", r.text)

def lobby(request):
    return render(request, 'lobby.html')


class GetUploadImageLifesaver(APIView):
    parser_classes = [MultiPartParser]
    def post(self, request, format=None, lifesaver_id=None):
        ls = Lifesaver.objects.get(id=lifesaver_id)
        ls.profile_picture = request.FILES['image']
        ls.save()
        return Response({'status': 'success'})
    def get(self, request, format=None, lifesaver_id=None):
        ls = Lifesaver.objects.get(id=lifesaver_id)
        image_path = ls.profile_picture.path
        # with default_storage.open(image_path, 'rb') as image_file:
        #     response = HttpResponse(image_file.read(), content_type='image/jpeg')
        #     return response
        return Response(ls.profile_picture.url)

class GetUploadImageCitizen(APIView):
    parser_classes = [MultiPartParser]
    def post(self, request, format=None, citizen_id=None):
        ct = Citizen.objects.get(id=citizen_id)
        ct.profile_picture = request.FILES['image']
        ct.save()
        return Response({'status': 'success'})
    def get(self, request, format=None, citizen_id=None):
        ct = Citizen.objects.get(id=citizen_id)
        image_path = ct.profile_picture.path
        with default_storage.open(image_path, 'rb') as image_file:
            response = HttpResponse(image_file.read(), content_type='image/jpeg')
            return response


class LogInView(TokenObtainPairView):
    serializer_class = UserLoginSerializer

class LifesaverRegister(generics.CreateAPIView):
    serializer_class = LifesaverRegistrationSerializer

class CitizenRegister(generics.CreateAPIView):
    serializer_class = CitizenRegistrationSerializer

class LifesaverGet(generics.ListAPIView):
    queryset = Lifesaver.objects.all()
    serializer_class = LifesaverSerializer

class UserGet(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class CitizenGet(generics.ListAPIView):
    queryset = Citizen.objects.all()
    serializer_class = CitizenSerializer

class LifesaverGetUpdateDelete(generics.GenericAPIView):
    serializer_class = LifesaverSerializer

    def get_object(self, pk):
        try:
            return Lifesaver.objects.get(pk=pk)
        except Lifesaver.DoesNotExist:
            raise Http404

    def get_queryset(self):
        return Lifesaver.objects.filter(lifesaver=self.kwargs['pk'])

    def get(self, request, pk, format=None):
        ls = self.get_object(pk)
        serializer = self.get_serializer(ls)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        ls = self.get_object(pk)
        serializer = self.get_serializer(ls, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        ls = self.get_object(pk)
        ls.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

class CitizenHistory(APIView):
    def get(self, request, citizen_id=None):
        queryset = Incident.objects.all()
        if citizen_id is not None:
            queryset = queryset.filter(citizen=citizen_id)
        serializer = IncidentSerializer(queryset, many=True)

        # Format the response to include the associated citizen and lifesaver information
        formatted_response = []
        for incident in serializer.data:
            try:
                lifesaver = Lifesaver.objects.get(id=incident['lifesaver'])
            except:
                continue
            lifesaver_serializer = LifesaverSerializer(lifesaver)
            try:
                citizen_postinfo = PostInfoCitizen.objects.get(incident_id=incident['id'], citizen_id=citizen_id)
                post_serializer = PostInfoCitizenSerializer(citizen_postinfo)
                rating_value = post_serializer.data['lifesaver_rating']
            except:
                rating_value = 0.5
            formatted_incident = {
                'id': incident['id'],
                'location': incident['location'],
                "latitude": incident['latitude'],
                "longitude": incident['longitude'],
                "info": incident['info'],
                "created": incident['created'],
                "updated": incident['updated'],
                "no_of_patients": incident['no_of_patients'],
                "patient_name": incident['patient_name'],
                'lifesaver_name': lifesaver_serializer.data['first_name'] + ' ' + lifesaver_serializer.data['last_name'],
                'lifesaver_contact': lifesaver_serializer.data['contact_no'],
                'rating': rating_value
            }
            formatted_response.append(formatted_incident)
        formatted_response.sort(key=lambda item:item['created'], reverse=True)
        return Response(formatted_response)

class LifesaverHistory(APIView):
    def get(self, request, lifesaver_id=None):
        queryset = Incident.objects.all()
        if lifesaver_id is not None:
            queryset = queryset.filter(lifesaver=lifesaver_id)
        serializer = IncidentSerializer(queryset, many=True)

        # Format the response to include the associated citizen and lifesaver information
        formatted_response = []
        for incident in serializer.data:
            citizen = Citizen.objects.get(id=incident['citizen'])
            citizen_serializer = CitizenSerializer(citizen)
            try:
                citizen_postinfo = PostInfoCitizen.objects.get(incident=incident['id'], citizen=citizen_serializer.data['id'])
                post_serializer = PostInfoCitizenSerializer(citizen_postinfo)
                rating_value = post_serializer.data['lifesaver_rating']
            except:
                rating_value = 0.5
            formatted_incident = {
                'id': incident['id'],
                'location': incident['location'],
                "latitude": incident['latitude'],
                "longitude": incident['longitude'],
                "info": incident['info'],
                "created": incident['created'],
                "updated": incident['updated'],
                "no_of_patients": incident['no_of_patients'],
                "patient_name": incident['patient_name'],
                'citizen_name': citizen_serializer.data['first_name'] + ' ' + citizen_serializer.data['last_name'],
                'citizen_contact': citizen_serializer.data['contact_no'],
                'rating': rating_value
            }

            formatted_response.append(formatted_incident)
        formatted_response.sort(key=lambda item:item['created'], reverse=True)
        return Response(formatted_response)


class CitizenGetUpdateDelete(APIView):
    def get_object(self, pk):
        try:
            return Citizen.objects.get(pk=pk)
        except Citizen.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        cit = self.get_object(pk)
        serializer = CitizenSerializer(cit)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        cit = self.get_object(pk)
        serializer = CitizenSerializer(cit, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        cit = self.get_object(pk)
        cit.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class IncidentGetCreate(generics.ListCreateAPIView):
    # permission_classes = (permissions.IsAuthenticated,)
    queryset = Incident.objects.all()
    serializer_class = IncidentSerializer

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.redis_conn = redis.Redis(host='localhost', port=6379, db=0)

    def post(self, request, *args, **kwargs):
        serializer = IncidentSerializer(data=request.data)
        if serializer.is_valid():
            incident = serializer.save()
            lat, long = request.data['latitude'], request.data['longitude']
            rounded_lat, rounded_long= round(float(lat), 3), round(float(long), 3)
            citizen = incident.citizen
            ls = []
            cache_key = f"{rounded_lat}:{rounded_long}"
            cached_data = self.redis_conn.get(cache_key)
            print("Retrieved Cache data", cached_data)
            if cached_data:
                ls = Lifesaver.objects.filter(id__in=cached_data.decode().split(","))
                print("Lifesavers from cached", ls)
            if not ls:
                ls = [l  for l in Lifesaver.objects.filter(is_available=True) if l.is_nearby(lat, long)]
                # lifesavers = Lifesaver.objects.filter(is_available=True, latitude__range=(lat-0.3, lat+0.3), longitude__range=(long-0.3, long+0.3))
                print("Lifesavers obtained from database", ls)
                ntries = 2
                radius = 1
                if not ls:
                    while not ls and ntries>0:
                        print("Retrying in 30 seconds")
                        time.sleep(30)
                        ls = [l for l in Lifesaver.objects.all() if l.is_nearby(lat, long, radius)]
                        radius += 0.5
                        ntries -= 1
                if ls:
                    lifesaver_ids = ",".join([str(l.id) for l in ls])
                    self.redis_conn.set(cache_key, lifesaver_ids)
            if not ls:  
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            for l in ls:
                req = Request.objects.create(is_active=True, lifesaver=l, incident=incident)
                try:
                    send_notification(l.registration_token, req.id, incident.id, request.data['latitude'], request.data['longitude'], request.data['info'], request.data['no_of_patients'], f'{citizen.first_name} {citizen.last_name}', citizen.contact_no )
                    l.calls_received+=1
                    l.save()
                except Exception as e:
                    print(e)
                    pass
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class IncidentUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Incident.objects.all()
    serializer_class = IncidentSerializer

class IncidentGetCitizen(generics.RetrieveUpdateDestroyAPIView):
    queryset = Incident.objects.all()
    serializer_class = IncidentSerializer
    def get_queryset(self):
        return super().get_queryset().filter(
            citizen=self.kwargs['pk']
        )

# class LifesaverUpdateToken(APIView):
#     def post(self, request, lifesaver_id=None):
#         try:
#             lifesaver_obj = Lifesaver.objects.get(id=lifesaver_id)
#             lifesaver_obj.registration_token = request.data['registration_token']
#             lifesaver_obj.save()
#             return Response({'msg': 'Token saved'}, status=status.HTTP_400_BAD_REQUEST)
#         except Lifesaver.DoesNotExist:
#             return Response({'error': 'Lifesaver does not exist.'}, status=status.HTTP_400_BAD_REQUEST)

class AcceptRequest(APIView):
    def post(self, request, request_id, lifesaver_id=None):
        try:
            lifesaver_obj = Lifesaver.objects.get(id=lifesaver_id)
        except Lifesaver.DoesNotExist:
            return Response({'error': 'Lifesaver does not exist.'}, status=status.HTTP_400_BAD_REQUEST)
        try:
            request_obj = Request.objects.get(id=request_id)
        except Request.DoesNotExist:
            return Response({'error': 'Request does not exist.'}, status=status.HTTP_400_BAD_REQUEST)

        incident_obj = request_obj.incident
        incident_obj.status = 'accepted'
        if incident_obj.lifesaver is None:
            incident_obj.lifesaver = lifesaver_obj
            incident_obj.updated
            incident_obj.save()

            other_requests = Request.objects.filter(incident=incident_obj).exclude(id=request_obj.id)
            for other_request in other_requests:
                other_request.is_active = False
                other_request.save()

            return Response({'status':'accepted', 'msg': 'Request accepted and incident resolved.'}, status=status.HTTP_200_OK)
        else:
            return Response({'status':'rejected', 'msg': 'Request rejected. Some other lifesaver accepted the request'}, status=status.HTTP_200_OK)

class DidAcceptIncident(APIView):
    def get(self, request, incident_id):
        try:
            incident_obj = Incident.objects.get(id=incident_id)
        except Lifesaver.DoesNotExist:
            return Response({'error': 'Incident does not exist.'}, status=status.HTTP_400_BAD_REQUEST)
        
        output_response = {
            "incident": incident_obj.id,
            "location": incident_obj.location,
            "latitude": incident_obj.latitude,
            "longitude": incident_obj.longitude,
            "info": incident_obj.info,
            "no_of_patients": incident_obj.no_of_patients,
            "patient_name": incident_obj.patient_name,
            "status": incident_obj.status,
            "lifesaver": incident_obj.lifesaver.id if incident_obj.lifesaver is not None else None,
            "citizen": incident_obj.citizen.id,
        }
        if incident_obj.status == 'accepted':
            lifesaver_obj = incident_obj.lifesaver
            output_response["lifesaver_name"] = f'{incident_obj.lifesaver.first_name} {incident_obj.lifesaver.last_name}'
            output_response["lifesaver_contact"] = incident_obj.lifesaver.contact_no
            return Response(output_response, status=status.HTTP_200_OK)
        else:
            return Response(output_response, status=status.HTTP_200_OK)



class RequestCreate(generics.ListCreateAPIView):
    queryset = Lifesaver.objects.all()
    serializer_class = RequestSerializer


class RequestUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Request.objects.all()
    serializer_class = RequestSerializer

class PostInfoLifesaverUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = PostInfoLifesaver.objects.all()
    serializer_class = PostInfoLifesaverSerializer

class PostInfoLifesaverGetCreate(generics.ListCreateAPIView):
    queryset = PostInfoLifesaver.objects.all()
    serializer_class = PostInfoLifesaverSerializer

class PostInfoCitizenGetCreate(generics.ListCreateAPIView):
    queryset = PostInfoCitizen.objects.all()
    serializer_class = PostInfoCitizenSerializer

class PostInfoCitizenUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = PostInfoCitizen.objects.all()
    serializer_class = PostInfoCitizenSerializer

class RetrieveNearby(generics.ListAPIView):
    queryset = Lifesaver.objects.all()
    serializer_class = LifesaverSerializer
    def get_queryset(self):
        lat=float(self.kwargs['lat'])
        long=float(self.kwargs['long'])
        return  [ls for ls in super().get_queryset() if ls.is_nearby(lat, long)]

