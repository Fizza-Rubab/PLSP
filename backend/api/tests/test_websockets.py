from channels.db import database_sync_to_async
from django.contrib.auth import get_user_model
from rest_framework_simplejwt.tokens import AccessToken
from channels.testing import WebsocketCommunicator
import pytest
from backend.asgi import application
from channels.layers import get_channel_layer
from django.contrib.auth.models import Group, User 

TEST_CHANNEL_LAYERS = {
    'default': {
        'BACKEND': 'channels.layers.InMemoryChannelLayer',
    },
}

@database_sync_to_async
def create_user(username, password, group='rider'):
    # Create user.
    user = get_user_model().objects.create_user(
        username,
        password
    )

    # Create user group.
    # my_group = Group.objects.get(name=group) 
    # my_group.user_set.add(user)
    user_group, _ = Group.objects.get_or_create(name=group) # new
    user_group.user_set.add(user)
    user.save()

    # Create access token.
    access = AccessToken.for_user(user)

    return user, access


@pytest.mark.asyncio
@pytest.mark.django_db(transaction=True)
class TestWebSocket:
    
    async def test_can_connect_to_server(self, settings):
        settings.CHANNEL_LAYERS = TEST_CHANNEL_LAYERS
        _, access = await create_user('test.user@example.com','pAssw0rd')
        communicator = WebsocketCommunicator(
            application=application,
            path=f'/api/?token={access}' # changed
        )
        connected, _ = await communicator.connect()
        assert connected is True
        await communicator.disconnect()

    async def test_can_send_and_receive_messages(self, settings):
        settings.CHANNEL_LAYERS = TEST_CHANNEL_LAYERS
        _, access = await create_user(  # new
            'test.user@example.com', 'pAssw0rd'
        )
        communicator = WebsocketCommunicator(
            application=application,
            path=f'/api/?token={access}'
        )
        await communicator.connect()
        message = {
            'type': 'echo.message',
            'data': 'This is a test message.',
        }
        await communicator.send_json_to(message)
        response = await communicator.receive_json_from()
        assert response == message
        await communicator.disconnect()

    async def test_join_driver_pool(self, settings):
        settings.CHANNEL_LAYERS = TEST_CHANNEL_LAYERS
        _, access = await create_user(
            'test.user@example.com', 'pAssw0rd', 'driver'
        )
        communicator = WebsocketCommunicator(
            application=application,
            path=f'/api/?token={access}'
        )
        connected, _ = await communicator.connect()
        message = {
            'type': 'echo.message',
            'data': 'This is a test message.',
        }
        channel_layer = get_channel_layer()
        await channel_layer.group_send('drivers', message=message)
        response = await communicator.receive_json_from()
        assert response == message
        await communicator.disconnect()
    
        
    # async def test_can_send_and_receive_broadcast_messages(self, settings):
    #     settings.CHANNEL_LAYERS = TEST_CHANNEL_LAYERS
    #     _, access = await create_user(  # new
    #         'test.user@example.com', 'pAssw0rd'
    #     )
    #     communicator = WebsocketCommunicator(
    #         application=application,
    #         path=f'/api/?token={access}'
    #     )
    #     await communicator.connect()
    #     message = {
    #         'type': 'echo.message',
    #         'data': 'This is a test message.',
    #     }
    #     channel_layer = get_channel_layer()
    #     await channel_layer.group_send('test', message=message)
    #     response = await communicator.receive_json_from()
    #     assert response == message
    #     await communicator.disconnect()
    
    
    async def test_cannot_connect_to_socket(self, settings):
        settings.CHANNEL_LAYERS = TEST_CHANNEL_LAYERS
        communicator = WebsocketCommunicator(
            application=application,
            path='/api/'
        )
        connected, _ = await communicator.connect()
        assert connected is False
        await communicator.disconnect()