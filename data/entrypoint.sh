#!/bin/bash

# Copy server into data folder if it is not already there
(test -f /data/minecraft_server.jar || \
	echo "copying server" && cp /server/minecraft_server.jar /data) && \
	# And run the server
	java -Xmx${srv_mem} -jar minecraft_server.jar nogui
