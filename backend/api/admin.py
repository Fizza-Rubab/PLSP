from django.contrib import admin
from .models import Lifesaver, Incident, PostInfoCitizen, PostInfoLifesaver, Citizen, Request
from django.contrib.auth.admin import UserAdmin as DefaultUserAdmin
from .models import User


admin.register(User)
admin.site.register(Lifesaver)
admin.site.register(Citizen)
admin.site.register(Incident)
admin.site.register(PostInfoCitizen)
admin.site.register(PostInfoLifesaver)
admin.site.register(Request)
