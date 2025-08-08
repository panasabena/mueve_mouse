#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Setup script para Mueve Mouse
"""

from setuptools import setup, find_packages
import os

# Leer README
def read_readme():
    with open("README.md", "r", encoding="utf-8") as fh:
        return fh.read()

# Leer requirements
def read_requirements():
    with open("requirements.txt", "r", encoding="utf-8") as fh:
        return [line.strip() for line in fh if line.strip() and not line.startswith("#")]

setup(
    name="mueve-mouse",
    version="1.0.0",
    author="Tu Nombre",
    author_email="tu-email@ejemplo.com",
    description="Aplicación para mantener la pantalla activa moviendo el mouse automáticamente",
    long_description=read_readme(),
    long_description_content_type="text/markdown",
    url="https://github.com/tu-usuario/mueve-mouse",
    packages=find_packages(),
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: End Users/Desktop",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Topic :: Desktop Environment",
        "Topic :: Utilities",
    ],
    python_requires=">=3.7",
    install_requires=read_requirements(),
    entry_points={
        "console_scripts": [
            "mueve-mouse=mueve_mouse:main",
        ],
    },
    include_package_data=True,
    zip_safe=False,
    keywords="mouse, screen, automation, utility, desktop",
    project_urls={
        "Bug Reports": "https://github.com/tu-usuario/mueve-mouse/issues",
        "Source": "https://github.com/tu-usuario/mueve-mouse",
        "Documentation": "https://github.com/tu-usuario/mueve-mouse#readme",
    },
)
