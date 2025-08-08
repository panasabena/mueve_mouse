# 🍎 Solución para el error "aplicación dañada" en macOS

## ⚠️ **Problema común:**

Cuando descargas `MueveMouse.dmg` desde internet, macOS puede mostrar este error:
> **"MueveMouse" is damaged and can't be opened. You should move it to the Trash.**

Esto es **normal y esperado** para aplicaciones que no están firmadas por Apple o distribuidas a través de la App Store.

---

## 🔧 **Soluciones (elige una):**

### **Opción 1: Permitir desde Preferencias del Sistema (Recomendado)**

1. **Ve a Preferencias del Sistema** (o Configuración del Sistema en macOS 13+)
2. **Haz clic en "Seguridad y Privacidad"**
3. **Busca el mensaje**: "MueveMouse" fue bloqueado porque no es de un desarrollador identificado
4. **Haz clic en "Permitir de todas formas"**
5. **Confirma** haciendo clic en "Abrir"

### **Opción 2: Usar Terminal**

1. **Abre Terminal** (Aplicaciones → Utilidades → Terminal)
2. **Navega a la carpeta** donde descargaste el DMG:
   ```bash
   cd ~/Downloads
   ```
3. **Ejecuta este comando**:
   ```bash
   sudo xattr -rd com.apple.quarantine MueveMouse.app
   ```
4. **Ingresa tu contraseña** cuando te lo pida
5. **Ahora puedes abrir** la aplicación normalmente

### **Opción 3: Clic derecho para abrir**

1. **Haz clic derecho** en el archivo `MueveMouse.app`
2. **Selecciona "Abrir"** del menú contextual
3. **Confirma** que quieres abrir la aplicación
4. **Selecciona "Abrir"** en el diálogo de confirmación

---

## 📋 **Instrucciones de instalación completas:**

### **Paso 1: Descargar**
1. Descarga `MueveMouse.dmg` desde GitHub
2. Abre el archivo DMG

### **Paso 2: Solucionar el error (si aparece)**
Usa una de las opciones anteriores

### **Paso 3: Instalar**
1. Arrastra `MueveMouse.app` a la carpeta Aplicaciones
2. La aplicación aparecerá en Launchpad automáticamente

### **Paso 4: Ejecutar**
1. Abre Aplicaciones
2. Busca "Mueve Mouse"
3. Haz clic para ejecutar

---

## 🛡️ **¿Por qué pasa esto?**

### **Gatekeeper (Protector de macOS):**
- macOS incluye una función de seguridad llamada **Gatekeeper**
- Bloquea aplicaciones que no están firmadas por Apple
- Es una medida de seguridad para proteger tu Mac

### **Aplicaciones de desarrolladores independientes:**
- Mueve Mouse es una aplicación de código abierto
- No está firmada por Apple (requiere membresía de desarrollador)
- Es completamente segura y verificable

### **¿Es seguro?**
- ✅ **Sí, es completamente seguro**
- ✅ **El código es abierto y verificable**
- ✅ **No contiene malware ni código malicioso**
- ✅ **Puedes revisar el código en GitHub**

---

## 🚀 **Alternativas:**

### **Si prefieres no modificar la configuración de seguridad:**

1. **Usar la versión desde código fuente**:
   ```bash
   git clone https://github.com/panasabena/mueve_mouse.git
   cd mueve_mouse
   pip install -r requirements.txt
   python mueve_mouse.py
   ```

2. **Usar Homebrew** (cuando esté disponible):
   ```bash
   brew install mueve-mouse
   ```

---

## 📞 **¿Necesitas ayuda?**

Si tienes problemas con la instalación:

1. **Revisa las opciones** de solución anteriores
2. **Asegúrate** de que tu macOS esté actualizado
3. **Verifica** que tienes permisos de administrador
4. **Contacta** a través de GitHub Issues

**¡Mueve Mouse es seguro y te ayudará a mantener tu pantalla activa! 🖱️**
