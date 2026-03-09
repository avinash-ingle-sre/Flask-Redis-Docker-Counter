nano inspect-request.json
gcloud auth print-access-token
curl -s   -H "Authorization: Bearer ACCESS_TOKEN"   -H "Content-Type: application/json"   https://dlp.googleapis.com/v2/projects/$PROJECT_ID/content:inspect   -d @inspect-request.json -o inspect-output.txt
cat inspect-output.txt
gsutil cp inspect-output.txt gs://qwiklabs-gcp-04-b208469b9c31-bucket
cat inspect-output.txt
gsutil cp inspect-output.txt gs://qwiklabs-gcp-04-b208469b9c31-bucket
cat > inspect-request.json << 'EOF'
{
  "item":{
    "value":"My phone number is (206) 555-0123."
  },
  "inspectConfig":{
    "infoTypes":[
      {
        "name":"PHONE_NUMBER"
      },
      {
        "name":"US_TOLLFREE_PHONE_NUMBER"
      }
    ],
    "minLikelihood":"POSSIBLE",
    "limits":{
      "maxFindingsPerItem":0
    },
    "includeQuote":true
  }
}
EOF

ACCESS_TOKEN=$(gcloud auth print-access-token)
echo "Token मिळाला (प्रथम काही chars): ${ACCESS_TOKEN:0:20}..."
PROJECT_ID=$(gcloud config get-value project)
curl -s   -H "Authorization: Bearer $ACCESS_TOKEN"   -H "Content-Type: application/json"   https://dlp.googleapis.com/v2/projects/$PROJECT_ID/content:inspect   -d @inspect-request.json -o inspect-output.txt
cat inspect-output.txt
BUCKET_NAME="qwiklabs-gcp-04-b208469b9c31-bucket"
gsutil cp inspect-output.txt gs://$BUCKET_NAME/
"Inspect a string for sensitive information" → Check my progress ✅
gsutil ls
gsutil cp inspect-output.txt gs://qwiklabs-gcp-04-b208469b9c31-bucket/
cat > new-inspect-file.json << 'EOF'
{
  "item": {
     "value":"My email is test@gmail.com"
   },
   "deidentifyConfig": {
     "infoTypeTransformations":{
          "transformations": [
            {
              "primitiveTransformation": {
                "replaceWithInfoTypeConfig": {}
              }
            }
          ]
        }
    },
    "inspectConfig": {
      "infoTypes": {
        "name": "EMAIL_ADDRESS"
      }
    }
}
EOF

PROJECT_ID=$(gcloud config get-value project)
curl -s   -H "Authorization: Bearer $(gcloud auth print-access-token)"   -H "Content-Type: application/json"   https://dlp.googleapis.com/v2/projects/$PROJECT_ID/content:deidentify   -d @new-inspect-file.json -o redact-output.txt
cat redact-output.txt
BUCKET_NAME="qwiklabs-gcp-04-b208469b9c31-bucket"
gsutil cp redact-output.txt gs://$BUCKET_NAME/
gsutil ls
gsutil cp redact-output.txt
gsutil cp redact-output.txt gs://qwiklabs-gcp-04-b208469b9c31-bucket/
clear
ls -ltr
pwd
ls -ltr
git init
git config --global user.name "avinash-ingle-sre"
git config --global user.email "avinash.ingle.sre@gmail.com"
cat > README.md << 'EOF'
# 🔐 Google Cloud DLP API - Sensitive Data Detection & Redaction

![GCP](https://img.shields.io/badge/Google_Cloud-DLP_API-4285F4?style=for-the-badge&logo=google-cloud)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

## 📌 Overview
This project demonstrates how to use **Google Cloud Data Loss Prevention (DLP) API** to:
- 🔍 **Inspect** text for sensitive information (Phone Numbers, Emails, etc.)
- ✂️ **Redact** sensitive data from text content automatically

---

## 🛠️ Tech Stack
- Google Cloud DLP API
- Cloud Shell (curl + gsutil)
- Cloud Storage (GCS Bucket)
- REST API (JSON)

---

## ✅ Tasks Completed

### Task 1: 🔍 Inspect String for Sensitive Information
- Created `inspect-request.json` with phone number text
- Used DLP API `content:inspect` endpoint
- Detected **PHONE_NUMBER** with `LIKELY` likelihood
- Uploaded output to GCS bucket

**Sample Input:**

**API Response:**
```json
{
  "findings": [{
    "quote": "(206) 555-0123",
    "infoType": { "name": "PHONE_NUMBER" },
    "likelihood": "LIKELY"
  }]
}



Task 2: ✂️ Redact Sensitive Data from Text
Created new-inspect-file.json with email text

Used DLP API content:deidentify endpoint

Email address automatically replaced with [EMAIL_ADDRESS]

Uploaded redacted output to GCS bucket

Sample Input:

text
My email is test@gmail.com
API Response:

text
My email is [EMAIL_ADDRESS]
📁 Project Structure
text
├── inspect-request.json     # DLP Inspect API request payload
├── inspect-output.txt       # Inspect API response output
├── new-inspect-file.json    # DLP Deidentify API request payload
└── redact-output.txt        # Redacted output response
🚀 How to Run
1. Inspect for Sensitive Data
bash
PROJECT_ID=$(gcloud config get-value project)
curl -s \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  https://dlp.googleapis.com/v2/projects/$PROJECT_ID/content:inspect \
  -d @inspect-request.json -o inspect-output.txt

cat inspect-output.txt
2. Redact Sensitive Data
bash
curl -s \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  https://dlp.googleapis.com/v2/projects/$PROJECT_ID/content:deidentify \
  -d @new-inspect-file.json -o redact-output.txt

cat redact-output.txt
3. Upload to Cloud Storage
bash
gsutil cp inspect-output.txt gs://YOUR_BUCKET_NAME/
gsutil cp redact-output.txt gs://YOUR_BUCKET_NAME/
👨‍💻 Author
Avinash Ingle | SRE & Cloud Engineer

🔗 GitHub

☁️ Google Cloud | AWS | DevOps

📚 References
Google Cloud DLP Documentation

DLP REST API Reference
EOF

ls -ltr
cat README.md
git branch -M main
git remote add origin https://github.com/avinash-ingle-sre/Flask-Redis-Docker-Counter.git
git add .
