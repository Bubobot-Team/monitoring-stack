#!/bin/bash

# Path to the inventory file and prometheus config
INVENTORY_FILE="inventory-hosts"
PROMETHEUS_CONFIG="prometheus/prometheus.yml"

# Create a temporary file for the new config
TEMP_CONFIG=$(mktemp)

# Write the static part of the config
cat > "$TEMP_CONFIG" << 'EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s

rule_files:
  - "rules.yml"

alerting:
  alertmanagers:
    - static_configs:
        - targets: ["localhost:9093"]

scrape_configs:
  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']
  
  - job_name: 'exporters'
    static_configs:
      - targets:
EOF

# Extract exporter nodes from inventory file and append to config
grep -A 10 '^\[exporters\]' "$INVENTORY_FILE" | grep -v '^\[exporters\]' | grep -v '^$' | while read -r line; do
    if [[ $line =~ ansible_host=([0-9.]+).*node_port=([0-9]+) ]]; then
        host="${BASH_REMATCH[1]}"
        port="${BASH_REMATCH[2]}"
        echo "        - '${host}:${port}'" >> "$TEMP_CONFIG"
    fi
done

# Replace the old config with the new one
mv "$TEMP_CONFIG" "$PROMETHEUS_CONFIG"

echo "Prometheus configuration has been updated based on inventory-hosts" 