from django.shortcuts import render
from api.models import * 
import json
from datetime import timedelta
from django.utils import timezone
from django.http import HttpResponseRedirect
from django.urls import reverse


def login_auth(request):
    return render(request, "dashboard/authentication-login.html")

# Create your views here.
def index(request):
    u = Lifesaver.objects.all()
    tdict = {}
    tdict['lifesavers'] = []
    tdict['citizens'] = []
    tdict['statistics'] = {}
    last_week = timezone.now() - timedelta(days=7)
    last_month = timezone.now() - timedelta(days=30)

    lifes_t = len(u)
    tdict['statistics']['totalLifesavers'] = lifes_t


    for x in u:
        if x.lifesaver.is_active:
            tdict['lifesavers'].append((x.first_name+" "+x.last_name, x.latitude, x.longitude))

    u2 = Incident.objects.all()

    inc = len(u2)
    tdict['statistics']['totalCalls'] = inc
   
    cases_addressed = 0
    percent_lives_saved_month = 0
    percent_lives_saved_week = 0
    lives_saved_last_week = 0 
    lives_saved_last_month = 0 
    currently_unattended = 0

    for y in u2:
        if y.status=='launched':
            tdict['citizens'].append((y.citizen.first_name+" "+y.citizen.last_name, y.latitude, y.longitude))
            if not y.lifesaver:
                currently_unattended+=1


        if y.status=='attended':
            cases_addressed+=1
            lives_saved_last_week = (Incident.objects.filter(created__gte=last_week)).count()
            lives_saved_last_month = (Incident.objects.filter(created__gte=last_month)).count()

    if percent_lives_saved_month>0:
        percent_lives_saved_month = (lives_saved_last_month/inc)*100 
        
    if percent_lives_saved_week>0:
        percent_lives_saved_week = (lives_saved_last_week/inc)*100
        
    
    tdict['statistics']['casesAddressed'] = cases_addressed
    tdict['statistics']['livesSavedWeek'] = (lives_saved_last_week, percent_lives_saved_week)
    tdict['statistics']['livesSavedMonth'] = (lives_saved_last_month, percent_lives_saved_month)
    tdict['statistics']['unattended'] = currently_unattended
        

    context = {
        'my_dict_json': json.dumps(tdict),
        'tdict': tdict,
    }

    return render(request, 'dashboard/index.html', context)


def charts(request):
    return render(request, 'dashboard/charts.html')


def widgets(request):
    return render(request, 'dashboard/widgets.html')

def terminate_lifesavers(request):
    if request.method == 'POST':
        selected_lifesavers = request.POST.getlist('selected_lifesavers')
        for id in selected_lifesavers:
            lifesaver = Lifesaver.objects.get(id = id)
            lifesaver.lifesaver.is_active = False
            lifesaver.save()
    return HttpResponseRedirect('/dashboard/tables/')
    

def tables(request):
    u = Lifesaver.objects.all()
    tdict = {}
    for y in u:
        idlife = str(y.training_id)
        tdict[idlife] = {}
        tdict[idlife]['fname'] = y.first_name
        tdict[idlife]['lname'] = y.last_name
        tdict[idlife]['cnic'] = y.cnic
        tdict[idlife]['callReceived'] = y.calls_received
        tdict[idlife]['badge'] = y.badge


    context = {
        'my_dict_json': json.dumps(tdict),
        'tdict': tdict,
    }
    print(tdict)
    return render(request, "dashboard/tables.html", context)





def grid(request):
    return render(request, "dashboard/grid.html")




def form_basic(request):
    return render(request, "dashboard/form_basic.html")




def form_wizard(request):
    return render(request, "dashboard/form_wizard.html")




def buttons(request):
    return render(request, "dashboard/buttons.html")




def icon_material(request):
    return render(request, "dashboard/icon-material.html")




def icon_fontawesome(request):
    return render(request, "dashboard/icon-fontawesome.html")




def elements(request):
    return render(request, "dashboard/elements.html")




def gallery(request):
    return render(request, "dashboard/gallery.html")





def invoice(request):
    return render(request, "dashboard/invoice.html")



def chat(request):
    return render(request, "dashboard/chat.html")

