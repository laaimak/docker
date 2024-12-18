FROM python:3.11-alpine

# Установка зависимостей для mysqlclient
RUN apk add --no-cache \
    mariadb-dev \
    gcc \
    musl-dev \
    python3-dev \
    pkgconfig && \
    rm -rf /var/cache/apk/*


# Устанавливаем рабочую директорию
WORKDIR /app

COPY wait_for_mysql.sh /wait_for_mysql.sh
RUN chmod +x /wait_for_mysql.sh


# Копируем файл зависимостей
COPY requirements.txt .

# Устанавливаем Python зависимости
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь проект
COPY . .

# Запускаем Django приложение
CMD ["sh", "-c", "python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

RUN apk add --no-cache mysql-client


