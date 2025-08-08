#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Mueve Mouse - Aplicación para mantener la pantalla activa
Mantiene el mouse en movimiento para evitar que la pantalla se bloquee
"""

import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import pyautogui
import threading
import time
import json
import os
import sys
from datetime import datetime
import logging

# Configurar logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class MueveMouseApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Mueve Mouse - Mantén tu pantalla activa")
        self.root.geometry("500x400")
        self.root.resizable(False, False)
        
        # Configurar icono si está disponible
        try:
            self.root.iconbitmap("icon.ico")
        except:
            pass
        
        # Variables de control
        self.is_running = False
        self.thread = None
        self.config_file = "mueve_mouse_config.json"
        
        # Configuración por defecto
        self.config = {
            "intervalo": 5,
            "posicion1_x": 300,
            "posicion1_y": 310,
            "posicion2_x": 320,
            "posicion2_y": 310,
            "modo": "pantalla_actual"
        }
        
        # Cargar configuración
        self.load_config()
        
        # Configurar PyAutoGUI
        pyautogui.FAILSAFE = True
        pyautogui.PAUSE = 0.1
        
        self.setup_ui()
        
    def setup_ui(self):
        """Configurar la interfaz de usuario"""
        # Frame principal
        main_frame = ttk.Frame(self.root, padding="20")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Título
        title_label = ttk.Label(main_frame, text="Mueve Mouse", font=("Arial", 16, "bold"))
        title_label.grid(row=0, column=0, columnspan=2, pady=(0, 20))
        
        subtitle_label = ttk.Label(main_frame, text="Mantén tu pantalla activa automáticamente", font=("Arial", 10))
        subtitle_label.grid(row=1, column=0, columnspan=2, pady=(0, 20))
        
        # Frame de configuración
        config_frame = ttk.LabelFrame(main_frame, text="Configuración", padding="10")
        config_frame.grid(row=2, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=(0, 20))
        
        # Intervalo
        ttk.Label(config_frame, text="Intervalo (segundos):").grid(row=0, column=0, sticky=tk.W, pady=5)
        self.intervalo_var = tk.StringVar(value=str(self.config["intervalo"]))
        intervalo_entry = ttk.Entry(config_frame, textvariable=self.intervalo_var, width=10)
        intervalo_entry.grid(row=0, column=1, padx=(10, 0), pady=5)
        
        # Posiciones
        ttk.Label(config_frame, text="Posición 1 (X, Y):").grid(row=1, column=0, sticky=tk.W, pady=5)
        self.pos1_x_var = tk.StringVar(value=str(self.config["posicion1_x"]))
        self.pos1_y_var = tk.StringVar(value=str(self.config["posicion1_y"]))
        pos1_frame = ttk.Frame(config_frame)
        pos1_frame.grid(row=1, column=1, padx=(10, 0), pady=5)
        ttk.Entry(pos1_frame, textvariable=self.pos1_x_var, width=8).pack(side=tk.LEFT)
        ttk.Label(pos1_frame, text=",").pack(side=tk.LEFT, padx=2)
        ttk.Entry(pos1_frame, textvariable=self.pos1_y_var, width=8).pack(side=tk.LEFT)
        
        ttk.Label(config_frame, text="Posición 2 (X, Y):").grid(row=2, column=0, sticky=tk.W, pady=5)
        self.pos2_x_var = tk.StringVar(value=str(self.config["posicion2_x"]))
        self.pos2_y_var = tk.StringVar(value=str(self.config["posicion2_y"]))
        pos2_frame = ttk.Frame(config_frame)
        pos2_frame.grid(row=2, column=1, padx=(10, 0), pady=5)
        ttk.Entry(pos2_frame, textvariable=self.pos2_x_var, width=8).pack(side=tk.LEFT)
        ttk.Label(pos2_frame, text=",").pack(side=tk.LEFT, padx=2)
        ttk.Entry(pos2_frame, textvariable=self.pos2_y_var, width=8).pack(side=tk.LEFT)
        
        # Botones de utilidad
        util_frame = ttk.Frame(config_frame)
        util_frame.grid(row=3, column=0, columnspan=2, pady=10)
        
        ttk.Button(util_frame, text="Obtener posición actual", command=self.get_current_position).pack(side=tk.LEFT, padx=(0, 10))
        ttk.Button(util_frame, text="Probar movimiento", command=self.test_movement).pack(side=tk.LEFT)
        
        # Frame de control
        control_frame = ttk.LabelFrame(main_frame, text="Control", padding="10")
        control_frame.grid(row=3, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=(0, 20))
        
        # Botón principal
        self.start_button = ttk.Button(control_frame, text="Iniciar", command=self.toggle_movement, style="Accent.TButton")
        self.start_button.grid(row=0, column=0, padx=(0, 10))
        
        # Botón de parada
        self.stop_button = ttk.Button(control_frame, text="Detener", command=self.stop_movement, state="disabled")
        self.stop_button.grid(row=0, column=1)
        
        # Estado
        self.status_var = tk.StringVar(value="Listo para iniciar")
        status_label = ttk.Label(control_frame, textvariable=self.status_var, font=("Arial", 9))
        status_label.grid(row=1, column=0, columnspan=2, pady=(10, 0))
        
        # Frame de información
        info_frame = ttk.LabelFrame(main_frame, text="Información", padding="10")
        info_frame.grid(row=4, column=0, columnspan=2, sticky=(tk.W, tk.E))
        
        info_text = """
• Esta aplicación mueve el mouse automáticamente para mantener la pantalla activa
• Presiona Ctrl+C en la consola o usa el botón "Detener" para parar
• Mueve el mouse a las esquinas de la pantalla para detener de emergencia
• Los cambios en la configuración se guardan automáticamente
        """
        info_label = ttk.Label(info_frame, text=info_text, justify=tk.LEFT, font=("Arial", 9))
        info_label.grid(row=0, column=0, sticky=(tk.W, tk.E))
        
        # Configurar eventos
        self.root.protocol("WM_DELETE_WINDOW", self.on_closing)
        
    def load_config(self):
        """Cargar configuración desde archivo"""
        try:
            if os.path.exists(self.config_file):
                with open(self.config_file, 'r', encoding='utf-8') as f:
                    loaded_config = json.load(f)
                    self.config.update(loaded_config)
                logger.info("Configuración cargada desde archivo")
        except Exception as e:
            logger.warning(f"No se pudo cargar la configuración: {e}")
    
    def save_config(self):
        """Guardar configuración en archivo"""
        try:
            # Actualizar configuración desde la UI
            self.config.update({
                "intervalo": int(self.intervalo_var.get()),
                "posicion1_x": int(self.pos1_x_var.get()),
                "posicion1_y": int(self.pos1_y_var.get()),
                "posicion2_x": int(self.pos2_x_var.get()),
                "posicion2_y": int(self.pos2_y_var.get())
            })
            
            with open(self.config_file, 'w', encoding='utf-8') as f:
                json.dump(self.config, f, indent=2, ensure_ascii=False)
            logger.info("Configuración guardada")
        except Exception as e:
            logger.error(f"Error al guardar configuración: {e}")
    
    def get_current_position(self):
        """Obtener la posición actual del mouse"""
        try:
            x, y = pyautogui.position()
            messagebox.showinfo("Posición actual", f"Posición actual del mouse:\nX: {x}\nY: {y}")
        except Exception as e:
            messagebox.showerror("Error", f"No se pudo obtener la posición: {e}")
    
    def test_movement(self):
        """Probar el movimiento del mouse"""
        try:
            x1, y1 = int(self.pos1_x_var.get()), int(self.pos1_y_var.get())
            x2, y2 = int(self.pos2_x_var.get()), int(self.pos2_y_var.get())
            
            pyautogui.moveTo(x1, y1, duration=0.5)
            time.sleep(0.5)
            pyautogui.moveTo(x2, y2, duration=0.5)
            
            messagebox.showinfo("Prueba", "Movimiento de prueba completado")
        except Exception as e:
            messagebox.showerror("Error", f"Error en el movimiento de prueba: {e}")
    
    def toggle_movement(self):
        """Alternar el movimiento del mouse"""
        if not self.is_running:
            self.start_movement()
        else:
            self.stop_movement()
    
    def start_movement(self):
        """Iniciar el movimiento del mouse"""
        try:
            # Validar configuración
            intervalo = int(self.intervalo_var.get())
            if intervalo < 1:
                raise ValueError("El intervalo debe ser mayor a 0")
            
            # Guardar configuración
            self.save_config()
            
            # Iniciar thread
            self.is_running = True
            self.thread = threading.Thread(target=self.movement_loop, daemon=True)
            self.thread.start()
            
            # Actualizar UI
            self.start_button.config(text="Pausar")
            self.stop_button.config(state="normal")
            self.status_var.set("Movimiento activo")
            
            logger.info("Movimiento iniciado")
            
        except Exception as e:
            messagebox.showerror("Error", f"Error al iniciar el movimiento: {e}")
            logger.error(f"Error al iniciar movimiento: {e}")
    
    def stop_movement(self):
        """Detener el movimiento del mouse"""
        self.is_running = False
        if self.thread:
            self.thread.join(timeout=1)
        
        # Actualizar UI
        self.start_button.config(text="Iniciar")
        self.stop_button.config(state="disabled")
        self.status_var.set("Detenido")
        
        logger.info("Movimiento detenido")
    
    def movement_loop(self):
        """Bucle principal del movimiento"""
        try:
            x1, y1 = int(self.pos1_x_var.get()), int(self.pos1_y_var.get())
            x2, y2 = int(self.pos2_x_var.get()), int(self.pos2_y_var.get())
            intervalo = int(self.intervalo_var.get())
            
            while self.is_running:
                # Mover a posición 1
                pyautogui.moveTo(x1, y1, duration=0.5)
                time.sleep(intervalo)
                
                if not self.is_running:
                    break
                
                # Mover a posición 2
                pyautogui.moveTo(x2, y2, duration=0.5)
                time.sleep(intervalo)
                
        except Exception as e:
            logger.error(f"Error en el bucle de movimiento: {e}")
            self.root.after(0, lambda: messagebox.showerror("Error", f"Error durante el movimiento: {e}"))
            self.root.after(0, self.stop_movement)
    
    def on_closing(self):
        """Manejar el cierre de la aplicación"""
        if self.is_running:
            self.stop_movement()
        self.save_config()
        self.root.destroy()

def main():
    """Función principal"""
    try:
        root = tk.Tk()
        app = MueveMouseApp(root)
        root.mainloop()
    except Exception as e:
        logger.error(f"Error en la aplicación principal: {e}")
        messagebox.showerror("Error", f"Error al iniciar la aplicación: {e}")

if __name__ == "__main__":
    main()