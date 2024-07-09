# 使用 UnityCI 提供的官方镜像
FROM FROM unityci/editor:2021.1.17f1-ubuntu-0.10.0

# 设置工作目录
WORKDIR /app

# 设置 DEBIAN_FRONTEND 环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的工具和依赖项
RUN apt-get update && \
    apt-get install -y wget gnupg2 software-properties-common

# 设置时区环境变量并配置 tzdata
ENV TZ=Etc/UTC
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get install -y tzdata


# 复制当前目录下的所有文件到容器的 /app 目录
COPY . .

# 运行 Unity 构建命令
RUN /opt/unity/Editor/Unity \
    -batchmode \
    -nographics \
    -quit \
    -projectPath /app \
    -buildTarget Win64 \
    -executeMethod BuildScript.Build
