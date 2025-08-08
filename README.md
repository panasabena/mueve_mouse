# 🖱️ MueveMouse

Una aplicación simple para mover automáticamente el cursor del mouse, útil para mantener la computadora activa durante presentaciones o evitar que se bloquee por inactividad.

## ✨ Características

- **Interfaz gráfica intuitiva** con Tkinter
- **Configuración de intervalo** personalizable
- **Posiciones de mouse** configurables
- **Guardado de configuración** automático
- **Multiplataforma** (Windows, macOS, Linux)
- **Instalación simple** con ejecutables precompilados

## 🚀 Instalación

### 📱 macOS

1. **Descargar**: [MueveMouse.dmg](https://github.com/panasabena/mueve_mouse/blob/main/MueveMouse.dmg)
2. **Abrir**: Doble clic en el archivo .dmg
3. **Instalar**: Arrastrar `MueveMouse.app` a la carpeta Aplicaciones
4. **Ejecutar**: Abrir desde Aplicaciones o Spotlight

**⚠️ Si aparece "aplicación dañada":**
- **Opción A**: Clic derecho → Abrir → Abrir
- **Opción B**: Terminal: `sudo xattr -rd com.apple.quarantine /Applications/MueveMouse.app`
- **Opción C**: Preferencias del Sistema → Seguridad y Privacidad → Permitir

### 🪟 Windows

1. **Descargar**: [mueve-mouse-windows.zip](https://github.com/panasabena/mueve_mouse/releases)
2. **Extraer**: Descomprimir el archivo .zip
3. **Instalar**: Ejecutar `INSTALAR.bat` como administrador
4. **Ejecutar**: Buscar "MueveMouse" en el menú inicio

### 🐧 Linux

#### Opción 1: Ejecutable precompilado (Recomendado)
1. **Descargar**: [mueve-mouse-linux.tar.gz](https://github.com/panasabena/mueve_mouse/releases)
2. **Extraer**: `tar -xzf mueve-mouse-linux.tar.gz`
3. **Instalar**: `cd mueve-mouse-linux && ./install.sh`
4. **Ejecutar**: Buscar "MueveMouse" en el menú de aplicaciones

#### Opción 2: Construir desde código
```bash
# Clonar repositorio
git clone https://github.com/panasabena/mueve_mouse.git
cd mueve_mouse

# Usar Docker (recomendado)
./build_with_docker.sh

# O construir directamente en Linux
./build_linux.sh
```

## 🎮 Uso

1. **Abrir** MueveMouse
2. **Configurar** el intervalo (ej: 30 segundos)
3. **Hacer clic** en "Iniciar Movimiento"
4. **¡Listo!** El mouse se moverá automáticamente

### ⚙️ Configuración

- **Intervalo**: Tiempo entre movimientos (segundos)
- **Posiciones**: Coordenadas X,Y donde mover el cursor
- **Guardado**: La configuración se guarda automáticamente

## 🛠️ Desarrollo

### Requisitos
- Python 3.8+
- pip

### Instalación de dependencias
```bash
pip install -r requirements.txt
```

### Ejecutar en desarrollo
```bash
python mueve_mouse.py
```

### Construir ejecutables

#### macOS
```bash
python build.py
```

#### Windows
```bash
python build.py
```

#### Linux
```bash
# Usar Docker (desde cualquier sistema)
./build_with_docker.sh

# O construir directamente en Linux
./build_linux.sh
```

## 📦 Estructura del proyecto

```
MueveMouse/
├── mueve_mouse.py          # Código principal
├── requirements.txt         # Dependencias
├── build.py                # Script de construcción
├── build_linux.sh          # Construcción para Linux
├── build_with_docker.sh    # Construcción con Docker
├── Dockerfile              # Configuración Docker
├── create_linux_package.sh # Crear paquete Linux
├── create_windows_package.sh # Crear paquete Windows
├── create_dmg.sh           # Crear DMG macOS
├── .github/workflows/      # CI/CD automático
└── README.md               # Documentación
```

## 🔧 Solución de problemas

### macOS
- **"Aplicación dañada"**: Ver sección de instalación
- **Permisos**: Ir a Preferencias del Sistema → Seguridad

### Windows
- **Error de permisos**: Ejecutar como administrador
- **Antivirus**: Agregar excepción si es necesario

### Linux
- **"Exec format error"**: Usar ejecutable compilado para Linux
- **Dependencias**: Instalar `python3-tk` si falta
- **Permisos**: `chmod +x MueveMouse`

## 🤝 Contribuir

1. Fork el proyecto
2. Crear una rama (`git checkout -b feature/nueva-funcionalidad`)
3. Commit los cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Crear un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver [LICENSE.txt](LICENSE.txt) para más detalles.

## 🔗 Enlaces

- **GitHub**: https://github.com/panasabena/mueve_mouse
- **Issues**: https://github.com/panasabena/mueve_mouse/issues
- **Releases**: https://github.com/panasabena/mueve_mouse/releases

---

**¡Gracias por usar MueveMouse! 🖱️✨**
