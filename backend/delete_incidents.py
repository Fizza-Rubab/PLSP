import requests
import time
lst = [i for i in range(303, 371)]
for i in lst:
    try:
        r = requests.delete('http://44.230.76.47:8000/incident/'+str(i))
        print(i, r)
        time.sleep(1)
    except Exception as e:
        print(e)
# import redis
# print(redis.Redis(host='localhost', port=6379, db=0))