FROM --platform=linux/amd64 continuumio/miniconda3

RUN apt-get update && apt-get install libgl1 -y

RUN conda init bash && . /root/.bashrc && conda update conda && \
    conda create -n dactyl-keyboard python=3.8 && conda activate dactyl-keyboard && \
    conda install -c conda-forge -c cadquery cadquery=master -y && \
    pip install dataclasses-json numpy scipy solidpython gitpython && \
    conda update --all -y && \
    echo 'conda activate dactyl-keyboard' >> /root/.bashrc

WORKDIR /app

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
CMD ["python src/dactyl_manuform.py"]