FROM python:3.14-slim

WORKDIR /app

# Копируем только файлы зависимостей сначала (ускоряет кеширование)
COPY requirements.txt /app/requirements.txt

RUN pip install --upgrade pip \
    && apt-get update \
    && apt-get install -y netcat-openbsd build-essential libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Установим Python-зависимости
RUN pip install -r /app/requirements.txt

# Копируем всё приложение
COPY . /app

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["gunicorn", "project.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]