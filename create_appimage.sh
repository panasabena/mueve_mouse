#!/bin/bash

# Script para crear un AppImage para Linux
# Requiere: appimagetool (descargar desde: https://github.com/AppImage/AppImageKit/releases)

set -e

echo "🐧 Creando AppImage para Linux..."

# Verificar que existe el ejecutable
if [ ! -f "dist/MueveMouse" ]; then
    echo "❌ Error: No se encontró dist/MueveMouse"
    echo "Ejecuta primero: python build.py"
    exit 1
fi

# Verificar que appimagetool esté disponible
if [ -f "./appimagetool-x86_64.AppImage" ]; then
    APPIMAGETOOL="./appimagetool-x86_64.AppImage"
elif command -v appimagetool &> /dev/null; then
    APPIMAGETOOL="appimagetool"
else
    echo "❌ Error: appimagetool no está instalado"
    echo "Descarga desde: https://github.com/AppImage/AppImageKit/releases"
    echo "O instala con: sudo apt install appimagetool"
    exit 1
fi

# Crear estructura de AppDir
echo "📁 Creando estructura de AppDir..."
mkdir -p AppDir/usr/bin
mkdir -p AppDir/usr/share/applications
mkdir -p AppDir/usr/share/icons/hicolor/256x256/apps

# Copiar ejecutable
cp dist/MueveMouse AppDir/usr/bin/

# Crear archivo .desktop
cat > AppDir/usr/share/applications/mueve-mouse.desktop << EOF
[Desktop Entry]
Name=Mueve Mouse
Comment=Aplicación para mantener la pantalla activa
Exec=mueve-mouse
Icon=mueve-mouse
Terminal=false
Type=Application
Categories=Utility;
EOF

# Copiar icono si existe
if [ -f "icon.png" ]; then
    cp icon.png AppDir/usr/share/icons/hicolor/256x256/apps/mueve-mouse.png
fi

# Crear AppRun
cat > AppDir/AppRun << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
exec "./usr/bin/MueveMouse" "$@"
EOF

chmod +x AppDir/AppRun

# Crear AppImage
echo "📦 Creando AppImage..."
$APPIMAGETOOL AppDir dist/MueveMouse.AppImage

# Limpiar
rm -rf AppDir

echo "✅ AppImage creado exitosamente: dist/MueveMouse.AppImage"
