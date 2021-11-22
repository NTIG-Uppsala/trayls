import json

# read file
myjsonfile=open('python\location.json', 'r')
jsondata=myjsonfile.read()

# parse
obj=json.loads(jsondata)    

print(str(obj['town']))
print(str(obj['name']))
print(str(obj['lat']))
print(str(obj['long']))
print(str(obj['spots'[1]]))
