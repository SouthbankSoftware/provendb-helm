{{- define "apigatewayport" -}}
{{- $match := .Values.apigateway.host.port | toString | regexFind ":.*" | trimAll ":" -}}
{{- $match -}}
{{- end -}}
