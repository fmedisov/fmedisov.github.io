{{/* vim: set filetype=mustache: */}}

{{/*
Selector labels
*/}}
{{- define "mse-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Chart name and version as used by the chart label
*/}}
{{- define "mse-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mse-chart.labels" -}}
helm.sh/chart: {{ include "mse-chart.chart" . }}
{{ include "mse-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Annotation to update pods on Secrets or ConfigMaps updates
*/}}
{{- define "mse-chart.propertiesHash" -}}
{{- $secrets := include (print $.Template.BasePath "/secrets.yaml") . | sha256sum -}}
{{- $urlConfig := include (print $.Template.BasePath "/urls-config.yaml") . | sha256sum -}}
{{ print $secrets $urlConfig | sha256sum }}
{{- end -}}

{{/*
Name of the service account to use
*/}}
{{- define "mse-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-") .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Names of backend tier components
*/}}
{{- define "mse-chart.backend.defaultName" -}}
{{- printf "backend-%s" .Release.Name -}}
{{- end -}}

{{- define "mse-chart.backend.deployment.name" -}}
{{- default (include "mse-chart.backend.defaultName" .) .Values.backend.deployment.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mse-chart.backend.container.name" -}}
{{- default (include "mse-chart.backend.defaultName" .) .Values.backend.container.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mse-chart.backend.service.name" -}}
{{- default (include "mse-chart.backend.defaultName" .) .Values.backend.service.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mse-chart.backend.hpa.name" -}}
{{- default (include "mse-chart.backend.defaultName" .) .Values.backend.hpa.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Names of gate tier components
*/}}
{{- define "mse-chart.gate.defaultName" -}}
{{- printf "gate-%s" .Release.Name -}}
{{- end -}}

{{- define "mse-chart.gate.deployment.name" -}}
{{- default (include "mse-chart.gate.defaultName" .) .Values.gate.deployment.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mse-chart.gate.container.name" -}}
{{- default (include "mse-chart.gate.defaultName" .) .Values.gate.container.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mse-chart.gate.service.name" -}}
{{- default (include "mse-chart.gate.defaultName" .) .Values.gate.service.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mse-chart.gate.hpa.name" -}}
{{- default (include "mse-chart.gate.defaultName" .) .Values.gate.hpa.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Names of other components
*/}}
{{- define "mse-chart.secrets.defaultName" -}}
{{- printf "secrets-%s" .Release.Name -}}
{{- end -}}

{{- define "mse-chart.urlConfig.defaultName" -}}
{{- printf "url-config-%s" .Release.Name -}}
{{- end -}}