echo "*********************************"
echo "Initializing variables"
echo "*********************************"
# Replace the following with values for your own project.
export PROJECT_ID="cicd-gcp-tools-348307"
export REGION="europe-west1"
export ZONE="europe-west1-b"
export BILLING_ACCOUNT="ID_COMPTE_DE_FACTURATION"

IS_DEVELOPER=true
export SA_NAME=sa-for-run-jobs
export IAM_ACCOUNT=${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com
export SA_CREDS=${SA_NAME}.json

CLOUD_FUNCTION_NAME=func-pdl
export FUNCTION_NAME=$CLOUD_FUNCTION_NAME
export CLOUD_FUNCTION_ENTRYPOINT=process
export BUCKET_TO_WATCH=bkt-${PROJECT_ID}-in
export BUCKET_NAME_IN=bkt-${PROJECT_ID}-in
export BUCKET_NAME_HANDLED=bkt-${PROJECT_ID}-handled

echo "PROJECT_ID=${PROJECT_ID}"
echo "REGION=${REGION}"
echo "ZONE=${ZONE}"

echo "*********************************"