# prometheus-example-app

Helm chart for `quay.io/brancz/prometheus-example-app:v0.3.0`, a small app that exposes Prometheus metrics on `/metrics`.

This chart is meant for testing Kubernetes monitoring setups. By default it installs only a `Deployment` and a `Service`; monitoring integrations are opt-in.

This is a community-maintained chart and is not affiliated with the upstream app author or the `prometheus-community` project.

## Install

From the GitHub Helm repo:

```sh
helm repo add prometheus-example-app https://robinlant.github.io/prometheus-example-app
helm repo update
helm install my-app prometheus-example-app/prometheus-example-app
```

From this checkout:

```sh
helm install my-app ./charts/prometheus-example-app
```

## Quick Check

```sh
kubectl port-forward svc/my-app-prometheus-example-app 8080:8080
curl http://localhost:8080/
curl http://localhost:8080/metrics
```

## Optional Monitoring Modes

Annotation-based scraping:

```sh
helm install my-app ./charts/prometheus-example-app \
  --set-string pod.annotations."prometheus\.io/scrape"=true \
  --set-string pod.annotations."prometheus\.io/port"=8080 \
  --set-string pod.annotations."prometheus\.io/path"=/metrics
```

Prometheus Operator `ServiceMonitor`:

```sh
helm install my-app ./charts/prometheus-example-app \
  --set serviceMonitor.enabled=true \
  --set-string serviceMonitor.labels.release=prometheus
```

Prometheus Operator `PodMonitor`:

```sh
helm install my-app ./charts/prometheus-example-app \
  --set podMonitor.enabled=true \
  --set-string podMonitor.labels.release=prometheus
```

`ServiceMonitor` and `PodMonitor` are disabled by default. Enable them only when you want to test Prometheus Operator behavior; they require the Prometheus Operator CRDs to be installed in the cluster.

## Release Pipeline

- Pull requests run `helm lint` and `helm template`.
- Pushes to `main` publish the chart to the `gh-pages` branch.
- Bump `charts/prometheus-example-app/Chart.yaml` `version` for each release.
- Enable GitHub Pages from the `gh-pages` branch in repository settings.

One-time GitHub Pages setup:

```sh
git checkout --orphan gh-pages
git rm -rf .
git commit --allow-empty -m "Initialize gh-pages"
git push origin gh-pages
git checkout main
```

Then configure repository settings: Pages -> Deploy from a branch -> `gh-pages` / `/ (root)`.

## License

[MIT](./LICENSE)

The upstream application is maintained separately at <https://github.com/brancz/prometheus-example-app>.
