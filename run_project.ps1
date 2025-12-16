# PowerShell script to find Java, set JAVA_HOME, and run the project

Write-Host "Searching for Java installations..."

$javaPaths = @(
    "C:\Program Files\Java",
    "C:\Program Files (x86)\Java",
    "$env:LOCALAPPDATA\Programs\Common\Microsoft\OpenJDK",
    "$env:USERPROFILE\.jdks"
)

$foundJdks = @()

foreach ($path in $javaPaths) {
    if (Test-Path $path) {
        $jdks = Get-ChildItem -Path $path -Directory
        foreach ($jdk in $jdks) {
            $binPath = Join-Path $jdk.FullName "bin\java.exe"
            $javacPath = Join-Path $jdk.FullName "bin\javac.exe"
            if (Test-Path $binPath) {
                if (Test-Path $javacPath) {
                    $foundJdks += $jdk.FullName
                }
                else {
                    Write-Warning "Found JRE at $($jdk.FullName) but it is not a JDK (missing javac.exe)."
                }
            }
        }
    }
}

if ($foundJdks.Count -eq 0) {
    Write-Error "No JDK (Java Development Kit) found in common locations. You need a JDK to compile Java code."
    Write-Host "SUGGESTION: Run the following command to install a JDK:" -ForegroundColor Cyan
    Write-Host "    winget install Microsoft.OpenJDK.17" -ForegroundColor Yellow
    exit 1
}

# Sort to pick the latest (naive sort by name, usually works for jdk-11, jdk-17 etc)
$latestJdk = $foundJdks | Sort-Object -Descending | Select-Object -First 1

Write-Host "Found JDK at: $latestJdk"
$env:JAVA_HOME = $latestJdk
$env:Path = "$latestJdk\bin;$env:Path"

Write-Host "JAVA_HOME set to $env:JAVA_HOME"
Write-Host "Verifying java version..."
java -version

Write-Host "Building project with Maven..."
mvn clean install

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build success! Running application..."
    $jarFile = "target/bugtracker-1.0-SNAPSHOT.jar"
    if (Test-Path $jarFile) {
        java -jar $jarFile
    }
    else {
        Write-Error "JAR file not found at $jarFile"
    }
}
else {
    Write-Warning "Maven build failed. Attempting manual compilation..."
    
    $outDir = "target/classes"
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    
    $sources = Get-ChildItem -Path src/main/java -Recurse -Filter *.java
    $javacExe = Join-Path $env:JAVA_HOME "bin\javac.exe"
    $jarExe = Join-Path $env:JAVA_HOME "bin\jar.exe"
    
    Write-Host "Compiling sources..."
    & $javacExe -d $outDir ($sources.FullName)
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Compilation success. Packaging JAR..."
        $manualJar = "target/bugtracker-manual.jar"
        & $jarExe cvfe $manualJar com.bugtracker.App -C $outDir .
        
        Write-Host "Running manually built application..."
        & "$env:JAVA_HOME\bin\java.exe" -jar $manualJar
    }
    else {
        Write-Error "Manual compilation also failed."
        exit 1
    }
}
