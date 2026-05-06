from django.http import HttpResponse
from django.template import loader
from django.contrib.auth.models import User

def members(request):
    members = User.objects.all().values()
    template = loader.get_template('all_members.html')
    context = {
        'mymembers': members,
    }
    return HttpResponse(template.render(context,request))

def details(request, id):
    mymember = User.objects.get(id=id)
    template = loader.get_template('details.html')
    context = {
    'mymember': mymember,
    }
    return HttpResponse(template.render(context, request))

def main(request):
    template = loader.get_template('main.html')
    return HttpResponse(template.render())