FROM rockylinux/rockylinux:10

RUN dnf install -y \
    git \
    which \ 
    wget \
    procps \
    openssh-clients \
    && dnf clean all

# vscode ユーザー
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

WORKDIR /workspace

# vscode user に切り替え
USER vscode

CMD ["sleep", "infinity"]
