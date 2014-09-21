### Install and run

```bash
docker pull vdubyna/docker-teamcity-agent-php
docker run -e TEAMCITY_SERVER=http://dubyna.in.ua:8111 -dt vdubyna/docker-teamcity-agent-php:latest
```

If you want to run multiple agents, then set unique name for each one

```bash
docker run -e AGENT_NAME=UniqueAgentName -e TEAMCITY_SERVER=http://dubyna.in.ua:8111 -dt vdubyna/docker-teamcity-agent-php:latest
```
