FROM ubuntu:16.04 

LABEL maintainer "aimof <aimof.aimof@gmail.com>"

ENV CONDA_DIR /opt/conda
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=$CONDA_DIR/bin:$PATH

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install wget \
        bzip2 \
        cython && \
    apt-get clean && \
    wget -nv https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    chmod +x /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
    mkdir /home/work

COPY ./env.yaml /home/env.yaml

RUN conda env create -f=/home/env.yaml
EXPOSE 8888

WORKDIR /home/work
#COPY ./jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py 

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["source /opt/conda/bin/activate py36 && jupyter notebook --ip 0.0.0.0 --port 8888 --allow-root --no-browser"]
