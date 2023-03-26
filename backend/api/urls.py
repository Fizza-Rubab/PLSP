from django.urls import include, path
from .views import *
from rest_framework_simplejwt.views import TokenRefreshView # new
from rest_framework.authtoken import views

urlpatterns = [
    path('', lobby),
    path('lifesaver/register', LifesaverRegister.as_view(), name='lifesaver_register'),
    path('citizen/register', CitizenRegister.as_view(), name='citizen_register'),
    path('login/', LogInView.as_view(), name='login'), # new
    path('lifesaver', LifesaverGet.as_view()),
    path('lifesaver/<int:pk>', LifesaverGetUpdateDelete.as_view()),
    path('citizen', CitizenGet.as_view()),
    path('citizen/<int:pk>', CitizenGetUpdateDelete.as_view()),
    path('incident', IncidentGetCreate.as_view(), name='incident_list'),
    path('incident/<int:pk>', IncidentUpdateDelete.as_view()),
    path('incident/cit/<int:pk>', IncidentGetCitizen.as_view()),
    path('location/<str:lat>/<str:long>', RetrieveNearby.as_view()),
    path('request/<int:pk>', RequestUpdateDelete.as_view()),
    path('request/', RequestCreate.as_view()),
    path('postinfo', PostInfoGetCreate.as_view()),
    path('postinfo/<int:pk>', PostInfoUpdateDelete.as_view()),
]
