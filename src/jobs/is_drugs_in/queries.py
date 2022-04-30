import os

PROJECT_ID = os.getenv('PROJECT_ID')

q_drugs = f"""
SELECT *
FROM {PROJECT_ID}.raw.drugs
"""

q_clinical_trials = f"""
SELECT *
FROM {PROJECT_ID}.raw.clinical_trials
"""

q_pubmed = f"""
SELECT *
FROM {PROJECT_ID}.raw.pubmed
"""