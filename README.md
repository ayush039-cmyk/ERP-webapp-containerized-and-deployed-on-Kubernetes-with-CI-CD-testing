# ERP-webapp-containerized-and-deployed-on-Kubernetes-with-CI-CD-testing

This project is a Django-based College ERP application that I containerized using Docker, deployed on a single-node Kubernetes cluster, and validated through an automated CI pipeline using Jenkins.

The goal of this work was not just to run the application, but to understand how a real-world backend system moves from source code to a reproducible, testable, and deployable setup using DevOps practices.

Application Containerization (Docker)

The first step was containerizing the Django application to ensure consistency across environments.

What I did

Created a Dockerfile using python:3.9-slim as the base image.

Installed dependencies from requirements.txt.

Copied the application source code into the image.

Exposed port 8000 and ran the Django development server.

Result

The application could now be started with a single Docker command, removing all host-machine dependency issues.

Kubernetes Deployment (Single-Node Cluster)

I deployed the application on a single-node Kubernetes cluster (Minikube) to understand core Kubernetes concepts before moving to managed services.

Kubernetes Objects Used
Pod / ReplicaSet

Created a ReplicaSet to manage multiple replicas of the Django application.

Ensured high availability within the cluster.

Labels were carefully matched with services for traffic routing.

Service

Created a NodePort service to expose the application outside the cluster.

Verified accessibility using minikube service.

ConfigMap & Secret

Used a ConfigMap to store non-sensitive configuration such as Django admin username and email.

Used a Secret to store sensitive data like the admin password.

Injected both into the containers using envFrom.

This approach ensured that configuration was decoupled from the application image and followed Kubernetes best practices.

Application Initialization Considerations

While deploying the Django app, I learned that:

Environment variables alone do not create Django users.

Admin creation must happen explicitly and only once.

Using SQLite with multiple replicas can cause authentication inconsistencies.

To address this:

Admin creation was handled separately (not on every container start).

CI and runtime responsibilities were clearly separated.

Jenkins CI Pipeline

To validate the application automatically, I implemented a Jenkins pipeline.

Jenkins Setup

Jenkins was run inside a Docker container.

Jenkins data (/var/jenkins_home) was persisted using a Docker volume.

Dependencies were installed in user space to avoid modifying the container filesystem.

Pipeline Stages

Checkout

Pulled the source code from the repository.

Install Dependencies

Installed Python dependencies using pip from requirements.txt.

Django Checks

Ran python manage.py check to validate configuration.
