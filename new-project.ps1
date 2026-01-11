# new-project.ps1 - Skapa nya Claude Code-projekt
# Anvandning: .\new-project.ps1 -ProjectName "mitt-projekt"

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [string]$TemplateType = "base"
)

$WorkspaceRoot = "C:\AI\claude-projects"
$ProjectsDir = "$WorkspaceRoot\projects"
$ProjectPath = "$ProjectsDir\$ProjectName"
$TemplateFile = "$WorkspaceRoot\templates\svensk-projekt-mall.md"

Write-Host ""
Write-Host "=== Skapar nytt Claude Code-projekt ===" -ForegroundColor Cyan
Write-Host "Projekt:  $ProjectName" -ForegroundColor White
Write-Host "Sokvag:   $ProjectPath" -ForegroundColor White
Write-Host ""

# Kontrollera om projektet redan finns
if (Test-Path $ProjectPath) {
    $confirm = Read-Host "Projektet finns redan. Skriv over? (y/N)"
    if ($confirm -ne 'y') {
        Write-Host "Avbryter..." -ForegroundColor Yellow
        exit 1
    }
    Remove-Item -Recurse -Force $ProjectPath
}

# Skapa projektstruktur
Write-Host "Skapar projektstruktur..." -ForegroundColor Green
New-Item -ItemType Directory -Force -Path $ProjectPath | Out-Null
Set-Location $ProjectPath

# Skapa mappar
@(".claude\agents", ".claude\commands", ".claude\skills", "src", "tests", "docs") | ForEach-Object {
    New-Item -ItemType Directory -Force -Path $_ | Out-Null
}

# Skapa CLAUDE.md
$CurrentDate = Get-Date -Format "yyyy-MM-dd"

if (Test-Path $TemplateFile) {
    Write-Host "Anvander svensk projektmall..." -ForegroundColor Green
    $content = Get-Content $TemplateFile -Raw -Encoding utf8
    $content = $content -replace '\{\{PROJECT_NAME\}\}', $ProjectName
    $content = $content -replace '\{\{DATE\}\}', $CurrentDate
    $content = $content -replace '\{\{TECH_STACK\}\}', 'Ange stack har'
    $content = $content -replace '\{\{PROJECT_PURPOSE\}\}', 'Beskriv projektets syfte har'
    $content = $content -replace '\{\{TARGET_AUDIENCE\}\}', 'Beskriv malgrupp har'
    $content = $content -replace '\{\{FEATURE_1\}\}', 'Feature 1'
    $content = $content -replace '\{\{FEATURE_2\}\}', 'Feature 2'
    $content = $content -replace '\{\{FEATURE_3\}\}', 'Feature 3'
    $content = $content -replace '\{\{FRONTEND\}\}', 'React'
    $content = $content -replace '\{\{BACKEND\}\}', 'Node.js'
    $content = $content -replace '\{\{DATABASE\}\}', 'PostgreSQL'
    $content = $content -replace '\{\{TEST_FRAMEWORK\}\}', 'Jest'
    $content = $content -replace '\{\{VERSION\}\}', 'latest'
    $content = $content -replace '\{\{TEAM_CONTACT\}\}', 'magnus@levande.se'
    $content = $content -replace '\{\{MONITORING_TOOL\}\}', 'Application Insights'
    $content = $content -replace '\{\{PROJECT_DOMAIN\}\}', $ProjectName
    $content = $content -replace '\{\{AUTHOR\}\}', 'Magnus'
    $content | Out-File "CLAUDE.md" -Encoding utf8
} else {
    Write-Host "Skapar minimal CLAUDE.md..." -ForegroundColor Yellow
    @"
# $ProjectName

> Skapat: $CurrentDate | GitHub: Git4GKnekt

## Projektoversikt
Beskriv projektets syfte har.

## Snabbfakta
- **Stack**: Ange tekniker
- **Test**: ``npm test``
- **Lint**: ``npm run lint``

## Kritiska Regler
- ALDRIG committa till main direkt
- ALLTID kor verifiering fore commit
- FOLJ GDPR vid personuppgiftshantering

## Agent Loop Workflow
1. SAMLA KONTEXT -> 2. PLANERA -> 3. AGERA -> 4. VERIFIERA
"@ | Out-File "CLAUDE.md" -Encoding utf8
}

# Skapa .gitignore
@"
node_modules/
venv/
__pycache__/
.env
.env.local
.vscode/
.idea/
Thumbs.db
dist/
build/
.claude/settings.local.json
"@ | Out-File ".gitignore" -Encoding utf8

# Skapa README.md
@"
# $ProjectName

## Installation
``````bash
git clone https://github.com/Git4GKnekt/$ProjectName.git
cd $ProjectName
npm install
``````

## Utveckling med Claude Code
``````powershell
cd C:\AI\claude-projects\projects\$ProjectName
claude
``````

Se ``CLAUDE.md`` for projektdetaljer.
"@ | Out-File "README.md" -Encoding utf8

# Initialisera Git
git init
git add .
git commit -m "Initial commit: Projekt scaffoldat fran $TemplateType mall"

Write-Host ""
Write-Host "KLART! Projekt '$ProjectName' skapat!" -ForegroundColor Green
Write-Host ""
Write-Host "Nasta steg:" -ForegroundColor Cyan
Write-Host "1. cd $ProjectPath" -ForegroundColor White
Write-Host "2. Redigera CLAUDE.md" -ForegroundColor White
Write-Host "3. Skapa GitHub repo och pusha:" -ForegroundColor White
Write-Host "   git remote add origin https://github.com/Git4GKnekt/$ProjectName.git" -ForegroundColor Yellow
Write-Host "   git branch -M main" -ForegroundColor Yellow
Write-Host "   git push -u origin main" -ForegroundColor Yellow
Write-Host "4. Starta Claude Code: claude" -ForegroundColor White
Write-Host ""
