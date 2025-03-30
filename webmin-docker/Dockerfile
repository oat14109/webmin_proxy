# FROM debian:bullseye-slim

# ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && \
#     apt-get install -y wget apt-transport-https gnupg curl sudo perl net-tools iproute2 squid && \
#     wget http://www.webmin.com/jcameron-key.asc && \
#     apt-key add jcameron-key.asc && \
#     echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list && \
#     apt-get update && \
#     apt-get install -y webmin && \
#     echo "root:P@ssw0rd" | chpasswd && \
#     rm -rf /var/lib/apt/lists/*

# EXPOSE 10000 3128

# CMD service webmin start && tail -f /dev/null && squid -N -d 1


# FROM ubuntu:22.04

# ENV DEBIAN_FRONTEND=noninteractive

# # ติดตั้ง dependencies + python3 + pip
# RUN apt-get update && apt-get install -y \
#     wget \
#     gnupg \
#     apt-transport-https \
#     lsb-release \
#     software-properties-common \
#     sudo \
#     perl \
#     python3 \
#     python3-pip \
#     net-tools \
#     iproute2 \
#     squid \
#     && rm -rf /var/lib/apt/lists/*

# # ติดตั้ง Webmin
# RUN wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add - && \
#     echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list && \
#     apt-get update && apt-get install -y webmin && \
#     rm -rf /var/lib/apt/lists/*

# # ติดตั้ง Supervisor
# RUN pip3 install supervisor

# # ตั้ง root password
# RUN echo "root:P@ssw0rd" | chpasswd

# # ✅ คัดลอก Webmin squid config ล่วงหน้า
# COPY squid-config/config /etc/webmin/squid/config

# # ✅ คัดลอก global config อื่น ๆ (optional)
# # COPY miniserv.conf /etc/webmin/miniserv.conf

# # คัดลอก config supervisor
# COPY supervisord.conf /etc/supervisord.conf

# EXPOSE 3128 10000

# CMD ["supervisord", "-c", "/etc/supervisord.conf"]



FROM ubuntu:22.04


# ป้องกัน prompt ระหว่างติดตั้ง
ENV DEBIAN_FRONTEND=noninteractive

# ติดตั้ง dependencies ที่จำเป็น
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    apt-transport-https \
    lsb-release \
    software-properties-common \
    sudo \
    perl \
    net-tools \
    iproute2 \
    squid \
    systemd \
    systemd-cron \
    && rm -rf /var/lib/apt/lists/*

# ติดตั้ง Webmin
RUN wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add - \
    && add-apt-repository "deb http://download.webmin.com/download/repository sarge contrib" \
    && apt-get update && apt-get install -y webmin \
    && rm -rf /var/lib/apt/lists/*

# ตั้งรหัสผ่าน root (ตัวอย่าง)
RUN echo "root:P@ssw0rd" | chpasswd

# คัดลอกสคริปต์ run.sh เข้าไปใน Container
COPY run.sh /run.sh
RUN chmod +x /run.sh


# # ✅ คัดลอก Webmin squid config ล่วงหน้า
# COPY squid-config/config /etc/webmin/squid/config

# เปิด port 10000 (Webmin) และ 3128 (Squid)
EXPOSE 10000 3128

# เมื่อ container เริ่ม ให้รัน /run.sh
CMD ["/run.sh"]

