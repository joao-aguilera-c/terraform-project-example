import requests

def lambda_handler(event, context):
    print("Hello World!")
    response = requests.get("https://www.google.com")
    print(response.status_code)