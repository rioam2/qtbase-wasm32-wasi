FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        locales build-essential ca-certificates cmake libboost-all-dev \
        pkg-config ninja-build curl git wget libssl-dev software-properties-common \
        mesa-utils libglu1-mesa-dev freeglut3-dev mesa-common-dev \
        libglew-dev libglfw3-dev libglm-dev libao-dev libmpg123-dev \
        && \
    apt-get autoremove -y && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/*

# Set locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# LLVM
RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc && \
    echo "deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-17 main" >>/etc/apt/sources.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    clang-17 \
    clangd-17 \
    clang-tidy-17 \
    clang-format-17 \
    clang-tools-17 \
    llvm-17-dev \
    llvm-17-runtime \
    llvm-17-tools \
    lld-17 \
    lldb-17 \
    libomp-17-dev \
    libc++-17-dev \
    libc++abi-17-dev \
    libclang-rt-17-dev \
    libclang-common-17-dev \
    libclang-17-dev \
    libclang-cpp17-dev \
    libfuzzer-17-dev \
    libunwind-17-dev \
    libclang-rt-17-dev \
    libpolly-17-dev && \
    apt-get autoremove -y && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/*

# add llvm to path
ENV PATH="/usr/lib/llvm-17/bin:/usr/lib/llvm-17/include:${PATH}"

# first set LD_LIBRARY_PATH (Debian doesn't set LD_LIBRARY_PATH by default.) and then add LLVM lib folder
ENV LD_LIBRARY_PATH="/usr/lib:/usr/local/lib"
ENV LD_LIBRARY_PATH="/usr/lib/llvm-17/lib:${LD_LIBRARY_PATH:-}"

# unversionize the binaries
RUN ln -s /usr/bin/clang-17 /usr/bin/clang && \
    ln -s /usr/bin/clang++-17 /usr/bin/clang++ && \
    ln -s /usr/bin/clang-format-17 /usr/bin/clang-format

# update compiler environment vars
ENV CC=/usr/bin/clang \
    CXX=/usr/bin/clang++

# update alternatives
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100

RUN useradd -ms /bin/bash worker
USER worker
WORKDIR /home/worker
