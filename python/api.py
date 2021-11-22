import requests

response = requests.get("http://randomfox.ca/floof")

print(response.status_code)