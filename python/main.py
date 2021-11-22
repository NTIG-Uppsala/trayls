import json

# read file
myjsonfile=open('walking-motivation\python\location.json', 'r')
jsondata=myjsonfile.read()

# parse
obj=json.loads(jsondata)    

print(str(obj['uppsala','']))