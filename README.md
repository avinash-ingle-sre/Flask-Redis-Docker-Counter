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
## 🔐 Security Note: Never hardcode sensitive data in your code!
