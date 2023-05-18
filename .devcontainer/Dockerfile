# https://docs.docker.com/engine/reference/builder/
# https://github.com/devcontainers/images/tree/main/src/base-debian
# https://github.com/dotnet/dotnet-docker/tree/main/src/runtime-deps
ARG IMAGE=ubuntu:latest
FROM ${IMAGE}
COPY src/docker/entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# https://docs.docker.com/engine/reference/builder/#entrypoint
# https://stackoverflow.com/questions/21553353/what-is-the-difference-between-cmd-and-entrypoint-in-a-dockerfile
ENTRYPOINT ["docker-entrypoint.sh"]
# https://docs.docker.com/engine/reference/builder/#cmd
# https://riptutorial.com/docker/example/11009/cmd-instruction
# https://devopscube.com/keep-docker-container-running/
# Overrides default command so things don't shut down after the process ends.
CMD ["sleep", "infinity"]
