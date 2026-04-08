# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static website for Relentless Construction, a windows and roofing company serving Utah and Arizona. The site is built with vanilla HTML, CSS, and JavaScript - no build tools or package managers required.

## Project Structure

- `website/` - Main static website
  - `index.html` - Homepage
  - `services.html`, `about.html`, `areas.html`, `contact.html` - Main pages
  - `roofing.html`, `windows.html`, `siding.html`, `gutters.html` - Individual service pages
  - `assets/css/styles.css` - All styles (CSS variables, responsive breakpoints)
  - `assets/js/main.js` - JavaScript (mobile menu, FAQ accordion, form validation, scroll animations)
  - `assets/images/` - All images (prefer .webp format)

- `wp_extracted/` - WordPress backup export (reference only, not actively used)
- `Images/` - Source construction photos

## Development

No build step required. Open HTML files directly in browser or use any local server:
```bash
# Python
python -m http.server 8000 --directory website

# Node
npx serve website
```

## CSS Architecture

CSS uses custom properties defined in `:root` at `styles.css:6-23`:
- `--primary-color: #135941` (green)
- `--font-primary: 'Bricolage Grotesque'` (headings)
- `--font-secondary: 'Host Grotesk'` (body)

Responsive breakpoints: 1024px, 768px, 480px

Internal page styles (services, about, contact) start at line 1169.

## Key Patterns

- Fixed header with mobile menu toggle
- Hero sections use overlay gradients on background images
- FAQ accordion uses `.active` class toggle
- Form validation is client-side only (no backend)
- IntersectionObserver handles scroll animations

## External Dependencies

Loaded via CDN in HTML `<head>`:
- Google Fonts (Bricolage Grotesque, Host Grotesk)
- Font Awesome 6.5.1
