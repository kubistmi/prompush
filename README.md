# Prompush
This Rpackage is a simple wrapper to allow useRs to post job status to Prometheus.  
This publishing is done via pushgateway. An example follows:  

```{r}
library(prompush)

# job took 25 minutes
status("database", "update", "exec_time_s", c("scope" = "full", "delete_strategy"="truncate"), 25*60)
```

# Pushgateway
One of the easiest ways to setup a Prometheus with Pushgateway, is to use docker (and docker-compose).  
This approach was tested with following definitions:  

```{yaml}
# docker-compose.yaml
version: "3"

services:
  prometheus:
    image: prom/prometheus
    restart: unless-stopped
    user: root # this is considered a bad practise, but it ~sometimes~ doesn't work without sudo rights 
    ports:
      - "9090:9090"
    volumes:
      - "./prometheus.yaml:/etc/prometheus/prometheus.yml:Z"

  pushgateway:
    image: prom/pushgateway
    restart: unless-stopped
    ports:
      - "9091:9091"
```
```{yaml}
# prometheus.yaml
global:
  scrape_interval:     1m # how often to check the gateway

scrape_configs:
  - job_name: 'pushgateway'
    honor_labels: true
    static_configs:
      - targets: ['pushgateway:9091']
```
