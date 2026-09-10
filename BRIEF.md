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

**Proposed:** Soft depth — cream `#FFFCF7`, blush `#E0CCC7`, ink `#333333`. **Locked in §6e.**

---

## 5. Job flows (Demo QA)

**A. Face scan → resultat → anbefalinger**  
Open app → start **ansiktsscan / hudanalyse** (mock) → **resultat** → **anbefalinger**.

**B. Anbefaling → produkt-detalj**  
From recommendations → product detail (seed from caiacosmetics.se).

Favoritter / profil = shallow. Norwegian chrome (Hjem / Hudscan / For deg / Min, etc.).

---

## 6. Features

**§0 served (Swedish verbatim — do not translate):**

> **Man ska kunna scanna ansiktet och få rekommendationer på vilka produkter som passar min hud**

→ **F1** *scanna* · **F2** *rekommendationer* · **F3** *som passar min hud*

**Owner:** Cursor Grok 4.6 + `product/SKILL.md` (no Opus / Claude). Composer 2.5 builds Flutter **web** only. Do not implement Flutter in this PR.

Research 10 Sep 2026: caiacosmetics.se brand chrome + caiacosmetics.no/no/hudpleie catalog (NO shop, KR, fri frakt over 250 kr). CAIA already has *Shoppa efter hudtyp* / shade finder on the site — the pitch is a **deep face scan** that answers hudtype + sonebehov *for her*, then recommends. KICKS Skin Analytics and Vichy Skinconsult AI are the category pattern (selfie → scores → routine); CAIA does not ship this. Prior slugs used makeup heroes (Dewy Drops / Wake Me Up / Glow Blush) and, in `-4`, a live oval camera + Glow-index. **This slug is skincare-first, zone-map, staged photo pick.**

Brainstormed **26**. Strongest **13** below. **Build exactly three.** Signature is the hero among those three. Walkable mock OK. Dead tile = STOP. No push / NFC / Wallet as hero on web. No native-camera hero.

### 6a. Research (13)

| Key | Feature | Demo | Build | Signature | Concept |
|---|---|---|---|---|---|
| hudkart | Hudkart ansiktsscan | 5 | ✓ | ★ | F1. Staged photo pick → analysing overlay → **sonekart** (panne, T-sone, kinn, øyekontur) with scores, hudtype, prioriteter. Deep scan, not quiz-only. |
| anbefalinger | Anbefalinger | 5 | ✓ |  | F2. Products ranked and grouped by the scan’s zones/concerns. Every card opens produkt-detalj. |
| hudpass | Hudpasset | 5 | ✓ |  | F3. Persisted “passar min hud” profile. Detail, favoritter, and profil all read the same pass. |
| sone_rutin | Sone-rutin morgen/kveld | 4 |  |  | Split routine: matt T-sone vs fukt på kinn. Strong, but `-4` already shipped Min rutin — skip. |
| scan_tidslinje | Scan-tidslinje | 4 |  |  | Before/after scores across two staged photos. Nice depth; not needed to serve §0. |
| sammenlign | Sammenlign for min hud | 4 |  |  | Two-up “hvilken passer min T-sone”. Extra surface; dead if not wired. |
| ingrediensvakt | Ingrediensvakt | 3 |  |  | Flag BHA/AHA vs sensitivitet. Educational, not mer-salg. |
| klima_no | Norsk inneklima-tips | 3 |  |  | Cold/dry indoor overlay. Cute NO flavour; not the onske. |
| anmeldelser_hud | Anmeldelser fra samme hud | 3 |  |  | Filter reviews by Hudpass hudtype. Needs fake review corpus. |
| kit_hud | Kit for min hud | 3 |  |  | CAIA kits (Vacay Vibe, Got You Covered) scored against the pass. |
| oyekontur | Øyekontur-fokus | 3 |  |  | Bye Bye Sleepy + Awakening as a side path. Covered inside Hudkart zone. |
| rescan | Rescan-påminnelse | 2 |  |  | In-app “scan på nytt om 14 dager” chip only — **not** push. |
| butik_kbh | Signature store København | 2 |  |  | Købmagergade 32. Off-onske; skip. |

**Cut (brainstorm, do not build):** native camera / AR try-on hero; quiz-only hudtest; push refill alerts; NFC shelf tap; Wallet-pass; Dewy Drops shade-first (`-4`); Min rutin checkbox clone (`-4`); parfyme-quiz; hårpleie-match; gavevelger; advent-waitlist; community/stylist-chat; checkout.

### 6b. Build these three

1. **Hudkart ansiktsscan** (`hudkart`) — **SIGNATURE / F1**
2. **Anbefalinger** (`anbefalinger`) — F2
3. **Hudpasset** (`hudpass`) — F3

### 6c. Signature — Hudkart

Hero among the three. The walkable moment is **not** a live camera viewfinder.

1. **Hudscan** tab: cream canvas, blush frame, two **staged** picks (`c6_scan_nora_dagslys.jpg`, `c6_scan_nora_vindu.jpg`). Copy: *Velg et bilde — vi leser soner, ikke stiller spørsmål.* Optional one-line decline still lands on a seeded resultat (never an empty quiz).
2. Short analysing overlay (progress + sone labels), then **Resultat**.
3. **Resultat** owns one blush-tinted surface: a face **hudkart** with four zones and scores (seed Nora below). CTA *Se anbefalinger* is the only primary button.
4. Tapping a zone filters **For deg** to that concern.

Do **not** use getUserMedia, `camera` plugin, or a 3-second oval hold. That is `-4`. This slug = photo pick + zone map.

### 6d. Walk (Composer)

Splash → logged-in **Hjem** (last Hudpass teaser + *Start hudscan*).  
**Hudscan** → pick staged photo → overlay → **Resultat** (hudkart) → **For deg / anbefalinger** → **produkt-detalj** (Hudpass “Derfor for din hud”) → heart → **Min / favoritter** → **Profil** (same pass).

Tabs (nb/no): **Hjem · Hudscan · For deg · Min**.  
Scout screens: face scan · resultat · anbefalinger · produkt-detalj · favoritter · profil.  
Favoritter + profil = shallow **but walkable** (no dead tiles). Handlekurv omitted.

Every product tile / zone chip / heart / CTA must navigate. If a row is shown, it opens.

### 6e. Art — Soft depth LOCKED

| Token | Value |
|---|---|
| Canvas | cream `#FFFCF7` |
| Blush / accent surface | `#E0CCC7` |
| Ink | `#333333` |
| Hover | `#6F6464` |
| Soft pink (wash only) | `#F4EFEB` |
| Sale (optional, never hero) | `#996466` |

- Soft paper depth: light blush shadow, cream cards, no black luxury chrome, no editorial-white `-4` look.
- **One** accent-owned surface: the Hudkart on Resultat (blush wash + zone chips).
- Bundled fonts only (Artico-like sans, re-bundle as `c6` assets — do not copy other slug font files).
- Wordmark: re-download CAIA mark → `assets/brand/c6_logo.png`. Do not copy `caia_logo.png` / `logo.png` from `-3`/`-4`/`-5`.
- UI chrome **Norwegian** (*du*-tone): Start hudscan, Se anbefalinger, Derfor for din hud, Lagre i favoritter, Min hud, Hjem, Hudscan, For deg, Min. CTAs: *Legg i handlekurv* only if the button is a no-op **and** not shown as a tile grid.
- §0 Swedish string stays **verbatim** if ever quoted. Do not put a Norwegian paraphrase of the onske on screen.
- Never put `info@caiacosmetics.com` or `pal@thirdact.se` in UI copy.

### 6f. Seed notes for Composer

**New slug.** Do not reuse `caiacosmetics` / `-2` / `-3` / `-4` / `-5` code, seed maps, photo files, asset names, or product URLs. New ids, new filenames, new `.no` PDPs.

**Persona (logged-in):** Nora, Oslo. Hudtype **kombinert**. Undertone nøytral-varm. Last scan just now.

| Sone | Score | Lesing | Driver |
|---|---|---|---|
| T-sone | 64 | Glans + synlige porer | BHA serum, Hydra Matte if used |
| Kinn | 58 | Lett tørrhet / stramhet | Hydra Boost, Sleeping Beauty |
| Øyekontur | 61 | Tretthet | Awakening Eye Cream |
| Panne | 80 | Jevn | Glow Up (glød), The Shield (SPF) |

Hudpass tags: `kombinert`, `t-sone-glans`, `kinn-torrhet`, `oyetretthet`. Prioritet: T-sone + kinn-ubalanse.

**Catalog (caiacosmetics.no — do not use `.se` PDP paths from older slugs):**

| id | Name | KR | Hud | Hvorfor for Nora | Source URL | Asset |
|---|---|---|---|---|---|---|
| c6-bha-serum | BHA EXFOLIATE FACE SERUM | 295 | Fet/kombinert | 2 % BHA + 3 % lactic — T-sone 64 | https://caiacosmetics.no/no/hudpleie/handle-etter-produkt/serum/bha-exfoliate-face-serum | `c6_bha_serum.jpg` |
| c6-hydra-boost | HYDRA BOOST DAY CREAM | 275 | Normal (fukt) | Moisture Magnet på tørre kinn 58 | https://caiacosmetics.no/no/hudpleie/handle-etter-produkt/dagkrem/day-cream-normal-skin | `c6_hydra_boost.jpg` |
| c6-the-shield | THE SHIELD SPF 50+ FACE CREAM | 295 | Alle | Lett under sminke; avslutter morgen | https://caiacosmetics.no/no/hudpleie/handle-etter-produkt/dagkrem/the-shield | `c6_the_shield.jpg` |
| c6-awakening | AWAKENING EYE CREAM | 295 | Alle | Koffein + HA, metallapplikator; sone øye 61 | https://caiacosmetics.no/no/hudpleie/handle-etter-produkt/eye-cream/eye-cream- | `c6_awakening_eye.jpg` |
| c6-sleeping-beauty | THE SLEEPING BEAUTY NIGHT CREAM | 325 | Alle | Aloe + HA; barrier overnight for kinn | https://caiacosmetics.no/no/hudpleie/handle-etter-produkt/nattkrem/night-cream- | `c6_sleeping_beauty.jpg` |
| c6-glow-up | GLOW UP SERUM | 295 | Alle | Perler + C-derivat; panne/glød 80 | https://caiacosmetics.no/no/hudpleie/handle-etter-produkt/serum/glow-up-2 | `c6_glow_up.jpg` |
| c6-reset-mask | RESET WEEKEND FACE MASK | 295 | Alle | Kjølende 15-min reset | https://caiacosmetics.no/no/hudpleie/handle-etter-produkt/ansiktsmaske/reset-weekend-face-mask | `c6_reset_weekend.jpg` |
| c6-renew-you | RENEW YOU PEELING PADS | 395 | Alle (mild) | AHA/PHA/LHA, max 3×/uke | https://caiacosmetics.no/no/hudpleie/shop-by-concern/all-skin-types-/renew-you | `c6_renew_you.jpg` |

Optional extra (catalog-confirmed, PDP path may need a hunt on `/no/hudpleie`): HYDRA MATTE FACE CREAM 295 KR (Oily/Combination) as `c6-hydra-matte` if a unique `.no` URL is found — do not invent a 404.

**Anbefalinger grouping (For deg):**

- *For T-sonen:* c6-bha-serum, c6-renew-you
- *For kinnene:* c6-hydra-boost, c6-sleeping-beauty
- *For øyekonturen:* c6-awakening
- *Avslutt / glød:* c6-the-shield, c6-glow-up, c6-reset-mask

Primary three on Resultat strip: BHA, Hydra Boost, Awakening. Detail body = short Norwegian paraphrase of the live PDP (egenskaper + sånn gjør du). Each detail has **Derfor for din hud** citing the zone score.

**Photos:** download product stills from the `.no` PDPs above into `assets/images/c6_*.jpg`. Staged faces: two soft-depth portraits on cream/blush (no stock watermark, no reused `portratt-glow.jpg` / `hero_scan.jpg` / `foundation-drop.jpg`). Do not contact the brand.

**Out of seed:** Dewy Drops, Wake Me Up, Glow Blush, Soft Melt, Soft Blend F27, Serum Concealer, blush sticks — those are other slugs.

**Web constraints:** Flutter web mock. Image pick from bundled assets (or a two-tile chooser). No Firebase / Azure / TestFlight / Codemagic. No login route.

---

## Screens (Scout)

face scan · resultat · anbefalinger · produkt-detalj · favoritter · profil

Splash → logged-in. No login route. No Firebase / Azure / TestFlight.
