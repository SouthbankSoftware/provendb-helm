{{- define "port" -}}
{{- $match := .Values.host.port | toString | regexFind ":.*" | trimAll ":" -}}
{{- $match -}}
{{- end -}}
