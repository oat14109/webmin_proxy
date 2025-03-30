#!/bin/bash

echo "Starting Squid..."
service squid start

echo "Starting Webmin..."
service webmin start

# ป้องกัน container exit ทันที
tail -F /var/log/squid/access.log
