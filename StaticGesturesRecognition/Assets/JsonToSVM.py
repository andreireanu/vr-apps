# code addapted from https://stackoverflow.com/questions/21708192/how-do-i-use-the-json-module-to-read-in-one-json-object-at-a-time

from json import JSONDecoder
from functools import partial


def json_parse(fileobj, decoder=JSONDecoder(), buffersize=2048):
    buffer = ''
    for chunk in iter(partial(fileobj.read, buffersize), ''):
         buffer += chunk
         while buffer:
             try:
                 result, index = decoder.raw_decode(buffer)
                 yield result
                 buffer = buffer[index:].lstrip()
             except ValueError:
                 # Not enough data to decode, read more
                 break

text_file = open("TrainData.txt", "a")

with open('TrainDataJson.json', 'r') as infh:
    for data in json_parse(infh):
        # process object
        s = '{} 1:{} 2:{} 3:{} 4:{} 5:{} 6:{} 7:{} 8:{} 9:{} \n'.format(
                    data['v0'], data['v1'], data['v2'], data['v3'],
                    data['v4'], data['v5'], data['v6'], data['v7'],
                    data['v8'], data['v9'])
        text_file.write(s)
