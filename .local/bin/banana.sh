#!/bin/bash

function my_readlink() {
    cd $1
    pwd
    cd - > /dev/null
}

function cat_readme() {
    echo ""
    echo "Usage: $(basename $0) DELIVERY_DIR REPORTS_DIR"
    echo -e "\tDELIVERY_DIR\tShould be the directory where your project files are"
    echo -e "\tREPORTS_DIR\tShould be the directory where we output the reports"
    echo -e "\t\t\tTake note that existing reports will be overriden"
    echo ""
}

if [ $# == 1 ] && [ $1 == "--help" ]; then
    cat_readme
elif [ $# = 2 ];
then
    DELIVERY_DIR=$(my_readlink "$1")
    REPORTS_DIR=$(my_readlink "$2")
    DOCKER_SOCKET_PATH=/var/run/docker.sock
    HAS_SOCKET_ACCESS=$(test -r $DOCKER_SOCKET_PATH; echo "$?")
    GHCR_REGISTRY_TOKEN=$(curl -s "https://ghcr.io/token?service=ghcr.io&scope=repository:epitech/coding-style-checker:pull" | grep -o '"token":"[^"]*' | grep -o '[^"]*$') 
    GHCR_REPOSITORY_STATUS=$(curl -I -f -s -o /dev/null -H "Authorization: Bearer $GHCR_REGISTRY_TOKEN" "https://ghcr.io/v2/epitech/coding-style-checker/manifests/latest" && echo 0 || echo 1)
    BASE_EXEC_CMD="podman"
    EXPORT_FILE="$REPORTS_DIR"/coding-style-reports.log
    ### delete existing report file
    rm -f "$EXPORT_FILE"

    ### Pull new version of docker image and clean olds

    if [ $GHCR_REPOSITORY_STATUS -eq 0 ]; then
        echo "Downloading new image and cleaning old one..."
        $BASE_EXEC_CMD pull ghcr.io/epitech/coding-style-checker:latest && $BASE_EXEC_CMD image prune -f
        echo "Download OK"
    else
        echo "WARNING: Skipping image download"
    fi
   

    ### generate reports
    $BASE_EXEC_CMD run --rm -i -v "$DELIVERY_DIR":"/mnt/delivery" -v "$REPORTS_DIR":"/mnt/reports" ghcr.io/epitech/coding-style-checker:latest "/mnt/delivery" "/mnt/reports"
    [[ -f "$EXPORT_FILE" ]] && echo "$(wc -l < "$EXPORT_FILE") coding style error(s) reported in "$EXPORT_FILE", $(grep -c ": MAJOR:" "$EXPORT_FILE") major, $(grep -c ": MINOR:" "$EXPORT_FILE") minor, $(grep -c ": INFO:" "$EXPORT_FILE") info"
else
    cat_readme
fi
