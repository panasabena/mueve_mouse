#!/bin/bash

# 🐧 Script para construir MueveMouse en Linux
# Este script debe ejecutarse en un sistema Linux

echo "🐧 Construyendo MueveMouse para Linux..."
echo "========================================"

# Verificar que estamos en Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "❌ Error: Este script debe ejecutarse en Linux"
    echo "   Actualmente estás en: $OSTYPE"
    echo ""
    echo "💡 Para construir para Linux:"
    echo "   1. Usa una máquina virtual con Linux"
    echo "   2. Usa Docker con Linux"
    echo "   3. Usa GitHub Actions (recomendado)"
    exit 1
fi

echo "✅ Sistema Linux detectado: $OSTYPE"
echo ""

# Instalar dependencias
echo "📦 Instalando dependencias..."
pip install pyinstaller
pip install -r requirements.txt

# Construir ejecutable
echo "🔨 Construyendo ejecutable..."
pyinstaller --onefile --windowed --name MueveMouse mueve_mouse.py

# Verificar el ejecutable
echo "🔍 Verificando ejecutable..."
file dist/MueveMouse

echo ""
echo "✅ ¡Construcción completada!"
echo "📁 Archivo generado: dist/MueveMouse"
echo ""
echo "🧪 Para probar:"
echo "   ./dist/MueveMouse"
echo ""
echo "📦 Para crear paquete:"
echo "   ./create_linux_package.sh"
