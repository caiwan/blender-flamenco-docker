#!/bin/sh

cd /manager 

if [ ! -f ./flamenco-manager.yaml ]; then
    echo Basszameg
    mv ./flamenco-manager.empty.yaml ./flamenco-manager.yaml
    echo python params.py -f ./flamenco-manager.yaml -k /manager_name -v "${FLAMENCO_MANAGER_NAME}"
    echo python params.py -f ./flamenco-manager.yaml -k /own_url -v "${FLAMENCO_OWN_URL}"
    echo python params.py -f ./flamenco-manager.yaml -k /flamenco -v "${FLAMENCO_SERVER}"
fi

ls
cat flamenco-manager.yaml

./flamenco-manager
