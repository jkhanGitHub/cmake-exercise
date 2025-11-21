FROM ubuntu:24.04


# Install build tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    libdeal.ii-dev \
    libopenmpi-dev \
    wget \
    unzip





# Build yaml-cpp (version 0.6.3)
WORKDIR /tmp
RUN wget -q https://github.com/jbeder/yaml-cpp/archive/refs/tags/yaml-cpp-0.6.3.zip \
    && unzip -q yaml-cpp-0.6.3.zip \
    && cd yaml-cpp-yaml-cpp-0.6.3 \
    && mkdir build && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release .. \
    && make -j$(nproc) && make install



# Build application
WORKDIR /app
COPY . /app

#enable execution of build_and_run.sh and run it
# RUN chmod +x /app/build_and_run.sh
# RUN /app/build_and_run.sh

CMD ["./build/main","/app/yamlParser/config.yml"]