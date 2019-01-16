{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "tree-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tree-helm.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tree-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "treeservice.mongodbcache.bindip" -}}
{{- $match := .Values.treeservice.mongodbcache.uri | toString | regexFind "//.*:" | trimAll ":" | trimAll "/" -}}
{{- if eq $match "localhost" -}}
"127.0.0.1"
{{- else -}}
{{- $match -}}
{{- end -}}
{{- end -}}

{{- define "treeservice.mongodbcache.port" -}}
{{- .Values.treeservice.mongodbcache.uri | toString | regexFind "(?:[^:]+)$" -}}
{{- end -}}

{{- define "treeservice.host.port" -}}
{{- .Values.treeservice.host.port | toString | regexFind "(?:[^:]+)$" -}}
{{- end -}}

{{- define "treeservice.host" -}}
{{- .Values.treeservice.host.port | toString | regexFind ".*:" | trimAll ":" | quote -}}
{{- end -}}
# {{- printf "%s" .Values.treeservice.cachedb.uri | quote -}}


