# https://docs.docker.com/engine/reference/builder/
# https://github.com/devcontainers/images/tree/main/src/base-debian
# https://github.com/dotnet/dotnet-docker/tree/main/src/runtime-deps
ARG IMAGE=mcr.microsoft.com/devcontainers/base:ubuntu
FROM ${IMAGE}
COPY scripts/docker/ /usr/local/bin/
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN create-user.sh $USERNAME $USER_UID $USER_GID
USER $USERNAME
COPY --chown=vscode:vscode ./ /devspaces/devcontainer/
COPY --chown=vscode:vscode package.json /home/vscode
ENTRYPOINT ["entrypoint.sh"]
# https://docs.docker.com/engine/reference/builder/#cmd
# https://riptutorial.com/docker/example/11009/cmd-instruction
# https://devopscube.com/keep-docker-container-running/
# Overrides default command so things don't shut down after the process ends.
CMD ["sleep", "infinity"]
