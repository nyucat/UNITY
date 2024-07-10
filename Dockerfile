# 使用 Ubuntu 作为基础镜像
FROM ubuntu:latest

# 设置非交互模式
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表
RUN apt-get update

# 安装 wget
RUN apt-get install -y wget

# 安装 libgtk-3-0
RUN apt-get install -y libgtk-3-0

# 安装 libx11-xcb1
RUN apt-get install -y libx11-xcb1

# 安装 libasound2
RUN apt-get install -y libasound2

# 安装 libnss3
RUN apt-get install -y libnss3

# 安装 libglu1-mesa
RUN apt-get install -y libglu1-mesa

# 安装 libxrandr2
RUN apt-get install -y libxrandr2

# 安装 libxinerama1
RUN apt-get install -y libxinerama1

# 安装 libxcursor1
RUN apt-get install -y libxcursor1

# 安装 libxcomposite1
RUN apt-get install -y libxcomposite1

# 安装 libxi6
RUN apt-get install -y libxi6

# 安装 libxtst6
RUN apt-get install -y libxtst6

# 安装 libcurl4
RUN apt-get install -y libcurl4

# 安装 ca-certificates
RUN apt-get install -y ca-certificates

# 安装 xvfb
RUN apt-get install -y xvfb

# 清理 apt 缓存
RUN rm -rf /var/lib/apt/lists/*

# 下载并安装 Unity Hub
RUN wget -q https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage -O /usr/local/bin/UnityHub.AppImage && \
    chmod +x /usr/local/bin/UnityHub.AppImage

# 启动 Unity Hub 并登录（需要手动处理或通过脚本自动化）
# 这里假设你已经在本地登录并接受了 EULA，可以将 Unity Hub 的配置文件复制到 Docker 容器中
COPY unityhub-config.json /root/.config/UnityHub/UnityHub.cfg

# 使用 Unity Hub 安装指定版本的 Unity 编辑器
RUN xvfb-run -a ./usr/local/bin/UnityHub.AppImage -- --headless install --version 2021.1.19f1 --components Unity

# 设置工作目录
WORKDIR /root/project

# 设置时区环境变量并配置 tzdata
ENV TZ=Etc/UTC
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get install -y tzdata

# 拷贝 Unity 项目文件到 Docker 容器中
COPY . /root/project

# 运行 Unity 命令行工具构建项目
RUN xvfb-run -a /opt/unity/Editor/Unity \
    -quit \
    -batchmode \
    -nographics \
    -projectPath /root/project \
    -buildTarget StandaloneLinux64 \
    -executeMethod BuildScript.Build \
    -logFile /root/project/build.log

    # 将构建输出文件夹暴露为 Docker 卷
VOLUME /root/project/Build
