{{/*
Expand the name of the chart.
*/}}
{{- define "edb-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "edb-operator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "edb-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "edb-operator.labels" -}}
helm.sh/chart: {{ include "edb-operator.chart" . }}
{{ include "edb-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "edb-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "edb-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Namespace name
*/}}
{{- define "edb-operator.namespace" -}}
{{- .Values.namespace.name }}
{{- end }}

{{/*
OperatorGroup name
*/}}
{{- define "edb-operator.operatorGroupName" -}}
{{- .Values.operatorGroup.name }}
{{- end }}

{{/*
Subscription name
*/}}
{{- define "edb-operator.subscriptionName" -}}
{{- .Values.subscription.name }}
{{- end }}
