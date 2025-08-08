#!/bin/bash

# Script para crear un paquete tar.gz para Linux
# Alternativa al AppImage que funciona en cualquier sistema

set -e

echo "🐧 Creando paquete tar.gz para Linux..."

# Verificar que existe el ejecutable
if [ ! -f "dist/MueveMouse" ]; then
    echo "❌ Error: No se encontró dist/MueveMouse"
    echo "Ejecuta primero: python build.py"
    exit 1
fi

# Crear estructura del paquete
echo "📁 Creando estructura del paquete..."
mkdir -p mueve-mouse-linux/usr/bin
mkdir -p mueve-mouse-linux/usr/share/applications
mkdir -p mueve-mouse-linux/usr/share/icons/hicolor/256x256/apps
mkdir -p mueve-mouse-linux/usr/share/doc/mueve-mouse

# Copiar ejecutable
cp dist/MueveMouse mueve-mouse-linux/usr/bin/mueve-mouse
chmod +x mueve-mouse-linux/usr/bin/mueve-mouse

# Crear archivo .desktop
cat > mueve-mouse-linux/usr/share/applications/mueve-mouse.desktop << 'EOF'
[Desktop Entry]
Name=Mueve Mouse
Comment=Aplicación para mantener la pantalla activa
Exec=mueve-mouse
Icon=mueve-mouse
Terminal=false
Type=Application
Categories=Utility;
Keywords=mouse;screen;automation;utility;
EOF

# Copiar documentación
cp README.md mueve-mouse-linux/usr/share/doc/mueve-mouse/
cp LICENSE.txt mueve-mouse-linux/usr/share/doc/mueve-mouse/

# Crear script de instalación
cat > mueve-mouse-linux/install.sh << 'EOF'
#!/bin/bash

echo "Instalando Mueve Mouse..."

# Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then
    echo "Este script debe ejecutarse como root (usar sudo)"
    exit 1
fi

# Copiar archivos
cp -r usr/* /usr/

# Actualizar base de datos de aplicaciones
update-desktop-database /usr/share/applications

echo "✅ Mueve Mouse instalado correctamente"
echo "Puedes ejecutarlo desde el menú de aplicaciones o con: mueve-mouse"
EOF

chmod +x mueve-mouse-linux/install.sh

# Crear script de desinstalación
cat > mueve-mouse-linux/uninstall.sh << 'EOF'
#!/bin/bash

echo "Desinstalando Mueve Mouse..."

# Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then
    echo "Este script debe ejecutarse como root (usar sudo)"
    exit 1
fi

# Eliminar archivos
rm -f /usr/bin/mueve-mouse
rm -f /usr/share/applications/mueve-mouse.desktop
rm -rf /usr/share/doc/mueve-mouse

# Actualizar base de datos de aplicaciones
update-desktop-database /usr/share/applications

echo "✅ Mueve Mouse desinstalado correctamente"
EOF

chmod +x mueve-mouse-linux/uninstall.sh

# Crear README para Linux
cat > mueve-mouse-linux/README_LINUX.txt << 'EOF'
MUEVE MOUSE - INSTALACIÓN EN LINUX
====================================

Este paquete contiene Mueve Mouse para Linux.

INSTALACIÓN:
1. Extraer el archivo: tar -xzf mueve-mouse-linux.tar.gz
2. Entrar al directorio: cd mueve-mouse-linux
3. Ejecutar como root: sudo ./install.sh

DESINSTALACIÓN:
1. Entrar al directorio: cd mueve-mouse-linux
2. Ejecutar como root: sudo ./uninstall.sh

EJECUCIÓN:
- Desde el menú de aplicaciones
- Desde terminal: mueve-mouse

NOTAS:
- Se requiere permisos de root para la instalación
- La aplicación aparecerá en el menú de aplicaciones
- Funciona en la mayoría de distribuciones Linux
EOF

# Crear paquete tar.gz
echo "📦 Creando paquete tar.gz..."
tar -czf dist/mueve-mouse-linux.tar.gz mueve-mouse-linux/

# Limpiar
rm -rf mueve-mouse-linux

echo "✅ Paquete Linux creado exitosamente: dist/mueve-mouse-linux.tar.gz"
echo ""
echo "📋 Instrucciones para usuarios Linux:"
echo "1. Descargar: mueve-mouse-linux.tar.gz"
echo "2. Extraer: tar -xzf mueve-mouse-linux.tar.gz"
echo "3. Instalar: cd mueve-mouse-linux && sudo ./install.sh"
echo "4. Ejecutar: mueve-mouse"
