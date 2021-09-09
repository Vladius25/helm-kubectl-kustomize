FROM alpine:latest as downloader

ENV KUSTOMIZE_VER=4.3.0

RUN apk add curl tar
RUN curl -sLO "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VER}/kustomize_v${KUSTOMIZE_VER}_linux_amd64.tar.gz"
RUN tar xzf ./kustomize_v${KUSTOMIZE_VER}_linux_amd64.tar.gz

FROM lwolf/helm-kubectl-docker:v1.20.5-v3.5.3

COPY --from=downloader kustomize /bin/
RUN chmod +x /bin/kustomize

CMD ["helm"]

