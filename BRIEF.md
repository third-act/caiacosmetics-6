# BRIEF — CAIA Cosmetics (caiacosmetics-6)

Draft for Demo QA port. Research date: **10 September 2026**. English (skills). App UI: **Norwegian (nb/no)** — market NO forced for this test. Brand site remains https://caiacosmetics.se/.

**Build gate:** OPEN — Demo QA **kjør** 10 Sep 2026.

**New project.** Slug `caiacosmetics-6`, repo `third-act/caiacosmetics-6`. Do **not** reuse `caiacosmetics` / `-2` / `-3` / `-5` code, seed, photos, or URLs. QA: https://www.thirdact.no/demo/caiacosmetics-6. Customer: https://www.thirdact.no/caiacosmetics-6 (form/market **NO** → `.no`). Skills pin: `149f83a`. Track: **Demo Web / Cursor-only** (Composer 2.5 + Grok 4.6 if thin). **No Opus / Claude / Other Models.**

Do **not** contact the brand. Never put `info@caiacosmetics.com` in the UI. Form To `pal@thirdact.se` — never in UI.

---

## 0. HARD REQUIREMENT — onske (verbatim)

Confirmed character-for-character with Norway Scout **10 Sep 2026** (91 chars). **Keep Swedish verbatim** even though UI chrome is Norwegian:

> **Man ska kunna scanna ansiktet och få rekommendationer på vilka produkter som passar min hud**

Must ship walkable: **face scan** → **resultat** → **rekommendationer** → **produkt-detalj**, plus **favoritter** and **profil**. Norwegian UI labels. Brand from caiacosmetics.se. Elevate with KIT. Do not paraphrase. Do not drop.

---

## 1. Client

| | |
|---|---|
| Name | Beauty Icons AB (CAIA Cosmetics) |
| Org | 559153-2493 |
| Site | https://caiacosmetics.se/ |
| Audience | KUNDE — shoppers; mer-salg via ansiktsscan → produktanbefaling |
| Slug | caiacosmetics-6 |
| Market | **NO** (UI language no/nb; company is SE) |
| Form To | pal@thirdact.se — never in UI |
| Customer URL | https://www.thirdact.no/caiacosmetics-6 |
| QA | https://www.thirdact.no/demo/caiacosmetics-6 |

**Brand tokens:** blush `#E0CCC7`, cream `#FFFCF7`, ink `#333333`, hover `#6F6464`. Soft depth. Bundled fonts only.

---

## 2. Audience

Logged-in CAIA customer (mock). Primary job: scan face and get product recommendations for their skin. Not staff/admin.

---

## 2c. Art direction

| Soft depth | ☑ proposed |
| Editorial light | ☐ |
| Warm document | ☐ |
| Dark luxury | ☐ |
| High-contrast sport | ☐ |

**Proposed:** Soft depth — cream `#FFFCF7`, blush `#E0CCC7`, ink `#333333`.

---

## 5. Job flows (Demo QA)

**A. Face scan → resultat → anbefalinger**  
Open app → start **ansiktsscan / hudanalyse** (mock) → **resultat** → **anbefalinger**.

**B. Anbefaling → produkt-detalj**  
From recommendations → product detail (seed from caiacosmetics.se).

Favoritter / profil = shallow. Norwegian chrome (Hjem / Hudscan / For deg / Min, etc.).

---

## 6. Features

**§0 served (Swedish verbatim onske):** scan → recommendations for my skin.

**§6 owned by Cursor Grok 4.6** (no Opus) after gate opens — 10–15 research, build three, signature among three. Composer 2.5 builds Flutter web.

---

## Screens (Scout)

face scan · resultat · rekommendationer · produkt-detalj · favoritter · profil

Splash → logged-in. No login route. No Firebase / Azure / TestFlight.
