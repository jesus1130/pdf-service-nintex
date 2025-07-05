FROM python:3.11-slim

# Instala wkhtmltopdf y dependencias del sistema
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    build-essential \
    libffi-dev \
    libssl-dev \
    libjpeg-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Crea directorio de trabajo
WORKDIR /app

# Copia archivos
COPY . .

# Instala dependencias Python
RUN pip install -r requirements.txt

# Expone el puerto
EXPOSE 8000

# Comando para iniciar el servidor
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
