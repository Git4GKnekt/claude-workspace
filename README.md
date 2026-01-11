# Claude Code Workspace

Min personliga Claude Code-arbetsmiljö.

## Struktur

- `.claude/` - Globala agenter, commands, skills
- `templates/` - Projektmallar
- `projects/` - Aktiva projekt (egna repos)
- `external/` - Externa dependencies

## Skapa nytt projekt
```powershell
.\new-project.ps1 -ProjectName "projekt-namn"
```

## Synka mellan datorer
```powershell
git pull  # Hämta ändringar
git push  # Pusha ändringar
```
