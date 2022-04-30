# On se place dans le dossier ou ce trouve ce fichier, 
# et on assigne à la variable DIR la la valeur de command pwd
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# initialisation d'une variable root_path avec la sortie de la commande pwd
ROOT_PATH="$DIR/.."
# Rendre disponible les variables d'environnement
source variables.sh

echo "*********************************"
echo "CONFIGURATION PARTIE-1"
echo "*********************************"

# configure le sdk gcloud en fixant project encour
gcloud config set project ${PROJECT_ID}

# activation des API nécessaire
echo "Activation des API nécessaire..."
gcloud services enable container.googleapis.com \
  compute.googleapis.com \
  cloudbuild.googleapis.com \
  bigquery.googleapis.com
    # artifactregistry.googleapis.com
echo "Done!"

gcloud config set compute/region ${REGION}
gcloud config set compute/zone ${ZONE}


echo "Association d'un compte de facturation..."
# Activation du compte de facturation
gcloud beta billing projects link ${PROJECT_ID} \
  --billing-account ${BILLING_ACCOUNT}
echo "Done!"

echo "Création d'un bucket pour stocké l'etat des ressource..."
# Creation d'un bucket pour stocker l'etat des ressource managé par terraform
# PROJECT_ID=$(gcloud config get-value project)
gsutil mb -l ${REGION} gs://${PROJECT_ID}-tfstate

echo "Activation de la versionnisation des objets..."
#Activez la gestion des versions des objets pour conserver l'historique de vos déploiements 
gsutil versioning set on gs://${PROJECT_ID}-tfstate

echo "*********************************"
echo "FIN CONFIGURATION PARTIE-1"
echo "*********************************"


echo "*********************************"
echo "CONFIGURATION PARTIE-2"
echo "*********************************"
echo "récupération de l'adresse e-mail du compte de service Cloud Build de votre projet..."
# permettre au compte de service Cloud Build d'exécuter des scripts Terraform dans le but de gérer des ressources Google Cloud, 
CLOUDBUILD_SA="$(gcloud projects describe $PROJECT_ID \
  --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com"

echo "Accord de l'access requis au compte de service cloud build"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member serviceAccount:$CLOUDBUILD_SA --role roles/editor

# Creation d'un compte de service permettant d'exécution les jobs de traitement de données
echo "Creation d'un compte de service..."
    gcloud iam service-accounts create ${SA_NAME} \
    --display-name "Compte de service pour developpeur"
    echo "Téléchargement de la clé..."
    cd $ROOT_PATH/.saKey/
    gcloud iam service-accounts keys create ${SA_CREDS} \
    --iam-account ${IAM_ACCOUNT}
    cd $ROOT_PATH
echo "Done!"

echo "Accord du role admin au compte de service..."
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member serviceAccount:${IAM_ACCOUNT} \
    --role roles/storage.admin
echo "Done!"

echo "Accord des roles pour bigquery..."
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member serviceAccount:${IAM_ACCOUNT} \
    --role roles/bigquery.dataEditor

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member serviceAccount:${IAM_ACCOUNT} \
    --role roles/bigquery.jobUser
