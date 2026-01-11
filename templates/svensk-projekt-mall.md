# {{PROJECT_NAME}}

> Claude Code projekt | Skapat: {{DATE}} | Stack: {{TECH_STACK}}

## VIKTIGT: Referensdokumentation

Läs alltid dessa källor innan större ändringar:
- Claude Code Best Practices: https://www.anthropic.com/engineering/claude-code-best-practices
- Building Effective Agents: https://www.anthropic.com/engineering/building-effective-agents
- Agent Skills Guide: https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills

## 🚨 KRITISKA REGLER

- **ALDRIG committa till main** - Skapa feature branch först
- **ALLTID verifiera** med test/lint innan commit
- **FÖLJ GDPR** - Extra viktigt för svenska projekt med personuppgifter
- **SVENSKA i kommentarer/docs** för business logic, **ENGELSKA i kod**

## 🎯 VAD/VARFÖR/HUR Framework

### VAD (Projektstruktur)
```
{{PROJECT_NAME}}/
├── src/              # Källkod
├── tests/            # Tester
├── docs/             # Dokumentation
├── .claude/          # Claude Code-konfiguration
│   ├── agents/       # Specialiserade subagenter
│   ├── commands/     # Slash-kommandon
│   └── skills/       # Domän-specifika färdigheter
└── CLAUDE.md         # Detta dokument
```

### VARFÖR (Projektets syfte)
{{PROJECT_PURPOSE}}

**Kärnfunktionalitet:**
- {{FEATURE_1}}
- {{FEATURE_2}}
- {{FEATURE_3}}

**Målgrupp:** {{TARGET_AUDIENCE}}

### HUR (Kommandon & Verifiering)

#### Utveckling
```bash
npm run dev          # Starta dev server
npm run build        # Bygg för produktion
npm test             # Kör alla tester
npm run lint         # Kontrollera kod-kvalitet
npm run typecheck    # TypeScript verifiering
```

#### Verifiering (kör ALLTID före commit)
```bash
# Komplett verifiering
npm run verify       # Kör typecheck + lint + test

# Individuellt
npm run typecheck    # ✅ Måste passera
npm run lint         # ✅ Måste passera  
npm test             # ✅ Måste passera
```

## 📋 Teknisk Stack

| Komponent | Teknologi | Version |
|-----------|-----------|---------|
| Frontend | {{FRONTEND}} | {{VERSION}} |
| Backend | {{BACKEND}} | {{VERSION}} |
| Databas | {{DATABASE}} | {{VERSION}} |
| Testing | {{TEST_FRAMEWORK}} | {{VERSION}} |

## 🗂️ Filgränser (viktigt!)

### ✅ Säkert att redigera
- `/src/**` - All källkod
- `/tests/**` - Alla tester
- `/docs/**` - Dokumentation
- `/.claude/**` - Claude Code-konfiguration

### 👀 Läs-endast (begär tillåtelse först)
- `/config/**` - Konfigurationsfiler
- `/scripts/**` - Build-scripts
- `package.json` - Beroenden
- `tsconfig.json` - TypeScript-config

### 🚫 Rör ALDRIG
- `/node_modules/**`
- `/.git/**`
- `/.env` - (läs för värden, ändra aldrig direkt)

## 🔄 Agent Loop Workflow

Följ alltid detta mönster för kvalitetsarbete:

```
1. SAMLA KONTEXT → 2. PLANERA → 3. AGERA → 4. VERIFIERA → 5. UPPREPA
```

### 1. Samla Kontext
- Läs relevanta filer med Read/Grep
- Förstå scope och påverkan
- Identifiera beroenden

### 2. Planera (använd "think hard")
```
Before coding: "Think hard about implementing [feature], create a detailed plan"
```

### 3. Agera
- Implementera i små, verifierbara steg
- Ett feature åt gången
- Commit ofta

### 4. Verifiera
```bash
npm run verify  # MÅSTE köras efter varje ändring
```

### 5. Commit
```bash
git add .
git commit -m "feat: beskrivning av ändring"
```

## 🤖 Subagenter

### Inbyggda (använd fritt)
- **Explore**: Snabb read-only sökning (Haiku)
- **Plan**: Research för planering
- **General-purpose**: Komplexa multi-steg uppgifter

### Projekt-specifika (i `.claude/agents/`)

#### Code Reviewer (`code-reviewer.md`)
- **När**: Före PR, efter större ändringar
- **Använd**: Automatiskt vid `/review`
- **Verifierar**: Kod-kvalitet, säkerhet, GDPR

#### Test Runner (`test-runner.md`)
- **När**: Efter kod-ändringar
- **Använd**: `/test`
- **Kör**: Test suite + coverage report

#### GDPR Specialist (`gdpr-reviewer.md`)
- **När**: Vid personuppgiftshantering
- **Använd**: Proaktivt vid User/Auth-ändringar
- **Kontrollerar**: Samtycke, dataminimering, rättigheter

## 🎨 Kodstandarder

### TypeScript/JavaScript
```typescript
// ✅ BRA: Tydliga typer, beskrivande namn
interface UserProfile {
  id: string;
  email: string;
  createdAt: Date;
}

async function fetchUserProfile(userId: string): Promise<UserProfile> {
  // Implementation
}

// ❌ DÅLIGT: any, oklara namn
async function getUser(id: any): Promise<any> {
  // Implementation
}
```

### Python
```python
# ✅ BRA: Type hints, docstrings
def calculate_discount(
    price: Decimal, 
    discount_rate: float
) -> Decimal:
    """
    Beräkna rabatterat pris.
    
    Args:
        price: Ursprungligt pris
        discount_rate: Rabatt i procent (0-100)
        
    Returns:
        Rabatterat pris
    """
    return price * (1 - discount_rate / 100)

# ❌ DÅLIGT: Inga type hints, ingen dokumentation
def calc(p, d):
    return p * (1 - d / 100)
```

### Namnkonventioner
- **Komponenter**: PascalCase (`UserProfile`)
- **Funktioner**: camelCase (`getUserData`)
- **Konstanter**: UPPER_SNAKE_CASE (`API_BASE_URL`)
- **Filer**: kebab-case (`user-profile.tsx`)
- **Databas**: snake_case (`user_profiles`, `created_at`)

## 🧪 Test-strategi

### Test-struktur (AAA Pattern)
```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create user with valid data', async () => {
      // ARRANGE (Förbered)
      const userData = { email: 'test@example.com', name: 'Test' };
      const mockDb = createMockDb();
      
      // ACT (Utför)
      const user = await userService.createUser(userData, mockDb);
      
      // ASSERT (Verifiera)
      expect(user).toBeDefined();
      expect(user.email).toBe(userData.email);
      expect(mockDb.insert).toHaveBeenCalledOnce();
    });
  });
});
```

### Coverage-mål
- **Unit tests**: 80%+ för all business logic
- **Integration tests**: Alla API-endpoints
- **E2E tests**: Kritiska användarflöden

## 🔐 Säkerhet & GDPR (Sverige)

### Säkerhets-checklista
- [ ] Input validation på alla endpoints
- [ ] SQL injection-skydd (parameteriserade queries)
- [ ] XSS-skydd (sanitera output)
- [ ] CSRF-tokens på forms
- [ ] Rate limiting på API
- [ ] Secrets i environment variables

### GDPR-checklista
- [ ] **Dataminimering**: Samla bara nödvändig data
- [ ] **Lagringstid**: Dokumenterad i `docs/gdpr.md`
- [ ] **Samtycke**: Explicit opt-in för cookies/marketing
- [ ] **Rättigheter**: Export/radera implementerat
- [ ] **Behandlingsregister**: Uppdaterat i `docs/gdpr-register.md`
- [ ] **PuB-avtal**: Med alla leverantörer som behandlar data

### Känsliga personuppgifter
Dessa kräver extra skydd och loggning:
- Personnummer (använd aldrig som primärnyckel!)
- E-postadresser
- Telefonnummer
- IP-adresser
- Hälsodata
- Finansiell information

## 📦 Slash-kommandon

```bash
/review              # Kör code review med subagent
/test                # Kör test suite + coverage
/verify              # Full verifiering (lint+test+typecheck)
/gdpr-check          # Kontrollera GDPR-compliance
/fix-issue <number>  # Fixa GitHub issue
/deploy:staging      # Deploya till staging
```

## 🔍 Extended Thinking Guide

Använd dessa fraser för komplex planering:

| Kommando | Användning | Exempel |
|----------|------------|---------|
| "think" | Enkel planering | "Think about how to add this field" |
| "think hard" | Feature implementation | "Think hard about auth implementation" |
| "think harder" | Arkitektur | "Think harder about scaling strategy" |
| "ultrathink" | Säkerhet/kritiskt | "Ultrathink about payment processing" |

## 🔄 Git Workflow

### Branch-strategi
```
main                 # Produktion (skyddad)
├── develop          # Development
├── feature/...      # Nya features
├── bugfix/...       # Buggfixar
└── hotfix/...       # Akuta fixes
```

### Commit-meddelanden (Conventional Commits)
```bash
feat: Lägg till user authentication
fix: Rätta SQL injection i search
docs: Uppdatera API-dokumentation
test: Lägg till tests för UserService
refactor: Förbättra database query performance
chore: Uppdatera dependencies
```

### Före varje commit
```bash
# 1. Verifiera
npm run verify

# 2. Commit
git add .
git commit -m "feat: beskrivning"

# 3. Push
git push origin feature/branch-name
```

## 🚀 Deployment

### Miljöer
- **Development**: Lokal (`localhost:3000`)
- **Staging**: `https://staging.{{PROJECT_NAME}}.se`
- **Production**: `https://{{PROJECT_NAME}}.se`

### Deploy-process
```bash
# Automatisk CI/CD vid push till:
main → Production (efter godkännande)
develop → Staging (automatiskt)
```

## 📚 Dokumentation

### Var hittar jag...?
- **API-docs**: `docs/api.md` (OpenAPI spec)
- **Arkitektur**: `docs/architecture.md`
- **GDPR**: `docs/gdpr.md` + `docs/gdpr-register.md`
- **Deployment**: `docs/deployment.md`
- **Onboarding**: `docs/onboarding.md`

### Dokumentationskrav
```typescript
/**
 * Skapar en ny användare i systemet.
 * 
 * @param userData - Användardata för att skapa profil
 * @returns Promise med skapad användare
 * @throws {ValidationError} Om email är ogiltig
 * @throws {DuplicateError} Om email redan finns
 * 
 * @example
 * const user = await createUser({
 *   email: 'test@example.com',
 *   name: 'Test User'
 * });
 */
export async function createUser(userData: UserData): Promise<User> {
  // Implementation
}
```

## 🆘 Vanliga Problem

### Problem: Tests failar lokalt men inte i CI
```bash
# Rensa cache
npm run test:clear-cache
rm -rf node_modules/.cache

# Installera om
npm ci
npm test
```

### Problem: TypeScript-fel efter pull
```bash
# Uppdatera typer
npm install
npm run typecheck

# Om fel kvarstår, kontrollera tsconfig.json
```

### Problem: GDPR-varning i review
```bash
# Kör GDPR-check
/gdpr-check

# Läs rekommendationer
cat .claude/reports/gdpr-review.md
```

## 💡 Tips för Claude Code

1. **Använd `/init`** på nya projekt för auto-genererad CLAUDE.md
2. **Använd `#`-tangenten** för att lägga till anteckningar
3. **Håll CLAUDE.md <200 rader** för optimal prestanda
4. **Använd subagenter** för att bevara main context
5. **Clear context** med `/clear` mellan orelaterade tasks
6. **Delegera komplext** till subagenter med `/agents`

## 🎯 Projekt-specifika Skills

Se `.claude/skills/` för:
- `swedish-gdpr/` - GDPR-compliance för Sverige
- `{{PROJECT_DOMAIN}}/` - Domän-specifik logik

## 📊 Metrics & Monitoring

### Vad mäter vi?
- Response times (< 200ms mål)
- Error rate (< 1% mål)
- Test coverage (> 80% mål)
- GDPR-compliance score

### Var ser jag metrics?
- **Development**: Console logs
- **Staging/Production**: {{MONITORING_TOOL}}

---

**Version**: 1.0.0
**Senast uppdaterad**: {{DATE}}
**Kontakt**: {{TEAM_CONTACT}}
