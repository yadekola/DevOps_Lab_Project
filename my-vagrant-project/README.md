# My Vagrant Project

This project sets up a virtual machine using Vagrant with the following specifications:

- **Box Name**: `ubuntu/jammy64`
- **Private Network**: Configured with the IP address `192.168.55.77`
- **Public Network**: Enabled for external access

## Getting Started

To start the Vagrant environment, follow these steps:

1. **Install Vagrant**: Ensure you have Vagrant installed on your machine. You can download it from [Vagrant's official website](https://www.vagrantup.com/downloads).

2. **Clone the Repository**: Clone this repository to your local machine.

   ```bash
   git clone <repository-url>
   cd my-vagrant-project
   ```

3. **Start the Vagrant VM**: Run the following command to start the virtual machine:

   ```bash
   vagrant up
   ```

4. **Access the VM**: Once the VM is up and running, you can SSH into it using:

   ```bash
   vagrant ssh
   ```

## Provisioning

The provisioning script located at `provisioning/setup.sh` is executed automatically when the VM is created. This script installs necessary packages and sets up a website from `tooplate.com`.

## Stopping the VM

To stop the virtual machine, use the following command:

```bash
vagrant halt
```

## Destroying the VM

If you want to remove the VM completely, run:

```bash
vagrant destroy
```

This will delete all resources created during the `vagrant up` process.