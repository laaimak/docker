FROM python:3.11-alpine as builder

WORKDIR /app

RUN apk add --no-cache \
    mariadb-dev \
    gcc \
    musl-dev \
    python3-dev \
    pkgconfig

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.11-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

RUN apk add --no-cache \
    mariadb-connector-c

COPY --from=builder /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=builder /usr/local/bin /usr/local/bin

# Копируем проект
COPY . .

COPY wait_for_mysql.sh /wait_for_mysql.sh
RUN chmod +x /wait_for_mysql.sh

# Создаем директорию для статики
RUN mkdir -p /app/static

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]