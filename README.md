# Project Concept

This project focuses on developing a scalable platform for hosting a static website for an F1 Store. The backend handles user authentication, product management, and content delivery, while the frontend provides a clean and static interface for users. Additionally, caching mechanisms are employed to enhance performance, ensuring a seamless user experience.

# Project Overview

This project is structured into three primary components: backend services (RDS and Redis), and the frontend. Each component plays a critical role in delivering a comprehensive solution. Below is a summary of the key elements:

- **Backend (RDS)**: Built with a focus on scalability and reliability, managing relational database operations.
- **Backend (Redis)**: Optimized for session caching and quick access to frequently used data.
- **Frontend**: Designed to provide a responsive and static interface.

The platform utilizes PostgreSQL for database management and Redis for caching, ensuring optimal performance.

### Diagram
![Architecture Diagram](diagram.png)

## File Structure

### 1. **Backend (RDS)**
- **Purpose**: Manages application logic and integrates with a relational database service.
- **Files**:
  - `manage.py`: Entry point for the backend application.
  - `requirements.txt`: Lists dependencies for the project.
  - `backend_rds/`: Contains the core backend logic, configuration files, and routes for the application.

### 2. **Backend (Redis)**
- **Purpose**: Handles backend logic with Redis for caching.
- **Files**:
  - `manage.py`: Entry point for the backend application.
  - `requirements.txt`: Lists dependencies for the project.
  - `backend_redis/`: Contains the core backend logic, configuration files, and routes for the application.

### 3. **Step 3: Frontend**
- **Purpose**: Provides a static user interface.
- **Files**:
  - `index.html`: Main HTML file for the static frontend.


## Deployment

**Important:** Do not modify the code. The code is written correctly, and your task is to deploy it to fulfill the project requirements. Therefore, there is no need to add or rewrite code as it is already functional.

### Backend Services
- Deploy the backend (backend_rds, backend_redis) services using EC2 as specified in the architecture diagram.

### Frontend
- Deploy the static frontend service using Amazon S3 and CloudFront as specified in the architecture diagram.

### Dockerization

- All services should be containerized using Docker to ensure ease of scaling and deployment.

### CI/CD Process

- Implement separate CI/CD pipelines for backend and frontend deployment to automate the process effectively.

## Local testing

1. **Step 1: Cloning the Repository**

   Clone the repository to your local machine and navigate to the project directory:
   ```bash
   git clone https://github.com/THE-GAME-DEVOPS/f1-store.git
   cd f1-store
   ```

2. **Step 2: Writing Dockerfiles for Services**

   Write a `Dockerfile` for each service, including:
   - Backend RDS
   - Backend Redis
   - Frontend with Nginx

   Ensure each `Dockerfile` is properly configured to build and run its respective service.

3. **Step 3: Creating docker-compose.yml and Environment Variables**
   
   Write a `docker-compose.yml` file to define all the services, including Redis, PostgreSQL, and backend services. Include the following:

    - **Redis**: Use the official Redis image ([Redis Docker Hub](https://hub.docker.com/_/redis)).
    - **PostgreSQL**: Use the official PostgreSQL image ([PostgreSQL Docker Hub](https://hub.docker.com/_/postgres)).

    - **backend-rds**: This service should depend on PostgreSQL.
    - **backend-redis**: This service should depend on Redis.

    - **Frontend**: Use the frontend `Dockerfile` built with Nginx ([Nginx Docker Hub](https://hub.docker.com/_/nginx))..

  Make sure to place the corresponding `Dockerfile` for each backend service in the correct directory.

4. **Step 4: Building and Running Services**
   
   Build and start all services using Docker Compose with the `--build` option to rebuild images:
     ```bash
     docker-compose up -d --build
     ```

5. **Step 5: Monitoring Logs**
   
   To troubleshoot issues and monitor logs for each service:
   - View logs for all services:
     ```bash
     docker-compose logs -f
     ```
   - View logs for a specific service (e.g., backend-rds):
     ```bash
     docker-compose logs -f backend-rds
     ```
   - Stop monitoring logs by pressing `Ctrl+C`.


6. **Step 6: Testing the Frontendd**

   After starting all services, verify that the frontend served by Nginx is accessible. 

7. **Step 7: Stopping Services**
   
   To stop all running services:
   ```bash
   docker-compose down
   ```
## Final Thoughts

Congratulations on completing your first project by deploying a simple EC2 instance integrated with S3 and CloudFront! This marks an important step in understanding the basics of cloud infrastructure and how to build a functional and accessible system. Keep learning, experimenting, and improving as you take your first steps into the world of cloud computing and DevOps.

<p align="center">
  <img src="https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExeHk2MGpqb3F4NWMwbzc5bGQ4emg0eTl1OWxoMDhtcWV2OGh5YWRnbyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/10xZU9b7JBx14s/giphy.gif" width="50%">
</p>  


