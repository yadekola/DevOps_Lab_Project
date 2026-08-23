# VProfile Application ‚Äî Docker Compose Deployment

A containerized deployment of the **VProfile Application** using **Docker, Docker Compose, and Vagrant**.

This project demonstrates how a multi-tier application can be deployed using multiple Docker containers and managed as a single application stack with Docker Compose.

---

## Ì≥å Project Overview

The VProfile Application is a multi-service application designed to demonstrate how different components of an application can work together in a containerized environment.

In this project, the application is deployed using Docker containers for the major services, including:

* **Nginx** ‚Äî Web server and reverse proxy
* **Apache Tomcat** ‚Äî Application server
* **RabbitMQ** ‚Äî Message broker
* **MongoDB** ‚Äî Database
* **Vagrant** ‚Äî Creates and manages the virtual machine environment
* **Docker** ‚Äî Provides the container runtime
* **Docker Compose** ‚Äî Manages the multi-container application

The initial environment is prepared using a **Vagrantfile**, which provisions the VM and installs Docker and the required Docker components.

---

## ÌøóÔ∏è Architecture

The application follows a multi-container architecture:

```text
                         User / Browser
                               |
                               v
                         +-----------+
                         |   Nginx   |
                         | Container |
                         +-----------+
                               |
                               v
                       +---------------+
                       | Apache Tomcat |
                       |   Container   |
                       +---------------+
                          |          |
                          |          |
                          v          v
                   +----------+   +----------+
                   | RabbitMQ |   | MongoDB  |
                   |Container |   | Container|
                   +----------+   +----------+
```

Each service runs inside its own container while Docker Compose provides the networking required for the containers to communicate with one another.

---

## Ìª†Ô∏è Technologies Used

| Technology     | Purpose                                    |
| -------------- | ------------------------------------------ |
| Vagrant        | Creates and manages the VM                 |
| VirtualBox     | Virtualization provider                    |
| Docker         | Container runtime                          |
| Docker Compose | Runs and manages multiple containers       |
| Nginx          | Web server / reverse proxy                 |
| Apache Tomcat  | Java application server                    |
| RabbitMQ       | Message broker                             |
| MongoDB        | Database                                   |
| Git & GitHub   | Version control and source code management |

---

# Ì∫Ä Project Setup

## 1. Clone the Repository

Clone the project repository:

```bash
git clone <YOUR_REPOSITORY_URL>
cd <YOUR_PROJECT_DIRECTORY>
```

---

## 2. Start the Vagrant Environment

The project uses Vagrant to create the virtual machine environment.

Run:

```bash
vagrant up
```

During provisioning, the Vagrant configuration prepares the VM and installs Docker and the required Docker components.

Check the VM status:

```bash
vagrant status
```

You should see the VM in a `running` state.

---

## 3. Connect to the VM

After the VM has started, connect to it using:

```bash
vagrant ssh
```

Once connected, switch to the root user if required:

```bash
sudo -i
```

> **Note:** Root access may be required for certain Docker administration tasks depending on the VM configuration.

---

# Ì∞≥ Docker Compose

Docker Compose allows multiple containers to be defined and managed from a single configuration file.

The Compose configuration is stored in:

```text
docker-compose.yml
```

Instead of manually starting Nginx, Tomcat, RabbitMQ, MongoDB, and other services one by one, Docker Compose reads the configuration and starts the required services together.

---

## 4. Obtain the Docker Compose Configuration

The Docker Compose configuration can be obtained from the project's Docker branch/repository.

Example:

```bash
git clone <YOUR_REPOSITORY_URL>
```

Then switch to the Docker branch:

```bash
git checkout docker
```

Navigate to the Compose directory:

```bash
mkdir compose
cd compose
```

If the `docker-compose.yml` file is downloaded separately, place it inside the `compose` directory.

Verify the file:

```bash
ls
```

You should see:

```text
docker-compose.yml
```

---

# ‚ñ∂Ô∏è Start the Application

From the directory containing `docker-compose.yml`, run:

```bash
docker compose up -d
```

The `-d` option runs the containers in detached mode, allowing them to run in the background.

Docker Compose will:

1. Read the `docker-compose.yml` file.
2. Pull the required images if they are not available locally.
3. Create the required networks.
4. Create the containers.
5. Start the containers.
6. Connect the services through the Docker network.

---

# Ì¥ç Verify the Containers

To check the containers managed by Docker Compose:

```bash
docker compose ps
```

You can also use:

```bash
docker ps
```

The containers should be running.

Example:

```text
CONTAINER ID   IMAGE          STATUS          PORTS
xxxxxxxxxxxx   nginx          Up              ...
xxxxxxxxxxxx   tomcat         Up              ...
xxxxxxxxxxxx   rabbitmq       Up              ...
xxxxxxxxxxxx   mongo          Up              ...
```

The exact container names, images, ports, and IDs depend on the Compose configuration.

---

# Ì∂ºÔ∏è Check Docker Images

To see the Docker images available on the VM:

```bash
docker images
```

The images used by the application should appear in the list.

Docker images are the templates from which containers are created.

For example:

```text
REPOSITORY     TAG       IMAGE ID
nginx          latest    xxxxxxxxx
tomcat         latest    xxxxxxxxx
rabbitmq       latest    xxxxxxxxx
mongo          latest    xxxxxxxxx
```

---

# Ìºê Access the Application

To determine the IP address of the Vagrant VM, run:

```bash
ip addr show
```

or:

```bash
hostname -I
```

Find the VM's IP address.

Then open a browser and enter:

```text
http://<VM-IP>
```

For example:

```text
http://192.168.x.x
```

The request reaches the Nginx container, which acts as the entry point to the application.

Nginx then routes the request to the appropriate application service, such as the Tomcat container.

---

# Ì¥Ñ How the Services Work Together

The services communicate through the Docker network created by Docker Compose.

### Nginx

Nginx serves as the frontend entry point and reverse proxy.

```text
Browser
   |
   v
Nginx
```

### Tomcat

Tomcat runs the Java-based VProfile application.

```text
Nginx
   |
   v
Tomcat
```

### RabbitMQ

RabbitMQ provides message-broker functionality for communication between application components.

```text
Application
     |
     v
 RabbitMQ
```

### MongoDB

MongoDB provides database functionality for storing application data.

```text
Application
     |
     v
 MongoDB
```

Together, these services form the complete application stack.

---

# Ì≥ä Useful Docker Commands

## List Running Containers

```bash
docker ps
```

## List All Containers

```bash
docker ps -a
```

## List Docker Images

```bash
docker images
```

## View Container Logs

```bash
docker logs <container_name>
```

Follow logs continuously:

```bash
docker logs -f <container_name>
```

## Inspect a Container

```bash
docker inspect <container_name>
```

---

# Ì∞≥ Useful Docker Compose Commands

## Start Services

```bash
docker compose up -d
```

## Check Services

```bash
docker compose ps
```

## View Logs

```bash
docker compose logs
```

Follow logs:

```bash
docker compose logs -f
```

## Stop the Application

```bash
docker compose down
```

This stops and removes the containers created by the Compose project.

---

# Ì∑π Docker Cleanup

After stopping the application, unused Docker resources can be cleaned up.

To remove unused Docker resources:

```bash
docker system prune
```

To remove unused images, containers, networks, and other resources:

```bash
docker system prune -a
```

> ‚ö†Ô∏è **Warning:** `docker system prune -a` can remove unused images and other Docker resources. Review the confirmation prompt carefully before proceeding.

---

# Ì¥Ñ Application Lifecycle

The general workflow for this project is:

```text
1. Start Vagrant
       |
       v
2. Provision VM
       |
       v
3. Docker is installed
       |
       v
4. Connect to VM
       |
       v
5. Get docker-compose.yml
       |
       v
6. Run docker compose up -d
       |
       v
7. Containers are created
       |
       v
8. Verify containers
       |
       v
9. Access application through browser
       |
       v
10. Test application
```

---

# Ì≥Å Suggested Project Structure

```text
vprofile-docker/
‚îÇ
‚îú‚îÄ‚îÄ Vagrantfile
‚îú‚îÄ‚îÄ docker-compose.yml
‚îú‚îÄ‚îÄ README.md
‚îÇ
‚îú‚îÄ‚îÄ compose/
‚îÇ   ‚îî‚îÄ‚îÄ docker-compose.yml
‚îÇ
‚îî‚îÄ‚îÄ screenshots/
    ‚îú‚îÄ‚îÄ vagrant-status.png
    ‚îú‚îÄ‚îÄ docker-ps.png
    ‚îî‚îÄ‚îÄ application.png
```

Adjust the structure according to the actual files in your repository.

---

# ÌæØ What I Learned

Through this project, I gained practical experience with:

* Creating virtual machines using Vagrant.
* Provisioning a VM automatically.
* Installing and using Docker inside a VM.
* Understanding Docker images and containers.
* Running multiple containers as one application.
* Using Docker Compose to manage multi-container applications.
* Understanding container-to-container communication.
* Using Nginx as a reverse proxy.
* Running applications with Apache Tomcat.
* Working with RabbitMQ as a message broker.
* Using MongoDB as a database service.
* Checking container status and logs.
* Accessing containerized applications from a browser.
* Cleaning up unused Docker resources.

---

# Ì≤° Why Docker Compose?

Running a multi-service application manually can become difficult because each service needs to be configured and started separately.

Docker Compose simplifies this process by allowing the complete application stack to be described in a single YAML file.

Instead of running several commands individually, we can use:

```bash
docker compose up -d
```

Docker Compose then starts the services defined in the Compose configuration.

This makes the environment:

* Easier to reproduce
* Easier to manage
* Easier to test
* Easier to share with other developers
* More consistent across environments

---

# ‚ö†Ô∏è Important Note

This project is a learning and demonstration project focused on **containerization and DevOps practices**.

The exact images, ports, environment variables, credentials, container names, and service configurations should always be taken from the project's actual `docker-compose.yml` and Vagrant configuration rather than assumed from this README.

---

# Ì±®‚ÄçÌ≤ª Author

**Yakub Adekola Ojo**

This project is part of my ongoing DevOps learning journey, where I am building practical experience with:

* Linux
* Bash Scripting
* Git & GitHub
* Vagrant
* Docker
* Docker Compose
* CI/CD
* Cloud & Deployment

---

## ‚≠ê Acknowledgement

This project was created as part of my hands-on DevOps learning and practical exploration of containerized application deployment.

If you find this project useful, feel free to ‚≠ê the repository and follow my learning journey.

