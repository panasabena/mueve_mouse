#!/bin/bash

# 🐳 Script para construir MueveMouse usando Docker
# Esto crea un ejecutable compatible con Linux

echo "🐳 Construyendo MueveMouse para Linux usando Docker..."
echo "======================================================"

# Verificar que Docker esté instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker no está instalado"
    echo ""
    echo "📥 Para instalar Docker:"
    echo "   • macOS: https://docs.docker.com/desktop/mac/install/"
    echo "   • Linux: https://docs.docker.com/engine/install/"
    echo "   • Windows: https://docs.docker.com/desktop/windows/install/"
    exit 1
fi

echo "✅ Docker detectado"
echo ""

# Construir imagen Docker
echo "🔨 Construyendo imagen Docker..."
docker build -t muevemouse-builder .

# Crear contenedor y extraer ejecutable
echo "📦 Extrayendo ejecutable..."
docker create --name temp-container muevemouse-builder
docker cp temp-container:/app/dist/MueveMouse ./MueveMouse_linux
docker rm temp-container

# Verificar el ejecutable
echo "🔍 Verificando ejecutable..."
file MueveMouse_linux

echo ""
echo "✅ ¡Construcción completada!"
echo "📁 Archivo generado: MueveMouse_linux"
echo ""
echo "🧪 Para probar en Linux:"
echo "   chmod +x MueveMouse_linux"
echo "   ./MueveMouse_linux"
echo ""
echo "📦 Para crear paquete:"
echo "   ./create_linux_package.sh"
