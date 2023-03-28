import json
import time
from websocket import create_connection
ws = create_connection("ws://127.0.0.1:8000/ws/socket-server/")
latitude = 24.91468897389246
longitude = 67.13930578784817
while True:
    time.sleep(2)
    ws.send(json.dumps({"user_id":1, "latitude":latitude,"longitude":longitude}))
    latitude+=0.00000000000001    
    longitude+=0.00000000000001    
    result =  ws.recv()
    print(result)
ws.close()
