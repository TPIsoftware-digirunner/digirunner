FROM gcr.io/cloud-marketplace-tools/k8s/deployer_envsubst/onbuild:latest

ARG imageDigiRepo
ARG imageComposerRepo
ARG NAMESPACE
ARG imageDigiTag
ARG imageComposerTag
ARG TAG

COPY manifest /data/manifest
COPY schema.yaml /data-test/schema.yaml

RUN cat /data-test/schema.yaml \
    | env -i "TAG=$TAG" "PROJECT_NUM=$PROJECT_NUM" "imageDigiTag=$imageDigiTag" "imageComposerTag=$imageComposerTag" "imageComposerRepo=$imageComposerRepo" "imageDigiRepo=$imageDigiRepo" "NAMESPACE=$NAMESPACE" "NAME=$NAME" envsubst \
    > /data-test/schema.yaml.new \
    && mv /data-test/schema.yaml.new /data-test/schema.yaml

# ENTRYPOINT ["docker-entrypoint.sh"]
