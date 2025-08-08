FROM ubuntu:22.04

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-tk \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiar archivos del proyecto
COPY . /app
WORKDIR /app

# Instalar dependencias de Python
RUN pip3 install pyinstaller
RUN pip3 install -r requirements.txt

# Construir ejecutable
RUN pyinstaller --onefile --windowed --name MueveMouse mueve_mouse.py

# El ejecutable estará en /app/dist/MueveMouse
