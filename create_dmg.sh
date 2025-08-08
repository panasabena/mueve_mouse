#!/bin/bash

# Script para crear un instalador DMG para macOS
# Requiere: create-dmg (instalar con: brew install create-dmg)

set -e

echo "🍎 Creando instalador DMG para macOS..."

# Verificar que existe el ejecutable
if [ ! -d "dist/MueveMouse.app" ]; then
    echo "❌ Error: No se encontró dist/MueveMouse.app"
    echo "Ejecuta primero: python build.py"
    exit 1
fi

# Verificar que create-dmg esté instalado
if ! command -v create-dmg &> /dev/null; then
    echo "❌ Error: create-dmg no está instalado"
    echo "Instala con: brew install create-dmg"
    exit 1
fi

# Crear DMG
echo "📦 Creando DMG..."
create-dmg \
    --volname "Mueve Mouse" \
    --volicon "icon.icns" \
    --window-pos 200 120 \
    --window-size 600 400 \
    --icon-size 100 \
    --icon "MueveMouse.app" 175 120 \
    --hide-extension "MueveMouse.app" \
    --app-drop-link 425 120 \
    "dist/MueveMouse.dmg" \
    "dist/"

echo "✅ DMG creado exitosamente: dist/MueveMouse.dmg"
