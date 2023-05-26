@ECHO OFF
setlocal
@rem Update submodules
pushd %DEVCONTAINER_FEATURES_PROJECT_ROOT%%
git submodule sync --recursive
git submodule update --init --recursive
git submodule foreach --recursive git checkout main
git submodule foreach --recursive git pull
popd
