from rest_framework import serializers
from .models import Citizen, Lifesaver, Incident, Request, PostInfoCitizen, PostInfoLifesaver
from rest_framework import serializers
from api.models import User
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = Lifesaver
        fields = ('id', 'email', 'is_lifesaver')


class LifesaverSerializer(serializers.ModelSerializer):
    class Meta:
        model = Lifesaver
        fields = ('id', 'lifesaver', 'first_name', 'last_name', 'date_of_birth', 'address', 'latitude','longitude', 'longitude', 'cnic', 'training_id', 'contact_no', "calls_received", 'rating', 'registration_token', 'profile_picture', 'is_available')

class CitizenSerializer(serializers.ModelSerializer):
    class Meta:
        model = Citizen
        fields = ('id', 'citizen', 'first_name', 'last_name', 'date_of_birth', 'address', 'contact_no', 'calls_made', 'profile_picture')


class IncidentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Incident
        fields = '__all__'


class IncidentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Incident
        fields = '__all__'


class RequestSerializer(serializers.ModelSerializer):
    incident = IncidentSerializer
    class Meta:
        model = Request
        fields = ['is_active', 'id','lifesaver', 'incident']

class PostInfoCitizenSerializer(serializers.ModelSerializer):
    class Meta:
        model = PostInfoCitizen
        fields = '__all__'

class PostInfoLifesaverSerializer(serializers.ModelSerializer):
    class Meta:
        model = PostInfoLifesaver
        fields = '__all__'


class LifesaverRegistrationSerializer(serializers.ModelSerializer):

    lifesaver = LifesaverSerializer(required=False)

    class Meta:
        model = User
        fields = ('email', 'password', 'lifesaver')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        lifesaver_data = validated_data.pop('lifesaver')
        user = User.objects.create_lifesaveruser(**validated_data)
        Lifesaver.objects.create(
            lifesaver=user,
            first_name=lifesaver_data['first_name'],
            last_name=lifesaver_data['last_name'],
            date_of_birth=lifesaver_data['date_of_birth'],
            address=lifesaver_data['address'],
            latitude=lifesaver_data['latitude'],
            longitude=lifesaver_data['longitude'],
            cnic=lifesaver_data['cnic'],
            training_id=lifesaver_data['training_id'],
            contact_no=lifesaver_data['contact_no'],
            calls_received=lifesaver_data['calls_received'],
            rating=0.0,
            is_available = True,
        )
        return user


class CitizenRegistrationSerializer(serializers.ModelSerializer):

    citizen = CitizenSerializer(required=False)

    class Meta:
        model = User
        fields = ('email', 'password', 'citizen')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        citizen_data = validated_data.pop('citizen')
        print(validated_data)
        user = User.objects.create_citizenuser(**validated_data)
        Citizen.objects.create(
            citizen=user,
            first_name=citizen_data['first_name'],
            last_name=citizen_data['last_name'],
            date_of_birth=citizen_data['date_of_birth'],
            address=citizen_data['address'],
            contact_no=citizen_data['contact_no'],
            calls_made=citizen_data['calls_made']
        )
        return user

class UserLoginSerializer(TokenObtainPairSerializer):

    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        token['email'] = user.email
        return token

    def validate(self, attrs):
        data = super().validate(attrs)
        refresh = self.get_token(self.user)
        data['email'] = self.user.email
        if self.user.is_lifesaver:
            ls = Lifesaver.objects.get(lifesaver=self.user)
            data['id'] = ls.id
            data['first_name'] = ls.first_name
            data['last_name'] = ls.last_name
            data['address'] = ls.address
            data['latitude'] = ls.latitude
            data['longitude'] = ls.longitude
            data['is_lifesaver'] = True
            data['profile_picture'] = ls.profile_picture.url
        elif self.user.is_citizen:
            cz = Citizen.objects.get(citizen=self.user)
            data['id'] = cz.id
            data['first_name'] = cz.first_name
            data['last_name'] = cz.last_name
            data['address'] = cz.address
            data['calls_made'] = cz.calls_made
            data['is_lifesaver'] = False
            data['profile_picture']=cz.profile_picture.url
        return data

