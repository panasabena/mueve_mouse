#!/bin/bash

# 🍎 Script de instalación automática para MueveMouse
# Hace que la instalación sea súper fácil

echo "🍎 MUEVE MOUSE - Instalador Automático"
echo "======================================"
echo ""

# Verificar si la app está en Aplicaciones
if [ -d "/Applications/MueveMouse.app" ]; then
    echo "✅ MueveMouse ya está instalado en Aplicaciones"
    echo ""
    echo "🔧 Removiendo bandera de cuarentena..."
    sudo xattr -rd com.apple.quarantine /Applications/MueveMouse.app 2>/dev/null
    echo "✅ ¡Listo! Ahora puedes abrir MueveMouse desde Aplicaciones"
    echo ""
    echo "🚀 Para abrir:"
    echo "   • Ve a Aplicaciones"
    echo "   • Haz doble clic en MueveMouse"
    echo "   • O usa Spotlight (Cmd + Espacio) y escribe 'MueveMouse'"
    echo ""
    echo "📋 Instrucciones de uso:"
    echo "   1. Configura el intervalo (ej: 30 segundos)"
    echo "   2. Clic en 'Iniciar Movimiento'"
    echo "   3. ¡Listo! El mouse se moverá automáticamente"
    echo ""
else
    echo "❌ MueveMouse no está instalado en Aplicaciones"
    echo ""
    echo "📥 Para instalar:"
    echo "   1. Descarga MueveMouse.dmg desde GitHub"
    echo "   2. Haz doble clic para abrir"
    echo "   3. Arrastra MueveMouse.app a la carpeta Aplicaciones"
    echo "   4. Ejecuta este script nuevamente"
    echo ""
    echo "🔗 Descargar: https://github.com/panasabena/mueve_mouse"
fi

echo "📞 ¿Necesitas ayuda?"
echo "   • GitHub: https://github.com/panasabena/mueve_mouse"
echo "   • Issues: https://github.com/panasabena/mueve_mouse/issues"
echo ""
echo "✨ ¡Gracias por usar MueveMouse!"
