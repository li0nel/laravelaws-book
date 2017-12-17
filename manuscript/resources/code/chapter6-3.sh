# Use the Docker exec command to execute the Artisan commands inside the application container
docker exec -it CONTAINER_ID php artisan session:table
docker exec -it CONTAINER_ID php artisan migrate?--force
