FROM python:3.11-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем весь проект
COPY . .

# Переменные окружения
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV STATIC_ROOT /app/static

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Установка зависимостей для mysqlclient
RUN apk add --no-cache \
    mariadb-dev \
    gcc \
    musl-dev \
    python3-dev \
    pkgconfig && \
    rm -rf /var/cache/apk/*

# Создаем директорию для статики
RUN mkdir -p ${STATIC_ROOT}

COPY wait_for_mysql.sh /wait_for_mysql.sh
RUN chmod +x /wait_for_mysql.sh


# Копируем файл зависимостей
COPY requirements.txt .

# Устанавливаем Python зависимости
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

# Запускаем команду по умолчанию
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

