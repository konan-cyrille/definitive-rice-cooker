#! /bin/bash

# On se place dans le dossier ou ce trouve ce fichier, 
# et on assigne à la variable DIR la la valeur de command pwd
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# on crée une variable contenant le chemin du dussier flat_file_ingestor
ROOT_PATH="$DIR/.."

SOURCE_DIR="${ROOT_PATH}/src/flat_file_ingestor"

source "${ROOT_PATH}/shell/variables.sh"

echo "Deployement de la cloud function..."
gcloud services enable cloudfunctions.googleapis.com

gcloud functions \
    deploy ${FUNCTION_NAME} \
    --project=${PROJECT_ID} \
    --region=${REGION} \
    --entry-point=${CLOUD_FUNCTION_ENTRYPOINT}\
    --trigger-bucket=${BUCKET_TO_WATCH} \
    --set-env-vars PROJECT_ID=${PROJECT_ID},BUCKET_NAME_IN=${BUCKET_NAME_IN},BUCKET_NAME_HANDLED=${BUCKET_NAME_HANDLED} \
    --runtime=python38 \
    --source=$SOURCE_DIR