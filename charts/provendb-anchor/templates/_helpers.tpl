{{- define "baseName" -}}
{{- trimPrefix (printf "%s-" .Release.Namespace) .Release.Name -}}
{{- end -}}

