#! /bin/bash

# On se place dans le dossier ou ce trouve ce fichier, 
# et on assigne à la variable DIR la la valeur de command pwd
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# on crée une variable contenant le chemin du dussier flat_file_ingestor
ROOT_PATH="$DIR/.."

SOURCE_DIR="${ROOT_PATH}/src/flat_file_ingestor"

echo "LISTE DES DOSSIERS A LA RACINE..."
ls ${ROOT_PATH}
echo "Done"

echo "LISTE DES ELEMENTS DANS workspace"
ls /workspace
echo "Done"

source "shell/variables.sh"

echo "PROJECT_ID=${PROJECT_ID}"
echo "FUNCTION_NAME=${FUNCTION_NAME}"
echo "BUCKET_TO_WATCH=${BUCKET_TO_WATCH}"
echo "BUCKET_NAME_HANDLED=${BUCKET_NAME_HANDLED}"

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