# https://docs.docker.com/engine/reference/builder/
# https://github.com/devcontainers/images/tree/main/src/base-debian
# https://github.com/dotnet/dotnet-docker/tree/main/src/runtime-deps
ARG IMAGE=mcr.microsoft.com/devcontainers/base:ubuntu
FROM ${IMAGE}
COPY src/docker/entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
# https://docs.docker.com/engine/reference/builder/#cmd
# https://riptutorial.com/docker/example/11009/cmd-instruction
# https://devopscube.com/keep-docker-container-running/
# Overrides default command so things don't shut down after the process ends.
CMD ["sleep", "infinity"]
