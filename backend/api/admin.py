from django.contrib import admin
from .models import Lifesaver, Incident, PostInfo, Citizen, Request
from django.contrib.auth.admin import UserAdmin as DefaultUserAdmin
from .models import User


admin.register(User)
admin.site.register(Lifesaver)
admin.site.register(Citizen)
admin.site.register(Incident)
admin.site.register(PostInfo)
admin.site.register(Request)
