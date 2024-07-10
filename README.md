Project 2: Dockerizing and Deploying Python Application to Kubernetes

This project demonstrates how to Dockerize a Python application and deploy it to Kubernetes. The application displays the current time in Toronto, Canada.
Steps
Fork and Clone the Repository

    Fork the Repository: Fork the repository sojoudian/clo835_s24 on GitHub.

    Clone Your Fork: Clone your forked repository locally.

    bash

    git clone https://github.com/sojoudian/clo835_s24.git
    cd clo835_s24

Create a Dockerfile

    Create Dockerfile: Write a Dockerfile to containerize the Python application. Ensure all dependencies are installed and the application starts correctly.

    Here's a basic example Dockerfile:

    dockerfile

# Use the official Python image from the Docker Hub
FROM python:3.9-slim
# Set the working directory in the container
WORKDIR /app
# Copy the Python script into the container
COPY app.py .
# Install the zoneinfo package for time zone support
RUN pip install tzdata
# Expose the port the app runs on


Build and Push Docker Image:

    Build your Docker image:

    bash

docker build -t prj2-app .

Tag your Docker image (replace your-dockerhub-id with your Docker Hub ID):

bash

docker tag prj2-app your-dockerhub-id/prj2-app:v1.0

Push your Docker image to Docker Hub:

bash

        docker push your-dockerhub-id/prj2-app:v1.0

Write Kubernetes Manifests

    Create Kubernetes Deployment YAML (deployment.yaml):

    yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: prj2-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prj2
  template:
    metadata:
      labels:
        app: prj2
    spec:
      containers:
        - name: prj2-container
          image: your-dockerhub-id/prj2-app:v1.0
          ports:
            - containerPort: 3030

Create Kubernetes Service YAML (service.yaml):

yaml

    apiVersion: v1
    kind: Service
    metadata:
      name: prj2-service
    spec:
      type: NodePort
      ports:
        - port: 3030
          targetPort: 3030
          nodePort: 32000
      selector:
        app: prj2

Deploy to Kubernetes

    Apply Kubernetes Manifests:

    bash

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

Verify Deployment:

bash

    kubectl get deployments
    kubectl get pods
    kubectl get services

Test the Application

    Access the Application:
        Find the IP of any node in your Kubernetes cluster (kubectl get nodes -o wide).
        Access the application via NodePort (e.g., http://node-ip:32000).

    Ensure the Application Works:
        The application should display the current time in Toronto, Canada.
