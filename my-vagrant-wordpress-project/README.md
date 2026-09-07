# My Vagrant WordPress Project

This project sets up a WordPress environment using Vagrant. It utilizes the `ubuntu/jammy64` box and provisions the virtual machine with a script to install and configure WordPress.

## Project Structure

```
my-vagrant-wordpress-project
├── Vagrantfile
├── provisioning
│   └── setup-wordpress.sh
└── README.md
```

## Getting Started

To get started with this project, follow these steps:

1. **Install Vagrant**: Make sure you have Vagrant installed on your machine. You can download it from [Vagrant's official website](https://www.vagrantup.com/downloads).

2. **Clone the Repository**: Clone this repository to your local machine.

   ```bash
   git clone <repository-url>
   cd my-vagrant-wordpress-project
   ```

3. **Start the Vagrant Environment**: Run the following command to start the Vagrant environment:

   ```bash
   vagrant up
   ```

   This command will create and configure the virtual machine as specified in the `Vagrantfile`.

4. **Access the Virtual Machine**: Once the VM is up and running, you can SSH into it using:

   ```bash
   vagrant ssh
   ```

5. **Access WordPress**: After the provisioning script has completed, you can access your WordPress site by navigating to `http://192.168.55.77` in your web browser.

## Additional Setup

- Ensure that your local machine's firewall allows traffic to the specified private and public network IPs.
- You may need to adjust your hosts file if you want to use a custom domain for your WordPress site.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.