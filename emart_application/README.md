# EMart Microservices Application

A hands-on DevOps project demonstrating the deployment and containerization of a **microservices-based e-commerce application** using Docker, Docker Compose, Vagrant, Nginx, Node.js, Angular, Java, MongoDB, and MySQL.

---

## 📌 Project Overview

**EMart** is a microservices-based application designed to demonstrate how different application components can be developed, containerized, and deployed as independent services.

Instead of building one large application, the application is divided into multiple services. Each service is responsible for a specific function and can communicate with other services through defined endpoints.

The project uses **Nginx as an API Gateway** to receive incoming requests and route them to the appropriate backend service.

The complete application stack is deployed using **Docker containers** and managed with **Docker Compose**.

---

## 🏗️ Microservices Architecture

The application consists of multiple services working together:

```text
                         ┌──────────────────┐
                         │      Browser     │
                         │      Client      │
                         └────────┬─────────┘
                                  │
                                  ▼
                         ┌──────────────────┐
                         │      Nginx       │
                         │    API Gateway   │
                         └────────┬─────────┘
                                  │
                 ┌────────────────┼────────────────┐
                 │                │                │
                 ▼                ▼                ▼
          ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
          │   Client    │  │  Node.js    │  │    Java     │
          │  Angular    │  │  REST API   │  │  Books API  │
          └─────────────┘  └──────┬──────┘  └──────┬──────┘
                                  │                │
                                  ▼                ▼
                           ┌─────────────┐  ┌─────────────┐
                           │  MongoDB    │  │    MySQL    │
                           │  Database   │  │  Database   │
                           └─────────────┘  └─────────────┘
```

### Request Flow

Nginx acts as the entry point for the application.

```text
Browser
   │
   ▼
 Nginx
   │
   ├── /        → Angular Client
   │
   ├── /api     → Node.js API → MongoDB
   │
   └── /webapi  → Java Books API → MySQL
```

This architecture allows each service to operate independently while still working together as one application.

---

# 🧩 Services

## 1. Client Application

The frontend is an **Angular application**.

It provides the user interface through which users interact with the EMart application.

The frontend is accessed through the root Nginx route:

```text
/
```

---

## 2. Node.js API

The Node.js service provides backend functionality for the EMart application.

It is exposed through:

```text
/api
```

The Node.js API communicates with the **MongoDB database** to store and retrieve application data.

```text
Angular Client
      │
      ▼
    Nginx
      │
      ▼
  Node.js API
      │
      ▼
   MongoDB
```

---

## 3. Java Books API

The project also contains a Java-based Books API.

It is exposed through:

```text
/webapi
```

The Books API communicates with a **MySQL database**.

```text
Angular Client
      │
      ▼
    Nginx
      │
      ▼
  Java Books API
      │
      ▼
    MySQL
```

---

## 4. Nginx API Gateway

Nginx serves as the **API Gateway and reverse proxy** for the application.

Instead of exposing every backend service directly to the user, Nginx receives requests and routes them to the appropriate service.

For example:

```text
/       → Angular Client
/api    → Node.js API
/webapi → Java Books API
```

This provides a single entry point for accessing the application.

---

# 🐳 Containerization

All major application components are deployed as Docker containers.

The containerized services include:

* Nginx
* Angular Client
* Node.js API
* Java Books API
* MongoDB
* MySQL

Each service runs in its own isolated container while communicating with the other services through the Docker network.

This demonstrates one of the major benefits of microservices and containerization: **services can be developed, deployed, scaled, and managed independently.**

---

# 🛠️ Technologies Used

| Technology     | Purpose                              |
| -------------- | ------------------------------------ |
| Docker         | Containerization                     |
| Docker Compose | Multi-container orchestration        |
| Vagrant        | Virtual machine provisioning         |
| Nginx          | API Gateway / Reverse Proxy          |
| Angular        | Frontend / Client Application        |
| Node.js        | Backend REST API                     |
| Java           | Books API                            |
| MongoDB        | NoSQL database for Node.js service   |
| MySQL          | Relational database for Java service |
| Git            | Version control                      |
| GitHub         | Source code management               |

---

# 🚀 Deployment Environment

The application is deployed inside a virtual machine created using **Vagrant**.

The same Vagrant environment used in the previous containerization exercise is reused for this project.

Start the virtual machine with:

```bash
vagrant up
```

Check the VM status:

```bash
vagrant status
```

Connect to the VM:

```bash
vagrant ssh
```

Switch to the root user if required:

```bash
sudo -i
```

---

# 📥 Clone the Project

Clone the EMart repository:

```bash
git clone <YOUR_REPOSITORY_URL>
```

Navigate into the project directory:

```bash
cd <PROJECT_DIRECTORY>
```

Check the project files:

```bash
ls
```

The project should contain the Docker Compose configuration and the application components required to build the services.

---

# 📄 Docker Compose

The application uses a `docker-compose.yml` file to define and manage the different microservices.

Docker Compose makes it possible to build and run the entire application stack using a single configuration file.

Instead of manually creating and starting every container, Docker Compose handles the services together.

---

# 🔨 Build the Application

From the directory containing the Compose file, build the Docker images:

```bash
docker compose build
```

This command reads the Docker Compose configuration and builds the images required for the different services.

The build process may take some time because some services need to download dependencies and create their respective Docker images.

---

# ▶️ Start the Microservices

After building the images, start the complete application:

```bash
docker compose up -d
```

The `-d` option runs the containers in detached mode.

Docker Compose will:

1. Build or use the required images.
2. Create the application network.
3. Create the containers.
4. Start the services.
5. Allow the containers to communicate with each other.

---

# 🔍 Check Running Containers

To check the status of the containers:

```bash
docker compose ps
```

You can also check all running Docker containers:

```bash
docker ps
```

To display the container IDs:

```bash
docker compose ps -q
```

These commands help verify that the required services have been successfully created and started.

---

# 🖼️ Check Docker Images

To view the images created during the build process:

```bash
docker images
```

You should see images associated with the services defined in the Compose file.

---

# 🌐 Access the Application

Once all containers are running, determine the IP address of the virtual machine:

```bash
ip addr show
```

or:

```bash
hostname -I
```

Then access the application through a web browser:

```text
http://<VM-IP>
```

For example:

```text
http://192.168.x.x
```

Nginx receives the request and routes it to the appropriate service.

---

# 🔄 Application Request Flow

When a user accesses the application, the request follows this general flow:

```text
                   User
                    │
                    ▼
                 Browser
                    │
                    ▼
                  Nginx
               API Gateway
                    │
       ┌────────────┼─────────────┐
       │            │             │
       ▼            ▼             ▼
      /        /api          /webapi
       │            │             │
       ▼            ▼             ▼
   Angular      Node.js        Java
    Client       API         Books API
                    │             │
                    ▼             ▼
                 MongoDB        MySQL
```

This demonstrates how an API Gateway can provide a single entry point while routing requests to independent backend services.

---

# 🧪 Troubleshooting

If the application does not start correctly, check the container status:

```bash
docker compose ps
```

View the logs:

```bash
docker compose logs
```

To view the logs of a specific service:

```bash
docker compose logs <service-name>
```

Follow the logs in real time:

```bash
docker compose logs -f
```

If the build fails, try rebuilding the images:

```bash
docker compose build
```

Then start the services again:

```bash
docker compose up -d
```

---

# 🛑 Stop the Application

To stop the running services:

```bash
docker compose down
```

This stops and removes the containers created by Docker Compose.

---

# 🧹 Clean Up Docker Resources

To remove unused Docker resources:

```bash
docker system prune
```

For a more extensive cleanup:

```bash
docker system prune -a
```

> **Warning:** `docker system prune -a` can remove unused images and other Docker resources. Use it carefully.

---

# 📂 Suggested Repository Structure

A clean repository structure can look like this:

```text
emart-microservices/
│
├── README.md
├── Vagrantfile
├── docker-compose.yml
│
├── client/
│   └── Dockerfile
│
├── api/
│   └── Dockerfile
│
├── books-api/
│   └── Dockerfile
│
├── nginx/
│   └── nginx.conf
│
└── database/
    ├── mongo/
    └── mysql/
```

The exact structure may vary depending on the source repository and Docker Compose configuration.

---

# 🎯 Project Objectives

The main objectives of this project are to gain practical experience with:

* Microservices architecture
* Docker containerization
* Docker Compose
* API Gateway implementation
* Nginx reverse proxy
* Angular application deployment
* Node.js REST API deployment
* Java application deployment
* MongoDB containerization
* MySQL containerization
* Container networking
* Virtual machine provisioning with Vagrant
* Multi-service application deployment
* Docker image management
* Application troubleshooting

---

# 📚 Key DevOps Concepts Demonstrated

### Microservices

The application is divided into independent services rather than being deployed as one large application.

### Containerization

Each application component can run inside an isolated Docker container.

### API Gateway

Nginx provides a central entry point and routes incoming requests to the appropriate backend service.

### Service Communication

The containers communicate with one another through the Docker network created by Docker Compose.

### Infrastructure Automation

Vagrant is used to create and prepare the virtual machine environment.

### Multi-Container Orchestration

Docker Compose makes it possible to define and manage the complete application stack from one YAML configuration.

---

# 💡 What I Learned

Through this project, I gained practical experience in deploying a real-world-style microservices application.

I learned how:

* Microservices communicate with each other.
* Nginx can work as an API Gateway.
* Docker can containerize different application technologies.
* Docker Compose can manage multiple services.
* Node.js applications can communicate with MongoDB.
* Java applications can communicate with MySQL.
* Multiple containers can communicate through a shared Docker network.
* Vagrant can provide a consistent environment for Docker deployment.
* Docker images are built from service-specific Dockerfiles.
* Running and troubleshooting multiple containers is different from running a single container.

---

# 🔮 Future Improvements

Possible improvements to this project include:

* Add CI/CD using GitHub Actions.
* Push Docker images to Docker Hub.
* Deploy the application to a cloud platform.
* Add health checks to the containers.
* Implement container resource limits.
* Add centralized logging.
* Add monitoring with Prometheus and Grafana.
* Use Kubernetes for container orchestration.
* Add HTTPS using SSL/TLS.
* Implement automated testing.

---

# 👨‍💻 Author

**Yakub Adekola Ojo**

DevOps Engineer | Software Engineer & Entrepreneur

This project is part of my hands-on DevOps learning journey, focused on building practical experience with Linux, Docker, Docker Compose, Vagrant, CI/CD, networking, and microservices.

---

# ⭐ Acknowledgement

This project was completed as part of my practical DevOps learning and hands-on exploration of **microservices architecture, Docker containerization, and multi-container application deployment**.

If you find this project useful, consider giving the repository a ⭐ and following my learning journey.
