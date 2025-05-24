# Node Exporter - Prometheus - Alert Manager - Grafana Stack

A complete monitoring solution stack that provides system metrics collection, storage, alerting, and visualization capabilities.

![Monitoring Stack Architecture](diagram.svg)

## Components

- **Node Exporter**: System metrics collection
- **Prometheus**: Metrics storage and querying
- **Alert Manager**: Alert management and routing
- **Grafana**: Visualization and dashboard platform
- **Nginx**: Reverse proxy with SSL support

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
   - Prometheus: `https://your-domain.com/prometheus`
   - AlertManager: `https://your-domain.com/alertmanager`

## Features

### System Metrics
- CPU usage and load
- Memory utilization
- Disk I/O and space
- Network traffic
- System services status

### Alerting
- Configurable alert rules
- Multiple notification channels
- Alert grouping and routing
- Alert silencing and inhibition

### Visualization
- Pre-configured dashboards
- Custom dashboard creation
- Real-time metrics display
- Historical data analysis

## Default Ports

- Grafana: 3000
- Prometheus: 9090
- AlertManager: 9093
- Node Exporter: 9100
- Nginx: 80/443

## Data Persistence

Data is persisted in the following locations:
- Grafana: `/data/grafana`
- Prometheus: `/data/prometheus`
- AlertManager: `/data/alertmanager`
- Nginx logs: `/data/nginx/logs`

## Security

- Basic authentication for Prometheus and AlertManager
- SSL/TLS encryption for all services
- Grafana sign-up disabled by default
- Secure credential management

## Maintenance

### Updating

To update the stack:
```bash
ansible-playbook -i inventory-hosts deploy.yml
```

### Backup

Regular backups of the following directories are recommended:
- `/data/grafana`
- `/data/prometheus`
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

2. **Metrics not showing**
   - Verify Node Exporter is running: `docker-compose logs node-exporter`
   - Check Prometheus targets: `https://your-domain.com/prometheus/targets`
   - Verify network connectivity between services

3. **AlertManager issues**
   - Check alert configuration
   - Verify notification channels
   - Review AlertManager logs

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