import os
import pandas as pd
import pandas_gbq
import json
from google.cloud import storage
from queries import q_clinical_trials, q_drugs, q_pubmed
# from dotenv import load_dotenv
# load_dotenv(dotenv_path="../../conf/.env.local")


os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/konan/.config/gcloud/sa-konan-pdl-042022-dev.json'
bkt_name = "bkt-pdl-042022-dev-handled"
    

def drugs_referenced_in(df_d, df_j):
    drugs = df_d.drug.to_list()
    drugs = [d.lower() for d in drugs]
    json_output = {}
    for drug in drugs:
        list_ref_in = []
        for ind, row in df_j.iterrows():
            #print(row)
            if drug in row['title'].lower():
                ref_in = {'date':row['date'], 'journal':row['journal']}
                list_ref_in.append(ref_in)
        json_output[drug] = list_ref_in
        
    return json_output


def make_few_process_on_data(df_drugs, df_clinical_trials, df_pubmed):
    df_clinical_trials["source"] = "clinical_trials"
    df_pubmed["source"] = "pubmed"
    df_clinical_trials.rename(columns={'scientific_title':'title'}, inplace=True)

    # Concat dataframe df_clinical_trials and df_pubmed
    df_to_concat = [df_clinical_trials, df_pubmed]
    df_joined = pd.concat(df_to_concat)
    df_joined = df_joined[["title", "date", "journal","source"]]

    df_output = drugs_referenced_in(df_drugs, df_joined)

    df_output = json.dumps(df_output, indent=4)
    return df_output


def write_to_gcs(file_path=None, contents=None, dst_blob_name=None, gcs_client=None, bucket_name=None):
    bucket = gcs_client.bucket(bucket_name)
    blob = bucket.blob(dst_blob_name)
    if file_path:
        blob.upload_from_filename(file_path)
        print("Fichier {} a été crée sur {}.".format(file_path, dst_blob_name))
    if contents:
        blob.upload_from_string(contents)
        print("{} avec le contenu {} a été crée sur {}.".format(dst_blob_name, contents, bucket_name))


# df_drugs = pd.read_csv("gs://bkt-pdl-032022-4-dev-handled/in/drugs.csv")
# df_clinical_trials = pd.read_csv("gs://bkt-pdl-032022-4-dev-handled/in/clinical_trials.csv")
# df_pubmed = pd.read_csv("gs://bkt-pdl-032022-4-dev-handled/in/pubmed.csv")
def run(gcs_client, q_drugs, q_clinical_trials, q_pubmed):
    df_drugs = pandas_gbq.read_gbq(q_drugs)
    df_clinical_trials = pandas_gbq.read_gbq(q_clinical_trials)
    df_pubmed = pandas_gbq.read_gbq(q_pubmed)
    gcs_client = gcs_client
    df_output = make_few_process_on_data(df_drugs, df_clinical_trials, df_pubmed)
    print(len(df_output))
    write_to_gcs(file_path=None, contents=df_output, dst_blob_name="output/drugs_referenced_in.json", gcs_client=gcs_client, bucket_name=bkt_name)
    print("Done!")


if __name__ == '__main__':
    gcs_client = storage.Client()
    run(gcs_client, q_drugs, q_clinical_trials, q_pubmed)