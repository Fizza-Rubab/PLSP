from rest_framework import generics
from .models import Lifesaver, Citizen, PostInfo, Incident, Request
from .serializers import  LifesaverRegistrationSerializer, CitizenRegistrationSerializer, PostInfoSerializer, RequestSerializer, IncidentSerializer, LifesaverSerializer, CitizenSerializer, UserLoginSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework import permissions
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from rest_framework import status
import requests
from django.shortcuts import render


def lobby(request):
    return render(request, 'lobby.html')

class LogInView(TokenObtainPairView):
    serializer_class = UserLoginSerializer

class LifesaverRegister(generics.CreateAPIView):
    serializer_class = LifesaverRegistrationSerializer

class CitizenRegister(generics.CreateAPIView):
    serializer_class = CitizenRegistrationSerializer

class LifesaverGet(generics.ListAPIView):
    queryset = Lifesaver.objects.all()
    serializer_class = LifesaverSerializer

class CitizenGet(generics.ListAPIView):
    queryset = Citizen.objects.all()
    serializer_class = CitizenSerializer

class LifesaverGetUpdateDelete(generics.GenericAPIView):
    serializer_class = LifesaverSerializer
    def get_queryset(self):
        return Lifesaver.objects.filter(id=self.kwargs['pk'])
    def get(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return Response(serializer.data)


class CitizenGetUpdateDelete(generics.GenericAPIView):
    serializer_class = CitizenSerializer
    queryset = Citizen.objects.all()
    def get_queryset(self):
        return Citizen.objects.filter(citizen_id=self.kwargs['pk'])
    def get(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return Response(serializer.data)


class IncidentGetCreate(generics.ListCreateAPIView):
    # permission_classes = (permissions.IsAuthenticated,)
    queryset = Incident.objects.all()
    serializer_class = IncidentSerializer

    def post(self, request, *args, **kwargs):
        serializer = IncidentSerializer(data=request.data)
        if serializer.is_valid():
            incident = serializer.save()
            lat, long = request.data['latitude'], request.data['longitude'] 
            ls = [l  for l in Lifesaver.objects.all() if l.is_nearby(lat, long)]
            for l in ls:
                r = requests.post('http://127.0.0.1:8000/request/', data={'is_active':True,
                'lifesaver':l.id, 'incident':incident.id})
                l.calls_received+=1
                l.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class IncidentUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Incident.objects.all()
    serializer_class = IncidentSerializer


class IncidentGetCitizen(generics.RetrieveUpdateDestroyAPIView):
    queryset = Incident.objects.all()
    serializer_class = IncidentSerializer

    def get_queryset(self):
        return super().get_queryset().filter(
            citizen=self.kwargs['pk']
        )

class RequestCreate(generics.CreateAPIView):
    queryset = Lifesaver.objects.all()
    serializer_class = RequestSerializer


class RequestUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Request.objects.all()
    serializer_class = RequestSerializer


class PostInfoGetCreate(generics.ListCreateAPIView):
    queryset = PostInfo.objects.all()
    serializer_class = PostInfoSerializer


class PostInfoUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = PostInfo.objects.all()
    serializer_class = PostInfoSerializer


class RetrieveNearby(generics.ListAPIView):
    queryset = Lifesaver.objects.all()
    serializer_class = LifesaverSerializer

    def get_queryset(self):
        lat=float(self.kwargs['lat'])
        long=float(self.kwargs['long'])
        return  [ls for ls in super().get_queryset() if ls.is_nearby(lat, long)]


