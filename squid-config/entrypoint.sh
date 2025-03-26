#!/bin/bash

# เตรียม swap dir ถ้ายังไม่มี
if [ ! -d "/var/spool/squid/00" ]; then
    echo "🔧 Running squid -z to init cache directories..."
    /usr/sbin/squid -z
fi

echo "🚀 Starting squid..."
exec /usr/sbin/squid -N -d 1
