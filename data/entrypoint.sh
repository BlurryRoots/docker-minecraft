#!/bin/bash

# Copy server into data folder if it is not already there
test -f /data/minecraft_server.jar || cp /server/minecraft_server.jar /data
# And run the server
java -Xmx${srv_mem} -jar /data/minecraft_server.jar nogui
