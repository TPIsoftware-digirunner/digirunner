FROM gcr.io/cloud-marketplace-tools/k8s/deployer_envsubst/onbuild:latest

ARG imageDigiRepo
ARG imageComposerRepo

COPY manifest /data/manifest
COPY schema.yaml /data-test/schema.yaml

RUN cat /data-test/schema.yaml \
    | env -i "PROJECT_NUM=$PROJECT_NUM" "imageComposerRepo=$imageComposerRepo" "imageDigiRepo=$imageDigiRepo" "NAMESPACE=$NAMESPACE" "NAME=$NAME" envsubst \
    > /data-test/schema.yaml.new \
    && mv /data-test/schema.yaml.new /data-test/schema.yaml
