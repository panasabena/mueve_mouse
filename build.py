#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script de construcción para Mueve Mouse
Automatiza el proceso de empaquetado para múltiples plataformas
"""

import os
import sys
import subprocess
import platform
import shutil
from pathlib import Path

def run_command(command, description):
    """Ejecutar un comando y mostrar el resultado"""
    print(f"\n{'='*50}")
    print(f"Ejecutando: {description}")
    print(f"Comando: {command}")
    print('='*50)
    
    try:
        result = subprocess.run(command, shell=True, check=True, capture_output=True, text=True)
        print("✅ Comando ejecutado exitosamente")
        if result.stdout:
            print("Salida:", result.stdout)
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Error ejecutando comando: {e}")
        if e.stdout:
            print("Salida:", e.stdout)
        if e.stderr:
            print("Error:", e.stderr)
        return False

def install_dependencies():
    """Instalar dependencias necesarias"""
    print("\n📦 Instalando dependencias...")
    
    # Instalar PyInstaller si no está instalado
    if not run_command("pip install pyinstaller", "Instalando PyInstaller"):
        return False
    
    # Instalar dependencias del proyecto
    if not run_command("pip install -r requirements.txt", "Instalando dependencias del proyecto"):
        return False
    
    return True

def build_executable():
    """Construir el ejecutable"""
    print("\n🔨 Construyendo ejecutable...")
    
    # Limpiar builds anteriores
    if os.path.exists("build"):
        shutil.rmtree("build")
    if os.path.exists("dist"):
        shutil.rmtree("dist")
    
    # Construir con PyInstaller
    if not run_command("pyinstaller mueve_mouse.spec", "Construyendo con PyInstaller"):
        return False
    
    return True

def create_installer():
    """Crear instalador (solo para Windows)"""
    if platform.system() != "Windows":
        print("\n⚠️  Los instaladores solo están disponibles para Windows")
        return True
    
    print("\n📦 Creando instalador...")
    
    # Aquí podrías agregar lógica para crear un instalador con NSIS o similar
    # Por ahora, solo copiamos el ejecutable a una carpeta de distribución
    dist_dir = Path("dist/MueveMouse")
    if dist_dir.exists():
        print(f"✅ Ejecutable creado en: {dist_dir}")
    
    return True

def main():
    """Función principal"""
    print("🚀 Iniciando proceso de construcción de Mueve Mouse")
    print(f"Plataforma: {platform.system()} {platform.release()}")
    
    # Verificar que estamos en el directorio correcto
    if not os.path.exists("mueve_mouse.py"):
        print("❌ Error: No se encontró mueve_mouse.py en el directorio actual")
        return False
    
    # Instalar dependencias
    if not install_dependencies():
        print("❌ Error instalando dependencias")
        return False
    
    # Construir ejecutable
    if not build_executable():
        print("❌ Error construyendo ejecutable")
        return False
    
    # Crear instalador
    if not create_installer():
        print("❌ Error creando instalador")
        return False
    
    print("\n🎉 ¡Construcción completada exitosamente!")
    print("\n📁 Archivos generados:")
    
    dist_path = Path("dist")
    if dist_path.exists():
        for item in dist_path.rglob("*"):
            if item.is_file():
                print(f"  - {item}")
    
    print("\n📋 Próximos pasos:")
    print("  1. Probar el ejecutable generado")
    print("  2. Crear un instalador profesional (opcional)")
    print("  3. Distribuir la aplicación")
    
    return True

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
