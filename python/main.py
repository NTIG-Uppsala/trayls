import json

# read file
myjsonfile=open('python\location.json', 'r')
jsondata=myjsonfile.read()

# parse
obj=json.loads(jsondata)    

print(str(obj['firstName']))
print(str(obj['lastName']))
print(str(obj['address']))