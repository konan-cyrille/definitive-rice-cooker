# Création d'un pipeline d'ingestion de fichier et exécuter un job de traitement de fichier

### Prérequis

* Python
* Un compte Google Cloud Plateform avec un compte de facturation associé
* Git
* Terraform (facultatif)

### Description

Ce projet se décompose en deux parties:

* Un pipeline d'ingestion de fichier csv et json qui s'exécute grace à une cloud function. le pipeline d'ingestion se declenche lorsque un ou plusieurs fichiers sont chargé dans un bucket cloud storage. <br>
Les fichiers sont ingérer dans un dataset bigquery en l'état sans transformation.<br>
S'il y a un soucis sur le fichier ce dernier est placé dans le dossier "rejeté" d'un bucket, <br>
Si le fichier est ingéré correctement ce dernier est archivé.

* La deuxième partie est un job qui lit les fichiers ingérés et génère un fichier json.<br>
Cette deuxième partie est containerisé dans une image docker qui peut-être exécuté sur cloud run ou Kubernetes <br>

### Devops

les ressources cloud dans ce projet sont managé par terraform.

la partie CICD est gérer par cloud build en suivant le style GitOps


# Exécuter le projet


# Builder et exécuter l'image docker en local

se placer dans le dossier docker image

si on souhait gérer les images avec dockerhub ou pour tester l'image en local utiliser la commande ci-dessous
si le Dockerfile et tous les fichiers à inclure dans l'image sont dans le même dossier
```docker build --rm -t is-drugs-in-image:v1 .```

pour elargir le build context <br>
```docker build --rm -f src/docker_images/Dockerfile -t is-drugs-in-image:v1 .```

si on souhait gérer les images avec artifact registry de google utiliser la commande ci-dessous
```docker build -t ${REGION}-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_REGISTRY_REPO}/${APP_NAME}:v1 .```

pour pousser l'image sur artifact registry
```docker push ${REGION}-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_REGISTRY_REPO}/${APP_NAME}:v1```
