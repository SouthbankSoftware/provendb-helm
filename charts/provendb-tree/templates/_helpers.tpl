
{{- define "mongodbcache.bindip" -}}
{{- $match := .Values.mongodbcache.bindip | toString | regexFind "//.*:" | trimAll ":" | trimAll "/" -}}
{{- if eq $match "localhost" -}}
"127.0.0.1"
{{- else -}}
{{- $match -}}
{{- end -}}
{{- end -}}

{{- define "mongodbcache.port" -}}
{{- .Values.mongodbcache.uri | toString | regexFind "(?:[^:]+)$" -}}
{{- end -}}

{{- define "host.port" -}}
{{- .Values.host.port | toString | regexFind "(?:[^:]+)$" -}}
{{- end -}}

{{- define "host" -}}
{{- .Values.host.port | toString | regexFind ".*:" | trimAll ":" | quote -}}
{{- end -}}
# {{- printf "%s" .Values.cachedb.uri | quote -}}

{{- define "baseName" -}}
{{- trimPrefix (printf "%s-" .Release.Namespace) .Release.Name -}}
{{- end -}}

