# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## ⛔ CRITICAL: DEPLOYMENT GUARDRAILS ⛔

### AUTHORIZED TARGETS ONLY - NO EXCEPTIONS

| Type | Authorized Value | NEVER use anything else |
|------|------------------|------------------------|
| **GitHub Repo** | `Emerald-Beacon/Relentless-Construction-Website` | ❌ No other repos |
| **Netlify Project** | `relentless-construction-website` | ❌ No other projects |
| **Netlify Site ID** | `5761d556-2e2d-409d-a0e2-dac63d2348a2` | ❌ No other site IDs |
| **Production URL** | `https://relentlessconstruction.io` | ❌ No other URLs |

### MANDATORY VERIFICATION BEFORE EVERY COMMIT/DEPLOY

**STOP. Before running `git push` or `netlify deploy`, you MUST run these checks:**

```bash
# Check 1: Verify GitHub remote
git remote -v
# MUST show: origin https://github.com/Emerald-Beacon/Relentless-Construction-Website.git

# Check 2: Verify Netlify project
netlify status
# MUST show: relentless-construction-website and relentlessconstruction.io
```

**If EITHER check fails, DO NOT PROCEED. Fix with:**
```bash
git remote set-url origin https://github.com/Emerald-Beacon/Relentless-Construction-Website.git
netlify link --name relentless-construction-website
```

### SAFEST DEPLOYMENT METHOD

Use the deploy script which has built-in verification:
```bash
./deploy.sh
```

### PROTECTION LAYERS

1. **Git pre-push hook** (`.git/hooks/pre-push`) - Blocks pushes to wrong repos
2. **Deploy script** (`deploy.sh`) - Verifies all targets before deploying
3. **This CLAUDE.md** - Instructions for Claude Code

### IF NETLIFY LINKS TO WRONG PROJECT

This has happened before. If `netlify status` shows ANY other project:
```bash
netlify unlink
netlify link --name relentless-construction-website
```

## Project Overview

Static website for Relentless Construction, a construction company serving Utah and Arizona (roofing, windows, basement finishing, hardscapes). Built with vanilla HTML, CSS, and JavaScript - no build tools or package managers required.

## Project Structure

- `website/` - Main static website
  - `index.html` - Homepage (centered hero with popup form modal)
  - `services.html`, `about.html`, `portfolio.html` - Main pages
  - `roofing.html`, `windows.html`, `basement.html`, `hardscapes.html`, `siding.html`, `gutters.html` - Service pages
  - `areas.html`, `contact.html` - Supporting pages
  - `assets/css/styles.css` - All styles (~2200 lines)
  - `assets/js/main.js` - JavaScript functionality
  - `assets/images/` - Images (prefer .webp format)

- `wp_extracted/` - WordPress backup export (reference only, not used)
- `Images/` - Source construction photos

## Development

No build step. Open HTML files directly or use a local server:
```bash
python -m http.server 8000 --directory website
# or
npx serve website
```

## CSS Architecture

Custom properties in `:root` (styles.css:7-23):
- `--primary-color: #135941` (brand green)
- `--primary-light: #1a7a55`, `--primary-dark: #0e4532`
- `--dark-bg: #0d0d0d`, `--dark-bg-secondary: #1a1a1a`, `--dark-bg-card: #141414`
- `--font-primary: 'Bricolage Grotesque'` (headings)
- `--font-secondary: 'Host Grotesk'` (body)
- `--border-dark: rgba(255, 255, 255, 0.1)`

Responsive breakpoints (styles.css:1827+): 1024px, 768px, 480px

## Design System

- **Cut corners**: Elements use `clip-path: polygon(...)` for angular corners (NOT border-radius). Standard cut: `clip-path: polygon(0 0, calc(100% - 20px) 0, 100% 20px, 100% 100%, 20px 100%, 0 calc(100% - 20px))`
- **Buttons**: `.btn`, `.btn-primary`, `.btn-secondary`, `.btn-outline` (styles.css:72-130)
- **Cards**: Dark backgrounds (`--dark-bg-secondary`) with `--border-dark` borders and cut corners
- **Section badges**: `.section-badge` for category labels above headings (styles.css:576-587)
- **Service cards**: `.service-card` with icon, title, description (styles.css:621-663)

## Page Templates

**Homepage** (`index.html`):
- Uses `.header-simple` class (hides top bar)
- `.hero-centered` layout with `.hero-content-centered`, `.hero-title-large`, `.hero-badge-centered`
- Form popup modal (`#form-popup`) triggered by `openFormPopup()` function
- Embedded iframe form from links.relentlessconstruction.io

**Internal pages** (services, about, etc.):
- Uses full `.header` with `.top-bar` showing contact info
- `.page-hero` section with `.page-hero-content` (side-by-side text and form grid)

## Key JavaScript (main.js)

- Mobile menu: `.mobile-menu-btn` toggles `.nav.active` (lines 5-23)
- FAQ accordion: `.faq-item.active` expands answers (lines 25-42)
- Form popup: `openFormPopup()`/`closeFormPopup()` functions (lines 168-191)
- Scroll animations: IntersectionObserver on `.service-card`, `.process-step`, `.area-card` (lines 110-157)

## External Dependencies

Loaded via CDN:
- Google Fonts (Bricolage Grotesque, Host Grotesk)
- Font Awesome 6.5.1
- TrustIndex widget (testimonials)
- Form embed from links.relentlessconstruction.io/widget/form/
