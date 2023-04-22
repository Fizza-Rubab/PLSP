import uuid
from django.db import models
from geopy.distance import geodesic
from django.conf import settings
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser


class UserManager(BaseUserManager):
	'''
	creating a manager for a custom user model
	https://docs.djangoproject.com/en/3.0/topics/auth/customizing/#writing-a-manager-for-a-custom-user-model
	'''
	def create_user(self, email, password=None):
		"""
		Create and return a `User` with an email, username and password.
		"""
		if not email:
			raise ValueError('Users Must Have an email address')

		user = self.model(
			email=self.normalize_email(email),
		)
		user.set_password(password)
		user.save()
		return user

	def create_superuser(self, email, password):
		"""
		Create and return a `User` with superuser (admin) permissions.
		"""
		if password is None:
			raise TypeError('Citizens must have a password.')

		user = self.create_user(email, password)
		user.is_lifesaver = False
		user.is_citizen = False
		user.save()
		return user

	def create_lifesaveruser(self,email,password):
		if password is None:
			raise TypeError('Lifesavers must have a password')
		user = self.create_user(email,password)
		user.is_lifesaver = True
		user.is_citizen = False
		user.save()
		return user


	def create_citizenuser(self,email,password):
		if password is None:
			raise TypeError('Doctors must have a password')
		user = self.create_user(email,password)
		user.is_lifesaver = False
		user.is_citizen = True
		user.save()
		return user

class User(AbstractBaseUser):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    email = models.EmailField(
		verbose_name='email address',
		max_length=255,
		unique=True
	)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_lifesaver = models.BooleanField(default=False)
    is_citizen = models.BooleanField(default=True)
    username = None
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []
    objects = UserManager()
    def __str__(self):
        return self.email

class Lifesaver(models.Model):
    lifesaver = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, blank=True, null=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    date_of_birth = models.DateField()
    address = models.CharField(max_length=50)
    latitude = models.FloatField(max_length=15)    
    longitude = models.FloatField(max_length=15)
    cnic = models.CharField(max_length=13)
    training_id = models.IntegerField()
    contact_no = models.CharField(max_length=11)
    calls_received = models.IntegerField()
    badge = models.CharField(max_length=50, default=None, blank=True, null=True)

    def is_nearby(self, lat, long):
        return geodesic((lat, long), (self.latitude, self.longitude)).miles <=1
    

class Citizen(models.Model):
    citizen = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, blank=True, null=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    address = models.CharField(max_length=50)
    contact_no = models.CharField(max_length=11)
    date_of_birth = models.DateField()
    calls_made = models.IntegerField(default=0)
    USERNAME_FIELD = 'email'

class Incident(models.Model):
    lifesaver = models.ForeignKey(Lifesaver, on_delete=models.CASCADE, related_name="incident_lifesaver", null=True)
    citizen = models.ForeignKey(Citizen, on_delete=models.CASCADE, related_name="incident_citizen")
    location = models.TextField()
    latitude = models.FloatField()
    longitude = models.FloatField()
    info = models.TextField()
    created = models.DateTimeField(auto_now_add=True,)
    updated = models.DateTimeField(auto_now=True)
    no_of_patients = models.IntegerField()
    patient_name = models.TextField()

class PostInfo(models.Model):
    incident = models.ForeignKey(Incident, on_delete=models.CASCADE, related_name= "post_incident")
    lifesaver = models.ForeignKey(Lifesaver, on_delete=models.CASCADE, related_name= "post_lifesaver")
    life_saved = models.BooleanField()
    INTERVENTION_CHOICES = (
    (1, "CPR"),
    (2, "Bandaging"),
    (3, "Pumping"),
    (4, "Ambulance Call"))
    intervention = models.IntegerField(choices=INTERVENTION_CHOICES, default=1)
    details = models.TextField()

class Request(models.Model):
    incident = models.ForeignKey(Incident, on_delete=models.CASCADE, related_name= "request_incident")
    lifesaver = models.ForeignKey(Lifesaver, on_delete=models.CASCADE, related_name= "request_lifesaver", null=True)
    is_active = models.BooleanField(default=True)
