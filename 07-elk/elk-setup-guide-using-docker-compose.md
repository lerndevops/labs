# Practical ELK Dashboard Guide

# Objective

Build a realistic ELK monitoring stack with:

- Live logs
- Kibana dashboards
- Payment failures
- Security analytics
- Kubernetes-style monitoring
- Real-time visualizations

---

# Step1: VM Preparation

## Recommended VM

| Resource | Recommended |
|---|---|
| OS | Ubuntu 22.04 |
| CPU | 4 vCPU |
| RAM | 8 GB |
| Disk | 40 GB |

---

# Step2: Install Docker

## Install Docker & Docker Compose

```bash
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
sudo chmod 755 /tmp/installDocker.sh
sudo bash /tmp/installDocker.sh
```

Verify:

```bash
docker --version
docker-compose --version
```

---

# Step3. Create ELK Project

## Create Working Directory

```bash
mkdir -p ~/elk-demo

cd ~/elk-demo
```

---

## Create Required Folders

```bash
mkdir -p logstash/pipeline

mkdir -p filebeat
```

---

# Step4 — Deploy ELK Stack

## Create docker-compose.yml

```bash
vi docker-compose.yml
```

Paste:

```yaml
version: '3.8'

services:

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.13.4
    container_name: elasticsearch
    restart: always
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
      - ES_JAVA_OPTS=-Xms2g -Xmx2g
    ports:
      - "9200:9200"

  logstash:
    image: docker.elastic.co/logstash/logstash:8.13.4
    container_name: logstash
    restart: always
    ports:
      - "5044:5044"
    volumes:
      - ./logstash/pipeline:/usr/share/logstash/pipeline

  kibana:
    image: docker.elastic.co/kibana/kibana:8.13.4
    container_name: kibana
    restart: always
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    ports:
      - "5601:5601"

  filebeat:
    image: docker.elastic.co/beats/filebeat:8.13.4
    container_name: filebeat
    user: root
    restart: always
    volumes:
      - ./filebeat/filebeat.yml:/usr/share/filebeat/filebeat.yml
      - /var/log:/var/log:ro
```

---

# Step5 — Configure Logstash

## Create Logstash Pipeline

```bash
vi logstash/pipeline/logstash.conf
```

Paste:

```conf
input {
  beats {
    port => 5044
  }
}

filter {

  json {
    source => "message"
  }

  date {
    match => ["timestamp", "ISO8601"]
  }

}

output {

  elasticsearch {
    hosts => ["http://elasticsearch:9200"]
    index => "ecommerce-logs-%{+YYYY.MM.dd}"
  }

}
```

---

# Step6 — Configure Filebeat

## Create Filebeat Config

```bash
vi filebeat/filebeat.yml
```

Paste:

```yaml
filebeat.inputs:
  - type: filestream
    enabled: true
    paths:
      - /var/log/ecommerce-app.log

output.logstash:
  hosts: ["logstash:5044"]
```

---

# Step7 — Start ELK Stack

## Start Containers

```bash
docker compose up -d
```

Verify:

```bash
docker ps
```

---

# Step8 — Verify ELK Stack

## Test Elasticsearch

```bash
curl http://localhost:9200
```

---

## Open Kibana

Open:

```text
http://<VM-IP>:5601
```

Wait 2–3 minutes for first startup.

---

# Step9 — Generate Realistic Logs

## Create Log Generator

```bash
vi generate-logs.sh
```

Paste:

```bash
#!/bin/bash

LOG_FILE=/var/log/ecommerce-app.log

SERVICES=("payment" "orders" "inventory" "auth" "shipping")
LEVELS=("INFO" "WARN" "ERROR")
USERS=("ravi" "naresh" "radha" "niha" "surya")
STATUS=("SUCCESS" "FAILED")

while true
do

  SERVICE=${SERVICES[$RANDOM % ${#SERVICES[@]}]}
  LEVEL=${LEVELS[$RANDOM % ${#LEVELS[@]}]}
  USER=${USERS[$RANDOM % ${#USERS[@]}]}
  RESULT=${STATUS[$RANDOM % ${#STATUS[@]}]}

  RESPONSE_TIME=$((RANDOM % 3000))
  ORDER_VALUE=$((RANDOM % 50000))

  IP="192.168.1.$((RANDOM % 255))"

  echo "{\"timestamp\":\"$(date -Iseconds)\",\"service\":\"$SERVICE\",\"level\":\"$LEVEL\",\"user\":\"$USER\",\"status\":\"$RESULT\",\"response_time\":$RESPONSE_TIME,\"order_value\":$ORDER_VALUE,\"client_ip\":\"$IP\"}" >> $LOG_FILE

  sleep 1

done
```

---

## Make Executable

```bash
chmod +x generate-demo-logs.sh
```

---

## Run Generator

```bash
sudo ./generate-demo-logs.sh
```

Keep it running.

---

# Step10 — Verify Logs

## Check Elasticsearch Indices

```bash
curl "http://localhost:9200/_cat/indices?v"
```

Expected:

```text
ecommerce-logs-*
```

---

# Step11 — Configure Kibana

## Create Data View

Navigate:

```text
Stack Management
→ Data Views
→ Create Data View
```

Create:

```text
ecommerce-logs-*
```

Timestamp field:
- @timestamp

Save.

---

# Step12 — Create Dashboard 1

# Application Monitoring Dashboard

---

## Create Total Requests Widget

### Navigate

```text
Analytics
→ Dashboard
→ Create Dashboard
→ Create Visualization
```

Select:
- Lens

---

### Configure

Visualization:
- Metric

Metric:
- Count

Save as:

```text
Total Requests
```

---

## Create Average Response Time Widget

Visualization:
- Metric

Metric:
- Average

Field:
- response_time

Save:
- Avg Response Time

---

## Create Log Levels Chart

Visualization:
- Donut Chart

Field:
- level.keyword

Save:
- Log Levels

---

## Create Services Distribution

Visualization:
- Pie Chart

Field:
- service.keyword

Save:
- Services Distribution

---

## Create Response Time Trend

Visualization:
- Line Chart

X-axis:
- @timestamp

Y-axis:
- Average response_time

Save:
- Response Time Trend

---

# Dashboard Layout

Suggested:

```text
------------------------------------------------
| Total Requests | Avg Response Time           |
------------------------------------------------
| Log Levels     | Services Distribution       |
------------------------------------------------
| Response Time Trend                          |
------------------------------------------------
```

Save Dashboard:

```text
E-Commerce Monitoring Dashboard
```

---

# Step 13 — Create Payment Dashboard

# Payment Monitoring Dashboard

---

## Failed Payments Widget

Visualization:
- Metric

Filter:

```text
service:payment AND status:FAILED
```

Save:
- Failed Payments

---

## High Latency Payments

Visualization:
- Data Table

Filter:

```text
response_time > 2000
```

Columns:
- service
- response_time
- status

Save:
- High Latency Transactions

---

## Payment Success vs Failed

Visualization:
- Pie Chart

Filter:

```text
service:payment
```

Split by:
- status.keyword

Save:
- Payment Status Distribution

---

# Step14 — Create Security Dashboard

# Security Monitoring Dashboard

---

## Failed Authentication Attempts

Visualization:
- Metric

Filter:

```text
service:auth AND status:FAILED
```

Save:
- Failed Auth Attempts

---

## Top Client IPs

Visualization:
- Bar Chart

Field:
- client_ip.keyword

Save:
- Top Client IPs

---

## Authentication Errors Timeline

Visualization:
- Line Chart

Filter:

```text
service:auth AND level:ERROR
```

Save:
- Auth Error Timeline

---

# Step15 — Create Kubernetes Dashboard

# Kubernetes Monitoring Dashboard

---

## Inject Kubernetes Logs

Run:

```bash
echo '{"timestamp":"2026-05-25T10:00:00Z","namespace":"production","pod":"payment-api-123","container":"payment","status":"CrashLoopBackOff"}' >> /var/log/ecommerce-app.log
```

---

## Create Pod Failures Widget

Visualization:
- Metric

Filter:

```text
status:CrashLoopBackOff
```

Save:
- Pod Failures

---

## Namespace Distribution

Visualization:
- Pie Chart

Field:
- namespace.keyword

Save:
- Namespace Distribution

---

## Pod Failures Timeline

Visualization:
- Line Chart

Filter:

```text
status:CrashLoopBackOff
```

Save:
- Pod Failure Timeline

---

# Step17 — Simulate Incidents

## Inject ERROR Logs

Run:

```bash
echo '{"timestamp":"2026-05-25T10:00:00Z","service":"payment","level":"ERROR","status":"FAILED","response_time":2800}' >> /var/log/ecommerce-app.log
```

Observe:
- Dashboard spikes
- Failed transactions
- Error increases

---

# Step18 — Enable Auto Refresh

In Kibana:

Top right corner:
- Refresh every 5 seconds

Dashboards become live.
