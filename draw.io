  GNU nano 7.2                                  docker-compose.yml *                                         
#This compose file adds draw.io to your stack
#version: '3.5'
services:
  drawio:
    image: jgraph/drawio
    container_name: drawio
    restart: unless-stopped
    ports:
      - 8080:8080
      - 8443:8443
    environment:
      PUBLIC_DNS: domain
      ORGANISATION_UNIT: unit
      ORGANISATION: org
      CITY: city
      STATE: state
      COUNTRY_CODE: country
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://domain:8080 || exit 1"]
      interval: 1m30s
      timeout: 10s
      retries: 5
      start_period: 10s














^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^/ Go To Line  M-E Redo
