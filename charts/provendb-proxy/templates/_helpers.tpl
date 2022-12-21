{{- define "baseName" -}}
{{- trimPrefix (printf "%s-" .Release.Namespace) .Release.Name -}}
{{- end -}}

{{- define "serviceID" -}}
{{- with trimPrefix (printf "%s-provendb-proxy" .Release.Namespace) .Release.Name}}{{trimPrefix "-" .}}{{else}}default{{end -}}
{{- end -}}
