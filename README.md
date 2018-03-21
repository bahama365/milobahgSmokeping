# Docker Smokeping

Docker image running Smokeping and Apache using Supervisord, defaults set to pinging Google.com every 20s. Edit the config.d/Targets file when building to add a new target.

docker run -p 80:80 -d --name smokeping milobahg/smokeping:latest
