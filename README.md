# Google Cloud Run Flask Application

A simple Flask web application deployed on Google Cloud Run using Docker containers. This project demonstrates how to containerize a Python web application and deploy it to a serverless platform.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Local Development](#local-development)
- [Deployment](#deployment)
- [Configuration](#configuration)
- [Screenshots](#screenshots)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## 🎯 Overview

This application serves a simple HTML page using Flask and is containerized with Docker for deployment on Google Cloud Run. Cloud Run is a fully managed serverless platform that automatically scales your containerized applications.

**Key Features:**
- Lightweight Flask web server
- Docker containerization
- Serverless deployment with Cloud Run
- Automatic HTTPS provisioning
- Auto-scaling capabilities

## 📦 Prerequisites

Before you begin, ensure you have the following installed and configured:

- [Google Cloud SDK (gcloud CLI)](https://cloud.google.com/sdk/docs/install)
- [Docker](https://docs.docker.com/get-docker/) (optional, for local testing)
- A Google Cloud Platform account with billing enabled
- A GCP project with Cloud Run API enabled

### Setup GCP Project

1. Create a new GCP project or select an existing one:
   ```bash
   gcloud projects create YOUR_PROJECT_ID
   ```

2. Set your project as the default:
   ```bash
   gcloud config set project YOUR_PROJECT_ID
   ```

3. Enable required APIs:
   ```bash
   gcloud services enable cloudbuild.googleapis.com
   gcloud services enable run.googleapis.com
   ```

## 📁 Project Structure

```
.
├── app.py              # Flask application entry point
├── index.html          # HTML page served by the application
├── Dockerfile          # Docker container configuration
├── README.md           # Project documentation
└── images/
    └── cloudrun.png    # Screenshot of deployed application
```

## 🛠️ Local Development

### Running with Python

1. Install dependencies:
   ```bash
   pip install flask
   ```

2. Run the application:
   ```bash
   python app.py
   ```

3. Open your browser and navigate to:
   ```
   http://localhost:8080
   ```

### Running with Docker

1. Build the Docker image:
   ```bash
   docker build -t my-cloudrun-app .
   ```

2. Run the container:
   ```bash
   docker run -p 8080:8080 my-cloudrun-app
   ```

3. Access the application at `http://localhost:8080`

## 🚀 Deployment

### Step 1: Build and Push Docker Image

Build your Docker image using Google Cloud Build:

```bash
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/my-cloudrun-app
```

**Note:** Replace `YOUR_PROJECT_ID` with your actual Google Cloud project ID.

### Step 2: Deploy to Cloud Run

Deploy the containerized application to Cloud Run:

```bash
gcloud run deploy my-cloudrun-app \
  --image gcr.io/YOUR_PROJECT_ID/my-cloudrun-app \
  --platform managed \
  --region asia-south1 \
  --allow-unauthenticated
```

**Parameters explained:**
- `--image`: Container image URL from Google Container Registry
- `--platform managed`: Use fully managed Cloud Run
- `--region`: GCP region for deployment (change as needed)
- `--allow-unauthenticated`: Allow public access without authentication

### Step 3: Access Your Application

After successful deployment, you'll receive a URL like:
```
https://my-cloudrun-app-xxxxx-as.a.run.app
```

Open this URL in your browser to view your deployed application.

## ⚙️ Configuration

### Changing the Region

Available regions can be listed with:
```bash
gcloud run regions list
```

Common regions:
- `us-central1` (Iowa)
- `us-east1` (South Carolina)
- `europe-west1` (Belgium)
- `asia-south1` (Mumbai)
- `asia-southeast1` (Singapore)

### Authentication

To require authentication, remove the `--allow-unauthenticated` flag:

```bash
gcloud run deploy my-cloudrun-app \
  --image gcr.io/YOUR_PROJECT_ID/my-cloudrun-app \
  --platform managed \
  --region asia-south1
```

### Environment Variables

Add environment variables during deployment:

```bash
gcloud run deploy my-cloudrun-app \
  --image gcr.io/YOUR_PROJECT_ID/my-cloudrun-app \
  --set-env-vars "KEY1=VALUE1,KEY2=VALUE2"
```

### Resource Limits

Configure CPU and memory:

```bash
gcloud run deploy my-cloudrun-app \
  --image gcr.io/YOUR_PROJECT_ID/my-cloudrun-app \
  --memory 512Mi \
  --cpu 1
```

## 📸 Screenshots

![Cloud Run Deployment](images/cloudrun.png)

## 🔧 Troubleshooting

### Common Issues

**Issue: Permission denied errors**
```bash
gcloud auth login
gcloud auth configure-docker
```

**Issue: API not enabled**
```bash
gcloud services enable cloudbuild.googleapis.com run.googleapis.com
```

**Issue: Port binding errors**

Ensure your application listens on the port specified by the `PORT` environment variable (defaults to 8080 in Cloud Run).

### Viewing Logs

View application logs:
```bash
gcloud run logs read my-cloudrun-app --region asia-south1
```

Stream logs in real-time:
```bash
gcloud run logs tail my-cloudrun-app --region asia-south1
```

### Deleting the Service

To remove the deployed service:
```bash
gcloud run services delete my-cloudrun-app --region asia-south1
```

## 📚 Additional Resources

- [Google Cloud Run Documentation](https://cloud.google.com/run/docs)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [Docker Documentation](https://docs.docker.com/)

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

**Author:** Ujwal Nagrikar 
**Last Updated:** October 2025

![Cloud Run Screenshot](images/cloudrun.png)
