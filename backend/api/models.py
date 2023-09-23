import uuid
from django.db import models
from geopy.distance import geodesic
from django.conf import settings
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
INTERVENTION_CHOICES = (
    ("CPR", "CPR"),
    ("Bleeding Control", "Bleeding Control"),
    ("Both", "Both"),
    )
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
		user.is_staff = True
		user.is_citizen = False
		user.is_superuser = True
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

class User(AbstractBaseUser, PermissionsMixin):
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
    registration_token = models.CharField(max_length=180, default='')
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
    rating = models.FloatField(default=0.0)
    is_available = models.BooleanField(default=True)
    profile_picture = models.ImageField(upload_to='profile_pictures/', default='profileicon.png')
    USERNAME_FIELD = 'email'
    def is_nearby(self, lat, long, dist = 1):
        return geodesic((lat, long), (self.latitude, self.longitude)).miles <= dist


class Citizen(models.Model):
    citizen = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, blank=True, null=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    address = models.CharField(max_length=50)
    contact_no = models.CharField(max_length=11)
    date_of_birth = models.DateField()
    calls_made = models.IntegerField(default=0)
    USERNAME_FIELD = 'email'
    profile_picture = models.ImageField(upload_to='profile_pictures/', default='profileicon.png')

class Incident(models.Model):
    lifesaver = models.ForeignKey(Lifesaver, on_delete=models.CASCADE, related_name="incident_lifesaver", null=True)
    citizen = models.ForeignKey(Citizen, on_delete=models.CASCADE, related_name="incident_citizen")
    location = models.TextField(default='',blank=True)
    latitude = models.FloatField()
    longitude = models.FloatField()
    info = models.TextField(default='',blank=True)
    created = models.DateTimeField(auto_now_add=True,)
    updated = models.DateTimeField(auto_now=True)
    no_of_patients = models.IntegerField()
    patient_name = models.TextField(default = '')
    status = models.TextField(default='launched')

class PostInfoLifesaver(models.Model):
    incident = models.ForeignKey(Incident, on_delete=models.CASCADE, related_name= "post_incident_lifesaver")
    lifesaver = models.ForeignKey(Lifesaver, on_delete=models.CASCADE, related_name= "post_lifesaver")
    is_intervention = models.BooleanField()
    INTERVENTION_CHOICES = (
    ("CPR", "CPR"),
    ("Bleeding Control", "Bleeding Control"),
    ("Both", "Both"),
    )
    intervention = models.CharField(max_length=20, choices=INTERVENTION_CHOICES, default='CPR')
    taken_to_hospital = models.BooleanField(default=False)
    details = models.TextField(blank=True, default='')

class PostInfoCitizen(models.Model):
    incident = models.ForeignKey(Incident, on_delete=models.CASCADE, related_name= "post_incident_citizen")
    citizen = models.ForeignKey(Citizen, on_delete=models.CASCADE, related_name= "post_citizen")
    INTERVENTION_CHOICES = (
    ("CPR", "CPR"),
    ("Bleeding Control", "Bleeding Control"),
    ("Both", "Both"),
    )
    intervention = models.CharField(max_length=20, choices=INTERVENTION_CHOICES, default='CPR')
    name_of_patients= models.TextField(default='', blank=True)
    details = models.TextField()
    lifesaver_rating = models.FloatField()

class Request(models.Model):
    incident = models.ForeignKey(Incident, on_delete=models.CASCADE, related_name= "request_incident")
    lifesaver = models.ForeignKey(Lifesaver, on_delete=models.CASCADE, related_name= "request_lifesaver", null=True)
    is_active = models.BooleanField(default=True)
