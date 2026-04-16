# prometheus-example-app

Helm chart for `quay.io/brancz/prometheus-example-app:v0.3.0`.

This is a community-maintained chart for testing Kubernetes monitoring setups.

```sh
helm install my-app ./charts/prometheus-example-app
```

```sh
kubectl port-forward svc/my-app-prometheus-example-app 8080:8080
curl http://localhost:8080/metrics
```

## Optional Monitoring

Pod annotations:

```yaml
pod:
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "8080"
    prometheus.io/path: /metrics
```

ServiceMonitor:

```yaml
serviceMonitor:
  enabled: true
  labels:
    release: prometheus
```

PodMonitor:

```yaml
podMonitor:
  enabled: true
  labels:
    release: prometheus
```

`ServiceMonitor` and `PodMonitor` are disabled by default. Enable them only when you want to test Prometheus Operator behavior; they require Prometheus Operator CRDs.

Optional annotations:

```yaml
deployment:
  annotations: {}

pod:
  annotations: {}

service:
  annotations: {}
```

Optional labels:

```yaml
deployment:
  labels: {}

pod:
  labels: {}

service:
  labels: {}
```

Optional runtime settings:

```yaml
imagePullSecrets: []
resources: {}
```

Optional Prometheus Operator resources:

```yaml
serviceMonitor:
  enabled: false
  annotations: {}
  labels: {}
  path: /metrics
  interval: 30s
  scrapeTimeout: 10s

podMonitor:
  enabled: false
  annotations: {}
  labels: {}
  path: /metrics
  interval: 30s
  scrapeTimeout: 10s
```
