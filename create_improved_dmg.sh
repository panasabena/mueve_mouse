#!/bin/bash

# Script para crear un DMG mejorado con instrucciones de instalación
# Incluye solución para el problema de "aplicación dañada"

set -e

echo "🍎 Creando DMG mejorado para macOS..."

# Verificar que existe el ejecutable
if [ ! -d "dist/MueveMouse.app" ]; then
    echo "❌ Error: No se encontró dist/MueveMouse.app"
    echo "Ejecuta primero: python build.py"
    exit 1
fi

# Crear directorio temporal
mkdir -p temp_dmg

# Copiar aplicación
cp -r dist/MueveMouse.app temp_dmg/

# Crear archivo de instrucciones
cat > temp_dmg/INSTRUCCIONES.txt << 'EOF'
MUEVE MOUSE - INSTRUCCIONES DE INSTALACIÓN
============================================

Si macOS dice que la aplicación está "dañada":

OPCIÓN 1 - Permitir desde Preferencias del Sistema:
1. Ve a Preferencias del Sistema → Seguridad y Privacidad
2. Busca el mensaje sobre MueveMouse
3. Haz clic en "Permitir de todas formas"

OPCIÓN 2 - Usar Terminal:
1. Abre Terminal
2. Ejecuta: sudo xattr -rd com.apple.quarantine MueveMouse.app
3. Confirma con tu contraseña

OPCIÓN 3 - Clic derecho:
1. Haz clic derecho en MueveMouse.app
2. Selecciona "Abrir"
3. Confirma que quieres abrir la aplicación

INSTALACIÓN:
1. Arrastra MueveMouse.app a la carpeta Aplicaciones
2. Ejecuta desde Aplicaciones o Launchpad

DESINSTALACIÓN:
1. Arrastra MueveMouse.app a la Papelera
2. Vacía la Papelera

¡Disfruta manteniendo tu pantalla activa! 🖱️
EOF

# Crear DMG mejorado
echo "📦 Creando DMG mejorado..."
create-dmg \
    --volname "Mueve Mouse" \
    --window-pos 200 120 \
    --window-size 600 400 \
    --icon-size 100 \
    --icon "MueveMouse.app" 175 120 \
    --hide-extension "MueveMouse.app" \
    --app-drop-link 425 120 \
    --add-file "INSTRUCCIONES.txt" 175 250 \
    "dist/MueveMouse_Improved.dmg" \
    "temp_dmg/"

# Firmar el DMG
echo "🔐 Firmando DMG..."
codesign --force --deep --sign - "dist/MueveMouse_Improved.dmg"

# Limpiar
rm -rf temp_dmg

echo "✅ DMG mejorado creado: dist/MueveMouse_Improved.dmg"
echo ""
echo "📋 Este DMG incluye:"
echo "- Instrucciones de instalación"
echo "- Solución para el error 'aplicación dañada'"
echo "- Firmado digitalmente"
echo ""
echo "🎯 Para usuarios:"
echo "1. Descargar MueveMouse_Improved.dmg"
echo "2. Seguir las instrucciones incluidas"
echo "3. Si hay problemas, usar las opciones de solución"
