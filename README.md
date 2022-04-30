# Création d'un pipeline d'ingestion de fichier et un job de traitement de fichier

les ressources cloud dans ce projet sont managé par térraform.

la partie CICD est gérer par cloud build en suivant le style GitOps


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
