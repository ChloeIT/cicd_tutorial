FROM ubuntu:latest

# Đặt thông tin người duy trì
LABEL maintainer="ngglinh02@gmail.com"

# Cập nhật và cài đặt các gói cần thiết
RUN apt-get update -y && \
    apt-get install -y python3-venv python3-pip python3-dev build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Thêm mã nguồn vào thư mục /flask_app
ADD . /flask_app

# Đặt thư mục làm việc
WORKDIR /flask_app

# Tạo môi trường ảo và cài đặt các gói từ requirements.txt
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Thiết lập biến môi trường để sử dụng môi trường ảo
ENV PATH="/flask_app/venv/bin:$PATH"

# Thiết lập entrypoint và command
ENTRYPOINT ["python3"]
CMD ["flask_docker.py"]
