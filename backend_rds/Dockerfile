# --- Этап 1: Builder ---
# Этот этап собирает наши зависимости. Он будет кеширован и отброшен.
FROM python:3.9-slim as builder

# Устанавливаем переменные окружения заранее
# PYTHONDONTWRITEBYTECODE: не создавать .pyc файлы
# PYTHONUNBUFFERED: логи сразу отправляются в терминал
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 1. Устанавливаем системные зависимости, необходимые для сборки.
# Этот слой редко меняется и будет надежно кеширован.
# --no-install-recommends не устанавливает необязательные пакеты, экономя место.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libpq-dev \
 && rm -rf /var/lib/apt/lists/*

# Создаем виртуальное окружение для чистоты и изоляции
RUN python -m venv /opt/venv

# Явно указываем, что все последующие команды должны использовать venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app

# 2. Копируем ТОЛЬКО файл с зависимостями и устанавливаем их.
# Этот шаг будет выполняться заново, только если requirements.txt изменится.
# Это ключевая оптимизация для скорости сборки!
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt


# --- Этап 2: Final ---
# Этот этап создает финальный, легковесный образ для запуска.
FROM python:3.9-slim

# Устанавливаем те же переменные окружения
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Устанавливаем ТОЛЬКО runtime-зависимости. libpq5 нужна psycopg2 для работы.
# Этот слой также будет кешироваться.
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копируем виртуальное окружение с уже установленными пакетами из builder
COPY --from=builder /opt/venv /opt/venv

# 3. Копируем исходный код приложения в самый последний момент.
# Так как код меняется чаще всего, этот шаг будет сбрасывать кеш только для себя,
# а не для долгих шагов установки зависимостей.
COPY . .

# Устанавливаем PATH, чтобы система использовала Python и пакеты из venv
ENV PATH="/opt/venv/bin:$PATH"

RUN chmod +x entrypoint.sh

EXPOSE 8000

# Запускаем приложение
ENTRYPOINT ["/app/entrypoint.sh"]