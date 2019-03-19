#!/bin/sh
docker run -it -v /Users/sandip:/root/sandip -e INSTANCE_FILE=/etc/config/instance_data.json -e AWS_SECRET_ACCESS_KEY=abcdedg -e AWS_ACCESS_KEY_ID=testabced cogniac/dynalite:tests sh
