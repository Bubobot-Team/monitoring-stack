# Content Demo Monitoring Stack

A pre-configured monitoring stack for demonstration purposes, featuring Grafana, AlertManager, and Nginx.

## Author

Created and maintained by Bubobot Team.

## Components

- **Grafana (v10.2.3)**: Visualization and dashboard platform
- **AlertManager (v0.26.0)**: Alert management and routing
- **Nginx (v1.25)**: Reverse proxy with SSL support

## Prerequisites

- Ansible installed on your control machine
- SSH access to target servers
- Docker and Docker Compose installed on target servers
- Domain name (for SSL configuration)
- Basic understanding of monitoring concepts

## Configuration

1. Edit the inventory file to specify your target hosts:
   ```bash
   # Edit inventory-hosts with your server information
   vim inventory-hosts
   ```

2. Configure the following variables in `.env`:
   ```
   SERVER_NAME=your-domain.com
   GRAFANA_ADMIN_USER=admin
   GRAFANA_ADMIN_PASSWORD=your-secure-password
   ```

3. Place your SSL certificates in `nginx/certs/`:
   - `cert.pem`
   - `key.pem`

## Deployment

1. Deploy the stack using Ansible:
   ```bash
   ansible-playbook -i inventory-hosts deploy.yml
   ```

2. Access the services:
   - Grafana: `https://your-domain.com`
   - AlertManager: `https://your-domain.com/alertmanager`
   - Prometheus: `https://your-domain.com/prometheus`

## Default Ports

- Grafana: 3000
- AlertManager: 9093
- Nginx: 80/443

## Data Persistence

Data is persisted in the following locations:
- Grafana: `/data/grafana`
- AlertManager: `/data/alertmanager`
- Nginx logs: `/data/nginx/logs`

## Security

- Basic authentication is enabled for Prometheus and AlertManager
- SSL/TLS encryption is configured for all services
- Grafana sign-up is disabled by default
- Inventory files should be kept secure and out of version control

## Maintenance

### Updating

To update the stack:
```bash
ansible-playbook -i inventory-hosts deploy.yml
```

### Backup

Regular backups of the following directories are recommended:
- `/data/grafana`
- `/data/alertmanager`

### Logs

View logs for a specific service:
```bash
docker-compose logs -f [service-name]
```

## Troubleshooting

1. **Service not accessible**
   - Check if containers are running: `docker-compose ps`
   - Verify nginx configuration: `docker-compose logs nginx`
   - Check Ansible logs for deployment issues

2. **Grafana login issues**
   - Verify environment variables in `.env`
   - Check Grafana logs: `docker-compose logs grafana`

3. **Ansible deployment issues**
   - Verify SSH access to target servers
   - Check Ansible inventory file configuration
   - Ensure all prerequisites are installed on target servers

## Contributing

This stack is part of the open-source monitoring-stack repository. We welcome contributions! To contribute:

1. Fork the main repository
2. Create a new branch for your changes
3. Make your improvements
4. Submit a pull request

Please ensure your contributions:
- Follow the project's best practices
- Include proper documentation
- Are well-tested
- Add value to the community

## License

This stack is part of the monitoring-stack repository and is available under the MIT License. You are free to:
- Use it in your own projects
- Modify it to suit your needs
- Distribute it
- Contribute back to the project

## Support

For support with this stack:
- Open an issue in the main repository
- Email us at support@bubobot.com
- Join our Discord community: https://discord.gg/qwSKMu4jYA
- Check the documentation for common issues and solutions 