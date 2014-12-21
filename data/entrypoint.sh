#!/bin/bash

# Copy server into data folder if it is not already there
(test -f /data/FTBServer-*.jar || \
	echo "copying server" && cp -r /server/* /data) && \
	# And run the server
	java -Xmx${srv_mem} -jar FTBServer-*.jar nogui
