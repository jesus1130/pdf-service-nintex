FROM python:3.11-slim

# Instala wkhtmltopdf y dependencias necesarias
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

# Copia todos los archivos del proyecto
COPY . .

# Instala dependencias Python
RUN pip install -r requirements.txt

# Expone el puerto donde corre gunicorn
EXPOSE 8000

# Comando para ejecutar la app
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
