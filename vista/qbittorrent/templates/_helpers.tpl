{{/*
Copyright Vista Yih.
SPDX-License-Identifier: APACHE-2.0
*/}}

{{/*
Return the proper qbittorrent image name
*/}}
{{- define "qbittorrent.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "qbittorrent.volumePermissions.image" -}}
{{- include "common.images.image" ( dict "imageRoot" .Values.volumePermissions.image "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "qbittorrent.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image .Values.volumePermissions.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Return  the proper Storage Class
*/}}
{{- define "qbittorrent.storageClass" -}}
{{- include "common.storage.class" (dict "persistence" .Values.persistence "global" .Values.global) -}}
{{- end -}}

{{/*
qbittorrent credential secret name
*/}}
{{- define "qbittorrent.secretName" -}}
{{- coalesce .Values.existingSecret (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
qbittorrent root URL
*/}}
{{- define "qbittorrent.rootURL" -}}
{{- if .Values.rootURL -}}
    {{- print .Values.rootURL -}}
{{- else if .Values.ingress.enabled -}}
    {{- printf "http://%s" .Values.ingress.hostname -}}
{{- else if (and (eq .Values.service.type "LoadBalancer") .Values.service.loadBalancerIP) -}}
    {{- $url := printf "http://%s" .Values.service.loadBalancerIP -}}
    {{- $port:= .Values.service.ports.http | toString }}
    {{- if (ne $port "80") -}}
        {{- $url = printf "%s:%s" $url $port -}}
    {{- end -}}
    {{- print $url -}}
{{- end -}}
{{- end -}}

{{/*
 Create the name of the service account to use
 */}}
{{- define "qbittorrent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{- default (include "common.names.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
    {{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{/*
qbittorrent credential secret name
*/}}
{{- define "qbittorrent.secretKey" -}}
{{- if .Values.existingSecret -}}
    {{- print .Values.existingSecretKey -}}
{{- else -}}
    {{- print "admin-password" -}}
{{- end -}}
{{- end -}}
