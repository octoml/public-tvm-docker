
CPU_IMAGEBASENAME := "tvm"
GPU_IMAGEBASENAME := "tvm-gpu"
REGISTRYREPO := "octoml"
REGISTRY := "docker.io"

TVM_HASH := "5f4b9a96f49d40f3edc59941f8a1ba1b93bc28e7"

CPU_IMAGENAME := REGISTRY + "/" + REGISTRYREPO + "/" + CPU_IMAGEBASENAME
CPU_IMAGEFULL := CPU_IMAGENAME + ":" + TVM_HASH

GPU_IMAGENAME := REGISTRY + "/" + REGISTRYREPO + "/" + GPU_IMAGEBASENAME
GPU_IMAGEFULL := GPU_IMAGENAME + ":" + TVM_HASH

docker-build-cpu:
    docker build -t {{CPU_IMAGEFULL}} --build-arg TVM_HASH={{TVM_HASH}} - < Dockerfile.cpu_base

docker-build-gpu:
    docker build -t {{GPU_IMAGEFULL}} --build-arg TVM_HASH={{TVM_HASH}} - < Dockerfile.gpu_base

docker-push-cpu:
    docker push {{CPU_IMAGEFULL}}

docker-push-gpu:
    docker push {{GPU_IMAGEFULL}}

docker-push: docker-build-cpu docker-build-gpu
    docker push {{CPU_IMAGEFULL}}
    docker push {{GPU_IMAGEFULL}}

docker-push-latest: docker-build-cpu docker-build-gpu
    docker tag {{CPU_IMAGEFULL}} {{CPU_IMAGENAME + ":" + "latest"}}
    docker tag {{GPU_IMAGEFULL}} {{GPU_IMAGENAME + ":" + "latest"}}
    docker push {{CPU_IMAGENAME + ":" + "latest"}}
    docker push {{GPU_IMAGENAME + ":" + "latest"}}