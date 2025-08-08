; Script de instalador para Mueve Mouse
; Requiere NSIS (Nullsoft Scriptable Install System)

!define APP_NAME "Mueve Mouse"
!define APP_VERSION "1.0.0"
!define APP_PUBLISHER "Tu Nombre"
!define APP_EXE "MueveMouse.exe"
!define APP_DESCRIPTION "Aplicación para mantener la pantalla activa moviendo el mouse automáticamente"

; Incluir archivos modernos de NSIS
!include "MUI2.nsh"
!include "FileFunc.nsh"

; Configuración básica
Name "${APP_NAME}"
OutFile "MueveMouse_Setup.exe"
InstallDir "$PROGRAMFILES\${APP_NAME}"
InstallDirRegKey HKCU "Software\${APP_NAME}" ""

; Solicitar permisos de administrador
RequestExecutionLevel admin

; Configuración de la interfaz
!define MUI_ABORTWARNING
!define MUI_ICON "icon.ico"
!define MUI_UNICON "icon.ico"

; Páginas del instalador
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Páginas del desinstalador
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Idiomas
!insertmacro MUI_LANGUAGE "Spanish"

; Sección de instalación
Section "Instalar ${APP_NAME}" SecMain
    SetOutPath "$INSTDIR"
    
    ; Archivos principales
    File "dist\MueveMouse\MueveMouse.exe"
    File "LICENSE.txt"
    File "README.txt"
    
    ; Crear directorio de configuración
    CreateDirectory "$APPDATA\${APP_NAME}"
    
    ; Crear accesos directos
    CreateDirectory "$SMPROGRAMS\${APP_NAME}"
    CreateShortCut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"
    CreateShortCut "$SMPROGRAMS\${APP_NAME}\Desinstalar.lnk" "$INSTDIR\Uninstall.exe"
    CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"
    
    ; Información de desinstalación
    WriteUninstaller "$INSTDIR\Uninstall.exe"
    WriteRegStr HKCU "Software\${APP_NAME}" "" $INSTDIR
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayIcon" "$INSTDIR\${APP_EXE}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "Publisher" "${APP_PUBLISHER}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayVersion" "${APP_VERSION}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "Comments" "${APP_DESCRIPTION}"
    
    ; Calcular tamaño
    ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "EstimatedSize" $0
SectionEnd

; Sección de desinstalación
Section "Uninstall"
    ; Eliminar archivos
    Delete "$INSTDIR\${APP_EXE}"
    Delete "$INSTDIR\LICENSE.txt"
    Delete "$INSTDIR\README.txt"
    Delete "$INSTDIR\Uninstall.exe"
    
    ; Eliminar directorios
    RMDir "$INSTDIR"
    RMDir "$SMPROGRAMS\${APP_NAME}"
    
    ; Eliminar accesos directos
    Delete "$DESKTOP\${APP_NAME}.lnk"
    
    ; Eliminar configuración
    RMDir /r "$APPDATA\${APP_NAME}"
    
    ; Eliminar registro
    DeleteRegKey HKCU "Software\${APP_NAME}"
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
SectionEnd
