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
    path('lifesaver/upload_photo/<int:lifesaver_id>', GetUploadImageLifesaver.as_view()),
    path('lifesaver/<int:pk>', LifesaverGetUpdateDelete.as_view()),
    path('citizen', CitizenGet.as_view()),
    path('citizen/upload_photo/<int:citizen_id>', GetUploadImageCitizen.as_view()),
    path('citizen/<int:pk>', CitizenGetUpdateDelete.as_view()),
    # path('citizen/token/<int:pk>', CitizenUpdateToken.as_view()),
    # path('lifesaver/token/<int:pk>', LifesaverUpdateToken.as_view()),
    path('incident', IncidentGetCreate.as_view(), name='incident_list'),
    path('incident/<int:pk>', IncidentUpdateDelete.as_view()),
    path('incident/cit/<int:pk>', IncidentGetCitizen.as_view()),
    path('location/<str:lat>/<str:long>', RetrieveNearby.as_view()),
    path('request/<int:pk>', RequestUpdateDelete.as_view()),
    path('request/', RequestCreate.as_view()),
    path('postinfo/citizen', PostInfoCitizenGetCreate.as_view()),
    path('postinfo/citizen/<int:pk>', PostInfoCitizenUpdateDelete.as_view()),
    path('postinfo/lifesaver', PostInfoLifesaverGetCreate.as_view()),
    path('postinfo/lifesaver/<int:pk>', PostInfoLifesaverUpdateDelete.as_view()),
    path('incident/citizen/<int:citizen_id>/', CitizenHistory.as_view(), name='incident-list-by-citizen'),
    path('incident/lifesaver/<int:lifesaver_id>/', LifesaverHistory.as_view(), name='incident-list-by-lifesaver'),
    path('incident/<int:request_id>/accept/<int:lifesaver_id>', AcceptRequest.as_view(), name='accept-request'),
    path('incident/<int:incident_id>/status', DidAcceptIncident.as_view(), name='poll-status'),
    
]
