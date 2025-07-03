# Script para apagar o suspender la PC con temporizador
# Uso: .\PowerControl.ps1 /bye /time <minutos> (para apagar)
#      .\PowerControl.ps1 /zzz /time <minutos> (para suspender)

param() # Eliminamos los parámetros nombrados aquí para procesarlos manualmente

function Show-Help {
    Write-Host "Uso:"
    Write-Host "  .\PowerControl.ps1 /bye [/time <minutos>] - Apaga la computadora."
    Write-Host "  .\PowerControl.ps1 /zzz [/time <minutos>] - Suspende la computadora."
    Write-Host ""
    Write-Host "Parámetros:"
    Write-Host "  /bye   : Realiza un apagado completo del sistema."
    Write-Host "  /zzz   : Pone el sistema en modo de suspensión (sleep)."
    Write-Host "  /time  : Opcional. Especifica el tiempo en minutos antes de realizar la acción."
    Write-Host "           Si no se especifica, la acción se realizará inmediatamente."
}

# Inicializar variables
$Action = ""
$Time = 0

# Procesar los parámetros manualmente
if ($args.Count -eq 0) {
    Show-Help
    exit
}

for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        "/bye" {
            $Action = "shutdown"
        }
        "/zzz" {
            $Action = "sleep"
        }
        "/time" {
            if (($i + 1) -lt $args.Count) {
                try {
                    $Time = [int]$args[$i+1]
                    $i++ # Mover al siguiente argumento ya que se consumió el valor de tiempo
                }
                catch {
                    Write-Error "El valor de /time debe ser un número entero."
                    Show-Help
                    exit 1
                }
            }
            else {
                Write-Error "Falta el valor para el parámetro /time."
                Show-Help
                exit 1
            }
        }
        default {
            Write-Warning "Parámetro desconocido: $($args[$i])"
            Show-Help
            exit 1
        }
    }
}

# Validar que se haya especificado una acción
if ([string]::IsNullOrWhiteSpace($Action)) {
    Write-Error "Debe especificar una acción: /bye para apagar o /zzz para suspender."
    Show-Help
    exit 1
}

# Convertir minutos a segundos para el comando shutdown
$TimeToSleepSeconds = $Time * 60

# Ejecutar la acción
if ($Time -gt 0) {
    Write-Host "La computadora se $($Action)á en $Time minuto(s)..."
    Start-Sleep -Seconds $TimeToSleepSeconds
}

switch ($Action) {
    "shutdown" {
        Write-Host "Apagando la computadora ahora..."
        Start-Process -FilePath "shutdown.exe" -ArgumentList "/s /t 0" -NoNewWindow -Wait
    }
    "sleep" {
        Write-Host "Poniendo la computadora en modo de suspensión..."
        try {
            Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
namespace PInvoke {
    public class PowerManagement {
        [DllImport("Powrprof.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool SetSuspendState(bool hibernate, bool force, bool disableWakeEvent);
    }
}
"@
            [PInvoke.PowerManagement]::SetSuspendState($false, $false, $false)
        }
        catch {
            Write-Warning "No se pudo usar SetSuspendState. Intentando con rundll32.exe."
            Start-Process -FilePath "rundll32.exe" -ArgumentList "powrprof.dll,SetSuspendState 0,1,0" -NoNewWindow -Wait
        }
    }
    default {
        Write-Error "Acción no reconocida."
        Show-Help
    }
}

Write-Host "Script finalizado."