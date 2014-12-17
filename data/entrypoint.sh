#!/bin/bash

# Copy server into data folder if it is not already there
(test -f /data/minecraft_server.jar || \
	echo "copying server" && cp /server/minecraft_server.jar /data) && \
# Unzip map and copy to data folder
(test -d /data/WorldOfKrepel-Captive || \
	echo "copying map data" && unzip -d /tmp /server/map.zip && \
	mv "Captive Minecraft" /data/WorldOfKrepel-Captive) && \
	# And run the server
	java -Xmx${srv_mem} -jar minecraft_server.jar nogui
