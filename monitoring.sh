#!/bin/bash

echo q1w2e3 | sudo -S cp ./prometheus.yml /etc/prometheus/prometheus.yml
echo q1w2e3 | sudo -S systemctl restart prometheus