$ErrorActionPreference = "Stop"

# URLs
$mavenUrl = "https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip"

# Directorios
$scriptDir = $PSScriptRoot
# Intentar reusar la carpeta deps del padre si existe
$parentDeps = Join-Path (Split-Path $scriptDir -Parent) "deps"
if (Test-Path $parentDeps) {
    $depsDir = $parentDeps
}
else {
    $depsDir = Join-Path $scriptDir "deps"
}

$mavenDir = Join-Path $depsDir "apache-maven-3.9.6"

# 1. Setup Maven
if (-not (Test-Path $depsDir)) {
    New-Item -ItemType Directory -Force -Path $depsDir | Out-Null
}

if (-not (Test-Path "$mavenDir\bin\mvn.cmd")) {
    Write-Host "Maven no encontrado localmente. Descargando..." -ForegroundColor Cyan
    $mavenZip = Join-Path $depsDir "maven.zip"
    Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip
    
    Write-Host "Extrayendo Maven..." -ForegroundColor Cyan
    Expand-Archive -Path $mavenZip -DestinationPath $depsDir -Force
    Remove-Item $mavenZip
}

# Agregar Maven al PATH
$env:PATH = "$mavenDir\bin;$env:PATH"
Write-Host "Usando Maven en: $mavenDir" -ForegroundColor Gray

# 2. Verificar JAVA_HOME
if (-not $env:JAVA_HOME) {
    Write-Host "JAVA_HOME no definido. Intentando detectar..." -ForegroundColor Yellow
    try {
        $javaExe = (Get-Command java -ErrorAction Stop).Source
        # Should be ...\bin\java.exe. Go up two levels.
        $javaBin = Split-Path $javaExe -Parent
        $javaHome = Split-Path $javaBin -Parent
        $env:JAVA_HOME = $javaHome
        Write-Host "JAVA_HOME configurado a: $env:JAVA_HOME" -ForegroundColor Green
    }
    catch {
        Write-Warning "No se pudo detectar JAVA_HOME. Es posible que la compilación falle."
    }
}

# 3. Ejecutar Spring Boot
Write-Host "Iniciando Aplicación Spring Boot..." -ForegroundColor Cyan
Write-Host "La primera vez descargará todas las dependencias, esto puede tardar unos minutos." -ForegroundColor Yellow

mvn spring-boot:run
Write-Host "Aplicación disponible en: http://localhost:8082" -ForegroundColor Green
