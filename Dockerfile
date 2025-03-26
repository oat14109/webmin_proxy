FROM ubuntu:22.04

# ตั้งค่าให้ไม่ถามคำถามในระหว่างการติดตั้ง package
ENV DEBIAN_FRONTEND=noninteractive

# อัพเดตแพคเกจและติดตั้ง Squid
RUN apt-get update && \
    apt-get install -y squid && \
    rm -rf /var/lib/apt/lists/*

# คัดลอกไฟล์ configuration ของ Squid ไปยัง container
COPY squid-config/squid.conf /etc/squid/squid.conf

# เปิดพอร์ตสำหรับ Squid (ค่าเริ่มต้น 3128)
EXPOSE 3128

# รัน Squid ในโหมด foreground
CMD ["squid", "-N", "-d", "1"]
