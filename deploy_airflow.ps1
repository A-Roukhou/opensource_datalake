# Ensure minikube is running
Write-Host "Starting Minikube..."
minikube start

# Create the Airflow namespace
Write-Host "Creating Airflow namespace..."
kubectl create namespace airflow

# Add the Airflow Helm repository
Write-Host "Adding Airflow Helm repository..."
helm repo add apache-airflow https://airflow.apache.org
helm repo update

# Deploy Airflow using Helm and the specified values.yaml
Write-Host "Deploying Airflow with Helm..."
helm install airflow apache-airflow/airflow --namespace airflow --values airflow_values.yaml

# Set up port forwarding to access the Airflow web UI
Write-Host "Setting up port forwarding to access the Airflow web UI..."
Start-Process "powershell" -ArgumentList "kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow" -NoNewWindow

Write-Host "Airflow deployment initiated. Access the web UI at http://localhost:8080 with username 'admin' and password 'admin'."

# kubectl get pods -n airflow
# kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow