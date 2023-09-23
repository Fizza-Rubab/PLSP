import json
import time
from websocket import create_connection

ws = create_connection("ws://44.230.76.47:8000/ws/socket-server/")

start_lat = 24.8183118
start_lon = 67.065402

end_lat = 24.8191561
end_lon = 67.0666699

steps = 10

# Calculate the change in latitude and longitude for each time step
delta_lat = (end_lat - start_lat) / steps
delta_lon = (end_lon - start_lon) / steps

for i in range(steps):
    time.sleep(3)
    ws.send(json.dumps({"user_id": 4, "latitude": start_lat, "longitude": start_lon}))
    start_lat += delta_lat
    start_lon += delta_lon
    result = ws.recv()
    print(result)

ws.close()
