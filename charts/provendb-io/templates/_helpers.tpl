{{- define "apigatewayport" -}}
{{- $match := .Values.apigateway.host.port | toString | regexFind ":.*" | trimAll ":" -}}
{{- $match -}}
{{- end -}}

{{- define "dbfromuri" -}}
{{- $match := .Values.proxy.mongodb.uri | toString | regexFind "/[^/]+$" | trimAll "/" -}}
{{- $match -}}
{{- end -}}