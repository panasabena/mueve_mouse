# Mueve Mouse 🖱️

Una aplicación profesional para mantener tu pantalla activa moviendo el mouse automáticamente. Perfecta para evitar que tu computadora se bloquee durante presentaciones, videoconferencias o cuando necesitas mantener la pantalla activa.

## ✨ Características

- **Interfaz gráfica intuitiva**: Fácil de usar con controles claros
- **Configuración personalizable**: Ajusta intervalos y posiciones del mouse
- **Guardado automático**: Tu configuración se guarda automáticamente
- **Modo de prueba**: Prueba el movimiento antes de activarlo
- **Detención de emergencia**: Mueve el mouse a las esquinas para detener
- **Multiplataforma**: Funciona en Windows, macOS y Linux
- **Sin dependencias externas**: Ejecutable independiente

## 🚀 Instalación

### Opción 1: Instalador (Recomendado)

#### Windows
1. Descarga el archivo `mueve-mouse-windows.zip`
2. Extrae el archivo ZIP
3. Ejecuta como administrador: `INSTALAR.bat`
4. La aplicación se instalará automáticamente en el escritorio y menú inicio
5. Para desinstalar: ejecutar `DESINSTALAR.bat` como administrador

#### macOS
1. Descarga el archivo `MueveMouse.dmg`
2. Abre el archivo DMG
3. Arrastra la aplicación a la carpeta Aplicaciones
4. Ejecuta desde Aplicaciones

#### Linux
1. Descarga el archivo `mueve-mouse-linux.tar.gz`
2. Extrae el archivo: `tar -xzf mueve-mouse-linux.tar.gz`
3. Entra al directorio: `cd mueve-mouse-linux`
4. Instala como root: `sudo ./install.sh`
5. Ejecuta desde el menú de aplicaciones o con: `mueve-mouse`

### Opción 2: Desde el código fuente

#### Requisitos previos
- Python 3.7 o superior
- pip (gestor de paquetes de Python)

#### Pasos de instalación
```bash
# 1. Clona o descarga el proyecto
git clone https://github.com/tu-usuario/mueve-mouse.git
cd mueve-mouse

# 2. Instala las dependencias
pip install -r requirements.txt

# 3. Ejecuta la aplicación
python mueve_mouse.py
```

## 📖 Cómo usar

### Inicio rápido
1. **Abrir la aplicación**: Ejecuta Mueve Mouse desde el menú de inicio o escritorio
2. **Configurar**: Ajusta el intervalo y las posiciones del mouse según tus necesidades
3. **Probar**: Usa el botón "Probar movimiento" para verificar la configuración
4. **Iniciar**: Presiona "Iniciar" para comenzar el movimiento automático
5. **Detener**: Usa "Detener" o cierra la aplicación para parar

### Configuración avanzada

#### Intervalo de tiempo
- **Recomendado**: 5-10 segundos
- **Mínimo**: 1 segundo
- **Máximo**: Sin límite (pero no recomendado más de 60 segundos)

#### Posiciones del mouse
- **Posición 1**: Primera posición donde se moverá el mouse
- **Posición 2**: Segunda posición donde se moverá el mouse
- **Obtener posición actual**: Usa este botón para ver dónde está tu mouse

#### Consejos de configuración
- **Movimiento sutil**: Usa posiciones cercanas (ej: 300,310 y 320,310)
- **Movimiento visible**: Usa posiciones más separadas para mayor efecto
- **Evitar interferencias**: No uses posiciones donde tengas botones o enlaces importantes

### Funciones especiales

#### Detención de emergencia
- **Método 1**: Mueve el mouse a cualquier esquina de la pantalla
- **Método 2**: Presiona Ctrl+C en la consola (si ejecutas desde terminal)
- **Método 3**: Usa el botón "Detener" en la aplicación

#### Guardado automático
- La configuración se guarda automáticamente en `mueve_mouse_config.json`
- Se restaura automáticamente al abrir la aplicación
- Puedes editar manualmente el archivo si es necesario

## 🛠️ Desarrollo

### Estructura del proyecto
```
mueve-mouse/
├── mueve_mouse.py          # Aplicación principal
├── requirements.txt         # Dependencias de Python
├── mueve_mouse.spec        # Configuración de PyInstaller
├── build.py                # Script de construcción
├── installer_config.nsi    # Configuración del instalador
├── README.md              # Este archivo
└── LICENSE.txt            # Licencia del proyecto
```

### Construir desde el código fuente

#### Requisitos de desarrollo
- Python 3.7+
- PyInstaller
- NSIS (solo para Windows)

#### Pasos para construir
```bash
# 1. Instalar dependencias de desarrollo
pip install pyinstaller

# 2. Ejecutar script de construcción
python build.py

# 3. Los ejecutables se crearán en la carpeta dist/
```

### Crear instalador (Windows)
```bash
# 1. Instalar NSIS
# Descarga desde: https://nsis.sourceforge.io/

# 2. Construir instalador
makensis installer_config.nsi
```

## 🔧 Solución de problemas

### Problemas comunes

#### La aplicación no inicia
- **Verificar permisos**: Asegúrate de tener permisos de administrador
- **Antivirus**: Algunos antivirus pueden bloquear la aplicación
- **Dependencias**: Verifica que todas las dependencias estén instaladas

#### El mouse no se mueve
- **Verificar posiciones**: Asegúrate de que las posiciones estén dentro de la pantalla
- **Permisos de accesibilidad**: En macOS, puede necesitar permisos de accesibilidad
- **Configuración**: Prueba con posiciones diferentes

#### La aplicación se cierra inesperadamente
- **Logs**: Revisa los logs en la consola
- **Configuración**: Elimina el archivo de configuración y reinicia
- **Reinstalar**: Desinstala y vuelve a instalar la aplicación

### Logs y debugging
- Los logs se muestran en la consola si ejecutas desde terminal
- El archivo de configuración está en: `mueve_mouse_config.json`
- En Windows: `%APPDATA%\Mueve Mouse\`
- En macOS: `~/Library/Application Support/Mueve Mouse/`
- En Linux: `~/.config/Mueve Mouse/`

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver `LICENSE.txt` para más detalles.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Haz un fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Soporte

Si tienes problemas o preguntas:

- **Issues**: Abre un issue en GitHub
- **Email**: contacto@tudominio.com
- **Documentación**: Revisa este README

## 🔄 Historial de versiones

### v1.0.0
- Primera versión estable
- Interfaz gráfica completa
- Configuración personalizable
- Soporte multiplataforma
- Instaladores profesionales

## 🙏 Agradecimientos

- **PyAutoGUI**: Por la funcionalidad de control del mouse
- **Tkinter**: Por la interfaz gráfica
- **PyInstaller**: Por el empaquetado multiplataforma
- **NSIS**: Por los instaladores de Windows

---

**¡Disfruta manteniendo tu pantalla activa! 🎉**
