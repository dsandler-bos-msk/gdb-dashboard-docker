ARG from

FROM ${from}

RUN which pip3 || ( apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-pip \
    && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean -y --no-install-recommends && \
    apt-get autoclean -y --no-install-recommends )

RUN which gdb || ( apt-get update && \
    apt-get install -y --no-install-recommends gdb && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean -y --no-install-recommends && \
    apt-get autoclean -y --no-install-recommends )

RUN --mount=type=bind,rw,target=/gdb-dashboard,source=gdb-dashboard \
    cp /gdb-dashboard/.gdbinit /root/ && \
    pip install --no-cache-dir pygments

RUN apt-get update && \
    apt-get install -y locales && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean -y --no-install-recommends && \
    apt-get autoclean -y --no-install-recommends

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

ENV LC_ALL en_US.UTF-8 
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en 
