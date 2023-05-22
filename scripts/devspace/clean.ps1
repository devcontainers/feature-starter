for($j=1; $j -le 5; $j++) {
  $containerid = docker ps -q -f name="${DEVCONTAINER_PROJECT_NAME}-devspace"
  if ($containerid) {
      docker rm -f $containerid
  }
  $volumes = docker volume ls -q -f name="${DEVCONTAINER_PROJECT_NAME}_devcontainer"
  if ($volumes) {
      $volumes | ForEach-Object { docker volume rm -f $_ }
  }

  docker container prune -f
  docker image prune -a -f
  docker network prune -f
  docker volume prune -f
}
