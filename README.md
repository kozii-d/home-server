# Home Server with Traefik Proxy

Welcome to my home server configuration!

This configuration will assist you in setting up your own home server using Traefik as a reverse proxy and docker-compose to manage your services. With Traefik, you can effortlessly manage routing, load balancing, and SSL/TLS termination for your web services.
## System Requirements

Before you begin, ensure that your system meets the following requirements:

- **Docker:** Ensure Docker is installed on your system. If not, download it from [Docker's official website](https://www.docker.com/get-started/).
- **apache2-utils**: Make sure apache2-utils is installed on your system. If not, execute the following command in your terminal:
    ```bash
    sudo apt update
    sudo apt install apache2-utils
    ```
- **Make:** Make sure you have Make installed on your system. Make is typically available on Unix-like operating systems. If Make is not installed, you can install it using the following command:
    ```bash
    sudo apt update
    sudo apt install make
    ```


## Getting Started

Follow these steps to get started with your Traefik Home Server:


1. **Clone Repository:** Clone this repository to your local machine.

2. **Environment Setup:**
    - Copy the `.env.example` file and rename it to `.env`. Execute the following command in your terminal:
      ```
      cp .env.example .env
      ```
    - Open the `.env` file and enter values for the `DOMAIN` and `ROOT_EMAIL` variables according to your requirements.

3. **Traefik Dashboard Authentication:**
    - To add authentication to Traefik dashboard, generate a password hash for the user by executing the following command in your terminal:
      ```
      echo $(htpasswd -nb "<USER>" "<PASSWORD>") | sed -e s/\\$/\\$\\$/g
      ```
    - Copy the username and the generated hash and paste them into the `TRAEFIK_USER` and `TRAEFIK_HASHED_PASSWORD` variables in the `.env` file.

4. **DNS Configuration:**
   - Add DNS records for the subdomains that will be used to access the services. For example, if you want to use the subdomain "traefik", add a DNS record for this subdomain. Otherwise, modify the subdomain in the `docker-compose.servicename.yml` file to suit your needs.

5. **Utilize Makefile:** Utilize the provided Makefile for streamlined command execution. Run `make help` in your terminal to view a list of available commands along with their descriptions.

> **Warning!** To enable staging for Let's Encrypt to avoid hitting rate limits, uncomment the line with the `caServer` setting in the `traefik/docker-compose.traefik.yml` file. When you're ready to obtain real certificates, remember to comment out or remove this line.

## Adding Services

To add a new service to your Traefik setup, follow these guidelines:

**For Docker-based Services:**

Create a separate directory for each service following this structure:
```plaintext
    service/
    ├── conf
    │   └── ...
    ├── data
    │   └── ...
    ├── docker-compose.servicename.yml
    ├── logs
    │   └── ...
    └── README.md
```

By following this structure, you can easily manage and scale your services within Traefik. Each service will have its own `docker-compose.servicename.yml` file, which will be used to define the service's configuration.
Don't forget to add the service to the base `docker-compose.yml` file in the root directory of this repository.

**For Non-Docker Services:**

If you want to add a service that doesn't use Docker, you can still integrate it with Traefik by adding its dynamic configuration YAML files to the `traefik/dynamic` directory. Traefik will automatically detect and configure these services based on the provided configuration files.
