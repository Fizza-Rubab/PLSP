import json
from channels.generic.websocket import WebsocketConsumer
from asgiref.sync import async_to_sync
from .models import Lifesaver
from django.contrib.auth import get_user_model

class LifesaverConsumer(WebsocketConsumer):
    def connect(self):
        self.accept()

    def receive(self, text_data):
        data = json.loads(text_data)
        try:
            user_id = data["user_id"]
            ls = Lifesaver.objects.get(id=user_id)
            ls.latitude = data['latitude']
            ls.longitude = data['longitude']
            ls.save()
            self.send(text_data=json.dumps({
            'type':'chat',
            'message':"Lifesaver location has been updated"
            }))
        except Exception as e:
            self.send(text_data=json.dumps({
            'type':'chat',
            'message':"Some issue " + str(e)
            }))

    def chat_message(self, event):
        message = event['message']

        self.send(text_data=json.dumps({
            'type':'chat',
            'message':message
        }))