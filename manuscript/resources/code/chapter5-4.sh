# Building our Nginx Docker image and tagging it with the ECR URL
docker build -f Dockerfile-nginx -t YOUR_ECR_REGISTRY_URL_HERE:nginx .
docker push YOUR_ECR_REGISTRY_URL_HERE:nginx

# Building our Laravel Docker image and tagging it with the ECR URL
docker build -t YOUR_ECR_REGISTRY_URL_HERE:laravel .
docker push YOUR_ECR_REGISTRY_URL_HERE:laravel
