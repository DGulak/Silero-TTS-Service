# Используем образ python
FROM python:3.10

# Установим рабочую директорию
WORKDIR /usr/app

# Обновим пакеты и установим необходимые зависимости
RUN apt-get update --fix-missing && apt-get upgrade -y
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN apt-get install -y sox libsox-fmt-mp3 sox

ENV PYTHONUNBUFFERED=1

# Установим pip и setuptools
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

# Установим PyTorch для ARM
RUN pip3 install --verbose https://download.pytorch.org/whl/cpu/torch-2.3.1-cp310-cp310-manylinux_2_17_aarch64.manylinux2014_aarch64.whl

# Установим зависимости из requirements_docker.txt
ADD requirements_docker.txt .

# если файл requirements_docker.txt не меняется
RUN pip3 install -r requirements_docker.txt

# Добавим остальные файлы проекта
ADD ./ ./

EXPOSE 9898

# Запустим приложение
CMD [ "python3", "-u", "./main.py" ]
