#!/bin/bash

# Script para crear un paquete portable para Windows
# Alternativa al instalador NSIS que funciona desde cualquier sistema

set -e

echo "🪟 Creando paquete portable para Windows..."

# Verificar que existe el ejecutable
if [ ! -f "dist/MueveMouse.exe" ]; then
    echo "❌ Error: No se encontró dist/MueveMouse.exe"
    echo "Para crear el ejecutable de Windows, necesitas:"
    echo "1. Un sistema Windows"
    echo "2. Python y PyInstaller instalados"
    echo "3. Ejecutar: python build.py"
    echo ""
    echo "O usar GitHub Actions para builds automáticos"
    exit 1
fi

# Crear estructura del paquete
echo "📁 Creando estructura del paquete..."
mkdir -p mueve-mouse-windows
mkdir -p mueve-mouse-windows/docs

# Copiar ejecutable
cp dist/MueveMouse.exe mueve-mouse-windows/
cp LICENSE.txt mueve-mouse-windows/
cp README.md mueve-mouse-windows/docs/

# Crear script de instalación
cat > mueve-mouse-windows/INSTALAR.bat << 'EOF'
@echo off
echo Instalando Mueve Mouse...

REM Crear directorio de instalación
if not exist "%PROGRAMFILES%\Mueve Mouse" mkdir "%PROGRAMFILES%\Mueve Mouse"

REM Copiar archivos
copy "MueveMouse.exe" "%PROGRAMFILES%\Mueve Mouse\"
copy "LICENSE.txt" "%PROGRAMFILES%\Mueve Mouse\"

REM Crear acceso directo en escritorio
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%USERPROFILE%\Desktop\Mueve Mouse.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%PROGRAMFILES%\Mueve Mouse\MueveMouse.exe" >> CreateShortcut.vbs
echo oLink.WorkingDirectory = "%PROGRAMFILES%\Mueve Mouse" >> CreateShortcut.vbs
echo oLink.Description = "Mueve Mouse - Mantén tu pantalla activa" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs

REM Crear acceso directo en menú inicio
if not exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Mueve Mouse" mkdir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Mueve Mouse"
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateStartMenuShortcut.vbs
echo sLinkFile = "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Mueve Mouse\Mueve Mouse.lnk" >> CreateStartMenuShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateStartMenuShortcut.vbs
echo oLink.TargetPath = "%PROGRAMFILES%\Mueve Mouse\MueveMouse.exe" >> CreateStartMenuShortcut.vbs
echo oLink.WorkingDirectory = "%PROGRAMFILES%\Mueve Mouse" >> CreateStartMenuShortcut.vbs
echo oLink.Description = "Mueve Mouse - Mantén tu pantalla activa" >> CreateStartMenuShortcut.vbs
echo oLink.Save >> CreateStartMenuShortcut.vbs
cscript CreateStartMenuShortcut.vbs
del CreateStartMenuShortcut.vbs

echo.
echo ✅ Mueve Mouse instalado correctamente
echo Puedes ejecutarlo desde:
echo - El escritorio: "Mueve Mouse"
echo - El menú inicio: Buscar "Mueve Mouse"
echo - Directamente: "%PROGRAMFILES%\Mueve Mouse\MueveMouse.exe"
echo.
pause
EOF

# Crear script de desinstalación
cat > mueve-mouse-windows/DESINSTALAR.bat << 'EOF'
@echo off
echo Desinstalando Mueve Mouse...

REM Eliminar acceso directo del escritorio
if exist "%USERPROFILE%\Desktop\Mueve Mouse.lnk" del "%USERPROFILE%\Desktop\Mueve Mouse.lnk"

REM Eliminar acceso directo del menú inicio
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Mueve Mouse" rmdir /s /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Mueve Mouse"

REM Eliminar archivos de instalación
if exist "%PROGRAMFILES%\Mueve Mouse" rmdir /s /q "%PROGRAMFILES%\Mueve Mouse"

echo.
echo ✅ Mueve Mouse desinstalado correctamente
echo.
pause
EOF

# Crear README para Windows
cat > mueve-mouse-windows/README_WINDOWS.txt << 'EOF'
MUEVE MOUSE - INSTALACIÓN EN WINDOWS
======================================

Este paquete contiene Mueve Mouse para Windows.

INSTALACIÓN:
1. Extraer el archivo ZIP
2. Ejecutar como administrador: INSTALAR.bat
3. La aplicación se instalará automáticamente

DESINSTALACIÓN:
1. Ejecutar como administrador: DESINSTALAR.bat
2. La aplicación se desinstalará completamente

EJECUCIÓN:
- Desde el escritorio: "Mueve Mouse"
- Desde el menú inicio: Buscar "Mueve Mouse"
- Directamente: "%PROGRAMFILES%\Mueve Mouse\MueveMouse.exe"

NOTAS:
- Se requiere permisos de administrador para la instalación
- La aplicación aparecerá en el escritorio y menú inicio
- Funciona en Windows 7, 8, 10 y 11
- No requiere instalación de dependencias adicionales

SOLUCIÓN DE PROBLEMAS:
- Si el antivirus bloquea la aplicación, agregar a excepciones
- Si no se instala, ejecutar como administrador
- Si no aparece en el menú, reiniciar el explorador de Windows
EOF

# Crear paquete ZIP
echo "📦 Creando paquete ZIP..."
zip -r dist/mueve-mouse-windows.zip mueve-mouse-windows/

# Limpiar
rm -rf mueve-mouse-windows

echo "✅ Paquete Windows creado exitosamente: dist/mueve-mouse-windows.zip"
echo ""
echo "📋 Instrucciones para usuarios Windows:"
echo "1. Descargar: mueve-mouse-windows.zip"
echo "2. Extraer el archivo ZIP"
echo "3. Ejecutar como administrador: INSTALAR.bat"
echo "4. Ejecutar desde el escritorio o menú inicio"
echo ""
echo "⚠️  Nota: Para crear el ejecutable .exe necesitas:"
echo "- Un sistema Windows"
echo "- Python y PyInstaller"
echo "- Ejecutar: python build.py"
