# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.7-slim

# Definir les variables d'environnement neccéssaire au fonctionnement du code
ENV APP_HOME /is-drugs-in
WORKDIR $APP_HOME
# Copie du code local dans l'image du container.
COPY ./src/jobs/is_drugs_in/ ./
COPY ./.saKey/sa-for-run-jobs.json ./
# Install production dependencies.
RUN apt-get update && pip install -r requirements.txt

# Exécuter cette commande à l'exécution du container
CMD ["python3", "drugs_referenced_in.py"]