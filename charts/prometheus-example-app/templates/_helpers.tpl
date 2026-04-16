{{- define "prometheus-example-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "prometheus-example-app.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "prometheus-example-app.labels" -}}
{{ include "prometheus-example-app.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "prometheus-example-app.image" -}}
{{- printf "%s:%s" .Values.image.repository .Values.image.tag -}}
{{- end }}

{{- define "prometheus-example-app.renderStringMap" -}}
{{- range $key, $value := . -}}
{{ printf "%s: %s\n" $key ($value | quote) }}
{{- end -}}
{{- end }}
