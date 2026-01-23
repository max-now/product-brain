# HeyMax Altitude Design System
**Version:** 1.0.0
**Last Updated:** January 15, 2026
**Source:** Figma Design System - HeyMax Altitude
**Figma File ID:** dbfFXfoinjUfJaPOnOi7Dc
---
## Table of Contents
1. [Color Palette](https://claude.ai/chat/107e0949-4dd5-4b32-86d6-35edadc75905#color-palette)
2. [Typography](https://claude.ai/chat/107e0949-4dd5-4b32-86d6-35edadc75905#typography)
3. [Spacing System](https://claude.ai/chat/107e0949-4dd5-4b32-86d6-35edadc75905#spacing-system)
4. [Border Radius](https://claude.ai/chat/107e0949-4dd5-4b32-86d6-35edadc75905#border-radius)
5. [Shadows](https://claude.ai/chat/107e0949-4dd5-4b32-86d6-35edadc75905#shadows)
6. [Components](https://claude.ai/chat/107e0949-4dd5-4b32-86d6-35edadc75905#components)
---
## Color Palette
### Neutral Colors
The neutral color palette is used for text, backgrounds, and UI elements throughout the application.
| Name | Value | Usage |
| --- | --- | --- |
| Neutral 000 | `#FFFFFF` | White, pure backgrounds |
| Neutral 005 | `#F4F4F4` | Lightest gray, subtle backgrounds |
| Neutral 010 | `#E8E8E8` | Very light gray, borders |
| Neutral 020 | `#D1D1D1` | Light gray, disabled states |
| Neutral 040 | `#A3A3A3` | Medium-light gray, disabled text |
| Neutral 060 | `#767676` | Medium gray, secondary text, subheadings on light backgrounds |
| Neutral 080 | `#484848` | Dark gray, text on dark backgrounds |
| Neutral 090 | `#313131` | Very dark gray, text on dark backgrounds |
| Neutral 100 | `#1A1A1A` | Near black, primary heading text |
### Brand / Primary Colors
The primary brand colors for the HeyMax Altitude design system.
| Name | Value | Usage |
| --- | --- | --- |
| Brand 005 | `#F6F6FC` | Lightest brand tint |
| Brand 010 | `#EDECF9` | Very light brand background |
| Brand 020 | `#DCDAF3` | Light brand background |
| Brand 040 | `#B9B5E8` | Medium-light brand |
| Brand 060 | `#9690DC` | Medium brand |
| Brand 080 | `#736BD1` | Medium-dark brand |
| Brand 090 | `#6259CB` | Dark brand |
| Brand 100 | `#5046C5` | Primary brand color, main interactive elements |
| Brand 140 | `#3C3682` | Darkest brand shade |
| Brand 150 | `#373272` | Extra dark brand (from gradient) |
### Dark Purple / Secondary Colors
Secondary color palette for accents and variety.
| Name | Value | Usage |
| --- | --- | --- |
| Dark Purple 005 | `#F3F3F5` | Lightest tint |
| Dark Purple 010 | `#E7E6EB` | Very light background |
| Dark Purple 020 | `#D0CDD7` | Light background |
| Dark Purple 040 | `#A19CB0` | Medium-light |
| Dark Purple 060 | `#716A88` | Medium |
| Dark Purple 080 | `#423961` | Medium-dark |
| Dark Purple 090 | `#2B204D` | Dark |
| Dark Purple 100 | `#130739` | Darkest shade, used in gradients |
### Light Purple / Tertiary Colors
Tertiary accent colors.
| Name | Value | Usage |
| --- | --- | --- |
| Light Purple 005 | `#F9F5FF` | Lightest tint |
| Light Purple 010 | `#F2EAFF` | Very light background |
| Light Purple 020 | `#E6D5FF` | Light background |
| Light Purple 040 | `#CCABFF` | Medium-light |
| Light Purple 060 | `#B382FF` | Medium |
| Light Purple 080 | `#9958FF` | Medium-dark, used in gradients |
| Light Purple 090 | `#8D43FF` | Dark |
| Light Purple 100 | `#802EFF` | Primary tertiary color |
| Light Purple 140 | `#5928A5` | Darkest shade |
| Light Purple 150 | `#4F268F` | Extra dark (from Figma) |
### Pink Colors
Accent color for special highlights.
| Name | Value | Usage |
| --- | --- | --- |
| Pink 005 | `#FDF2FF` | Lightest tint |
| Pink 100 | `#D400FF` | Primary pink accent |
### Red / Error Colors
Semantic colors for errors and destructive actions.
| Name | Value | Usage |
| --- | --- | --- |
| Red 005 | `#FDF6F5` | Lightest error tint |
| Red 010 | `#FBEDEC` | Very light error background |
| Red 020 | `#F8DBD9` | Light error background |
| Red 040 | `#F1B7B3` | Medium-light error |
| Red 060 | `#E9948C` | Medium error |
| Red 080 | `#E27066` | Medium-dark error |
| Red 090 | `#DF5E53` | Dark error |
| Red 100 | `#DB4C40` | Primary error color |
| Red 140 | `#8F3A32` | Darkest error |
| Red 150 | `#7D352F` | Extra dark error |
### Green / Success Colors
Semantic colors for success states and positive actions.
| Name | Value | Usage |
| --- | --- | --- |
| Green 005 | `#F2FAF7` | Lightest success tint |
| Green 010 | `#E6F6EF` | Very light success background |
| Green 020 | `#CCECDF` | Light success background |
| Green 040 | `#99DABE` | Medium-light success |
| Green 060 | `#66C79E` | Medium success |
| Green 080 | `#33B47E` | Medium-dark success |
| Green 090 | `#1AAB6E` | Dark success |
| Green 100 | `#00A15E` | Primary success color |
| Green 140 | `#0C6D44` | Darkest success |
| Green 150 | `#0F603E` | Extra dark success |
### Yellow / Warning Colors
Semantic colors for warnings and caution states.

**⚠️ Accessibility Note:** Yellow 100 has insufficient contrast (2.4:1) on white backgrounds. **Always use Yellow 140 or darker for text.**

| Name | Value | Contrast on White | Usage |
| --- | --- | --- | --- |
| Yellow 005 | `#FEFAF2` | N/A | Lightest warning tint, backgrounds only |
| Yellow 010 | `#FEF5E5` | N/A | Very light warning background |
| Yellow 020 | `#FDEBCC` | N/A | Light warning background |
| Yellow 040 | `#FBD799` | N/A | Medium-light warning, backgrounds only |
| Yellow 060 | `#F9C366` | 1.9:1 ❌ | Medium warning, backgrounds only |
| Yellow 080 | `#F7AF33` | 2.2:1 ❌ | Medium-dark warning, backgrounds only |
| Yellow 090 | `#F6A51A` | 2.3:1 ❌ | Dark warning, backgrounds only |
| Yellow 100 | `#F59B00` | 2.4:1 ❌ | **Do not use for text** - icons/graphics only |
| Yellow 140 | `#9F690C` | 4.6:1 ✅ | **Darkest warning - USE FOR TEXT** |
| Yellow 150 | `#895D0F` | 5.5:1 ✅ | Extra dark warning text |
### Blue / Information Colors
Semantic colors for informational states.
| Name | Value | Usage |
| --- | --- | --- |
| Blue 005 | `#F4F7FC` | Lightest info tint |
| Blue 010 | `#E9EFFA` | Very light info background, used in gradients |
| Blue 020 | `#D3E0F5` | Light info background |
| Blue 040 | `#A7C0EB` | Medium-light info |
| Blue 060 | `#7AA1E1` | Medium info |
| Blue 080 | `#4E81D7` | Medium-dark info |
| Blue 090 | `#3872D2` | Dark info, primary information text |
| Blue 100 | `#2262CD` | Primary info color |
| Blue 140 | `#204787` | Darkest info |
### Gradients
Predefined gradient combinations for special UI elements.
| Name | Gradient | Usage |
| --- | --- | --- |
| Gradient 100 | `LP080 → BR100` (108°)<br/>`#9958FF```` → ````#5046C5` | Light purple to brand, primary gradient |
| Gradient 200 | `B010 → LP010` (108°)<br/>`#E9EFFA`` → ````#F2EAFF` | Blue to light purple, subtle backgrounds |
| Gradient 300 | `DP100 → #3E0049` (198°)<br/>`#130739 → ````#3E0049` | Dark purple gradient, depth and drama |
| Gradient 400 | `LP100 → PN100` (108°)<br/>`#802EFF`` → ``#D400FF` | Light purple to pink, accent gradient |
### Text Colors (Design Reference)
These are semantic text color applications on different backgrounds.
**On Light Backgrounds:**
- **Heading:** Neutral 100 (`#1A1A1A`) - 16.1:1 ✅
- **Subheading:** Neutral 060 (`#767676`) - 4.5:1 ✅ (minimum for AA)
- **Brand Text:** Brand 100 (`#5046C5`) - 6.4:1 ✅
- **Tertiary Text:** Light Purple 140 (`#5928A5`) - 5.2:1 ✅ (use instead of Light Purple 100)
- **Disabled Text:** Neutral 040 (`#A3A3A3`) - 2.9:1 ⚠️ Use with icon/visual indicator
- **Error Text:** Red 140 (`#8F3A32`) - 6.2:1 ✅ (use Red 100 only for ≥18px text)
- **Success Text:** Green 140 (`#0C6D44`) - 5.1:1 ✅ (use Green 100 only for ≥18px text)
- **Warning Text:** Yellow 140 (`#9F690C`) - 4.6:1 ✅ (NOT Yellow 100)
- **Information Text:** Blue 090 (`#3872D2`) - 4.7:1 ✅
**On Dark Backgrounds (Dark Purple 100):**
- **Heading:** Neutral 000 (White, `#FFFFFF`)
- **Subheading:** Neutral 020 (`#D1D1D1`)
---
## Typography
### Font Family
**Primary Font:** Inter
All text uses the Inter font family with varying weights and sizes.
### Headings
| Style | Font Size | Font Weight | Line Height | Letter Spacing | Usage |
| --- | --- | --- | --- | --- | --- |
| **H1 - Bold** | 32px | 700 (Bold) | 40px | 0 | Main page titles |
| **H2 - Bold** | 24px | 700 (Bold) | 32px | 0 | Section titles |
| **H3 - Bold** | 20px | 700 (Bold) | 24px | 0 | Subsection titles |
| **H4 - Bold** | 16px | 700 (Bold) | 24px | 0 | Card titles, smaller headings |
| **H5 - Bold** | 14px | 700 (Bold) | 24px | 0 | Smallest heading |
### Subheadings
| Style | Font Size | Font Weight | Line Height | Letter Spacing | Usage |
| --- | --- | --- | --- | --- | --- |
| **S1 - Semibold** | 18px | 600 (Semibold) | 24px | 0 | Large subheadings |
| **S2 - Semibold** | 16px | 600 (Semibold) | 24px | 0 | Medium subheadings |
| **S3 - Semibold** | 14px | 600 (Semibold) | 20px | 0 | Small subheadings |
| **S4 - Semibold** | 12px | 600 (Semibold) | 16px | 0 | Smallest subheadings |
### Body Text
| Style | Font Size | Font Weight | Line Height | Letter Spacing | Usage |
| --- | --- | --- | --- | --- | --- |
| **B1 - Regular** | 16px | 400 (Regular) | 24px | 0 | Large body text, primary content |
| **B2 - Medium** | 16px | 500 (Medium) | 24px | 0 | Emphasized large body text |
| **B3 - Regular** | 14px | 400 (Regular) | 20px | 0 | Standard body text |
| **B4 - Medium** | 14px | 500 (Medium) | 20px | 0 | Emphasized standard body text |
| **B5 - Regular** | 12px | 400 (Regular) | 16px | 0 | Small body text, captions |
| **B6 - Medium** | 12px | 500 (Medium) | 16px | 0 | Emphasized small body text |
### Labels
| Style | Font Size | Font Weight | Line Height | Letter Spacing | Usage |
| --- | --- | --- | --- | --- | --- |
| **L1 - Medium** | 12px | 500 (Medium) | 16px | 0 | Form labels, uppercase labels |
| **L2 - Medium** | 10px | 500 (Medium) | 14px | 0 | Very small labels |
### Button Text (Design Reference)
| Size | Font Size | Font Weight | Line Height | Letter Spacing |
| --- | --- | --- | --- | --- |
| **Large** | 16px | 600 (Semibold) | 24px | 0 |
| **Medium** | 14px | 600 (Semibold) | 16px | 0 |
| **Small** | 12px | 600 (Semibold) | 16px | 0 |
---
## Spacing System
The spacing system uses a consistent scale for margins, padding, and gaps throughout the application.
| Name | Value | Usage |
| --- | --- | --- |
| **Small** | 2px | Minimal spacing, tight elements |
| **Medium** | 4px | Small gaps between related items |
| **Large** | 8px | Standard spacing, common gaps |
| **XLarge** | 12px | Medium spacing, section padding |
| **2XLarge** | 16px | Large spacing, major sections |
| **3XLarge** | 20px | Extra large spacing |
| **4XLarge** | 24px | Maximum spacing, page sections |
---
## Border Radius
Consistent border radius values for creating rounded corners on UI elements.
| Name | Value | Usage |
| --- | --- | --- |
| **Small** | 2px | Subtle rounding |
| **Medium** | 4px | Small buttons, inputs |
| **Large** | 8px | Standard cards, buttons |
| **XLarge** | 12px | Regular cards (typical card radius) |
| **2XLarge** | 16px | Large cards, containers |
| **3XLarge** | 20px | Bottom sheets, modals |
| **4XLarge** | 24px | Very large containers |
| **Full** | 999px | Fully rounded (pills, circular elements) |
**Design Notes:**
- Use **Large (8px)** for small card radius
- Use **XLarge (12px)** for regular card radius
- Use **3XLarge (20px)** for bottom sheets and modals
---
## Shadows
Shadow effects to create depth and hierarchy in the UI.
| Name | Effect | Usage |
| --- | --- | --- |
| **Shadow 100** | `box-shadow: 0px 0px 5px 0px rgba(0, 0, 0, 0.1)` | Standard cards |
| **Shadow 100 Up** | `box-shadow: 0px -1px 5px 0px rgba(28, 28, 28, 0.1)` | Bottom navigation bars |
| **Shadow 100 Down** | `box-shadow: 0px 1px 5px 0px rgba(28, 28, 28, 0.1)` | Top navigation bars |
| **Shadow 200** | `box-shadow: 0px 3px 15px 0px rgba(28, 28, 28, 0.08)` | Tooltips, elevated elements |
**Important Note:** Only use drop shadows when there is no overlay. Use overlays for bottom sheets, side drawers, and modals instead of shadows.
---
## Components
### Buttons
Buttons come in multiple variants and sizes. They use semibold typography and consistent padding.
**Variants:**
- **Primary:** Brand background, white text (Brand 100 / Neutral 000)
- **Secondary:** Outlined with border, brand text
- **Danger:** Red background for destructive actions
**Sizes:**
- **Large:** 16px font, 24px line height, larger padding
- **Medium:** 14px font, 16px line height, standard padding
- **Small:** 12px font, 16px line height, compact padding
**States:**
- **Default:** Standard appearance
- **Hover:** Slightly darker/lighter background
- **Active:** More pronounced color change
- **Disabled:** Reduced opacity, no interaction
**Border Radius:** Large (8px) or XLarge (12px) depending on button size
### Cards
Cards are containers for grouped content.
**Background:** Neutral 000 (White, `#FFFFFF`) **Border:** Optional, use Neutral 010 or 020 for subtle borders **Border Radius:**
- Small cards: Large (8px)
- Regular cards: XLarge (12px) **Shadow:** Shadow 100 (`0px 0px 5px 0px rgba(0, 0, 0, 0.1)`) **Padding:** Typically 12px (XLarge) to 16px (2XLarge) depending on card size
### Form Elements
Form inputs, textareas, selects, checkboxes, and radio buttons follow consistent styling.
**Input Fields:**
- **Border:** Neutral 020 (`#D1D1D1`)
- **Border Radius:** Medium (4px) or Large (8px)
- **Focus State:** Brand 100 border color
- **Error State:** Red 100 border color
- **Padding:** 12px (XLarge) internal padding
- **Font:** B3 - Regular (14px, Regular, 20px line height)
**Labels:**
- Use L1 - Medium (12px, Medium, 16px line height)
- Color: Neutral 100 (`#1A1A1A`)
### Alerts
Alerts provide contextual feedback in different semantic states.
**Background Colors:**
- **Information:** Blue 010 (`#E9EFFA`)
- **Success:** Green 010 (`#E6F6EF`)
- **Warning:** Yellow 010 (`#FEF5E5`)
- **Error:** Red 010 (`#FBEDEC`)
**Icon & Text Colors:**
- Use the corresponding 100-level color for icons and text (e.g., Brand 100 for info)
**Border Radius:** Large (8px) **Padding:** 12px (XLarge) **Gap:** 8px (Large) between icon and text
### Navigation Elements
**Top Navigation Bar:**
- Background: Neutral 000 (White)
- Shadow: Shadow 100 Down (downward shadow)
- Height: Standard app bar height
**Bottom Navigation Bar:**
- Background: Neutral 000 (White)
- Shadow: Shadow 100 Up (upward shadow)
- Height: Standard navigation bar height
**Tab Bar / Pills:**
- Use Full radius (999px) for pill-shaped tabs
- Active state: Brand 100 background with Neutral 000 text
- Inactive state: Transparent background with Neutral 060 text
---
## Usage Guidelines
### Color Application
1. **Primary Actions:** Use Brand 100 (`#5046C5`) for primary buttons and key interactive elements
2. **Text Hierarchy:**
  - Main headings: Neutral 100 (`#1A1A1A`)
  - Subheadings: Neutral 060 (`#767676`)
  - Body text: Neutral 100 (`#1A1A1A`)
3. **Semantic Meaning:**
  - Errors: Red 100 (`#DB4C40`)
  - Success: Green 100 (`#00A15E`)
  - Warnings: Yellow 100 (`#F59B00`)
  - Information: Blue 090 (`#3872D2`)
4. **Backgrounds:**
  - Page background: Neutral 000 (White) or Neutral 005 (`#F4F4F4`)
  - Card backgrounds: Neutral 000 (White)
  - Hover states: Corresponding 010 or 020 tints
### Typography Best Practices
1. **Hierarchy:** Use heading levels (H1-H5) to establish clear content hierarchy
2. **Body Text:** Default to B3 - Regular (14px) for most content
3. **Emphasis:** Use Medium weight (B4, B6) for emphasized text within body content
4. **Labels:** Use uppercase L1 - Medium for form labels and categories
5. **Line Length:** Maintain readable line lengths (45-75 characters) for body text
6. **Contrast:** Ensure text meets WCAG AA standards for contrast (4.5:1 for normal text, 3:1 for large text)
### Spacing Best Practices
1. **Consistency:** Use the defined spacing scale (2px, 4px, 8px, 12px, 16px, 20px, 24px) rather than arbitrary values
2. **Content Grouping:** Use larger spacing (16px-24px) to separate major sections
3. **Element Spacing:** Use medium spacing (8px-12px) between related elements
4. **Tight Spacing:** Use small spacing (2px-4px) for very closely related items
5. **Breathing Room:** Don't be afraid of white space; it improves readability
### Accessibility Considerations

#### WCAG 2.1 Compliance
This design system targets **WCAG 2.1 Level AA** compliance:
- **Normal text (< 18px):** Minimum 4.5:1 contrast ratio
- **Large text (≥ 18px or ≥ 14px bold):** Minimum 3:1 contrast ratio
- **UI components & graphics:** Minimum 3:1 contrast ratio

#### Approved Color Combinations

**Text on White/Light Backgrounds (Neutral 000, 005):**

| Text Color | Contrast Ratio | WCAG AA | WCAG AAA | Usage |
| --- | --- | --- | --- | --- |
| Neutral 100 `#1A1A1A` | 16.1:1 | ✅ Pass | ✅ Pass | Primary text, headings |
| Neutral 090 `#313131` | 12.6:1 | ✅ Pass | ✅ Pass | Body text |
| Neutral 080 `#484848` | 8.9:1 | ✅ Pass | ✅ Pass | Secondary text |
| Neutral 060 `#767676` | 4.5:1 | ✅ Pass | ❌ Fail | Subheadings (minimum for AA) |
| Brand 100 `#5046C5` | 6.4:1 | ✅ Pass | ✅ Pass | Links, primary actions |
| Blue 090 `#3872D2` | 4.7:1 | ✅ Pass | ❌ Fail | Information text |
| Green 100 `#00A15E` | 3.5:1 | ⚠️ Large text only | ❌ Fail | Success text (≥18px) |
| Red 100 `#DB4C40` | 3.9:1 | ⚠️ Large text only | ❌ Fail | Error text (≥18px) |
| Yellow 100 `#F59B00` | 2.4:1 | ❌ Fail | ❌ Fail | **Do not use** |

**❌ Non-Compliant Combinations to Avoid:**
- Neutral 040 `#A3A3A3` on white (2.9:1) - Insufficient for any text
- Neutral 020 `#D1D1D1` on white (1.6:1) - Borders/dividers only
- Yellow 100 `#F59B00` on white (2.4:1) - Use Yellow 140 `#9F690C` (4.6:1) instead
- Light Purple 080 `#9958FF` on white (3.3:1) - Large text only, prefer Light Purple 140

**Recommended Fixes for Semantic Colors:**

| Original | Issue | Recommended Alternative | Contrast Ratio |
| --- | --- | --- | --- |
| Yellow 100 on white | 2.4:1 ❌ | **Yellow 140** `#9F690C` | 4.6:1 ✅ |
| Green 100 on white | 3.5:1 (borderline) | **Green 140** `#0C6D44` or use ≥18px | 5.1:1 ✅ |
| Red 100 on white | 3.9:1 (borderline) | **Red 140** `#8F3A32` or use ≥18px | 6.2:1 ✅ |

**Text on Dark Backgrounds (Dark Purple 100 ****`#130739`****):**

| Text Color | Contrast Ratio | WCAG AA | Usage |
| --- | --- | --- | --- |
| Neutral 000 `#FFFFFF` | 17.8:1 | ✅ Pass | Headings, primary text |
| Neutral 020 `#D1D1D1` | 13.2:1 | ✅ Pass | Subheadings, secondary text |
| Neutral 040 `#A3A3A3` | 7.4:1 | ✅ Pass | Tertiary text |
| Light Purple 080 `#9958FF` | 6.1:1 | ✅ Pass | Accent text |

**UI Components & Interactive Elements:**

| Component | Foreground | Background | Contrast | Status |
| --- | --- | --- | --- | --- |
| Primary Button | White `#FFFFFF` | Brand 100 `#5046C5` | 6.4:1 | ✅ Pass |
| Error Button | White `#FFFFFF` | Red 100 `#DB4C40` | 3.9:1 | ✅ Pass (3:1 min) |
| Success Button | White `#FFFFFF` | Green 100 `#00A15E` | 3.5:1 | ✅ Pass (3:1 min) |
| Input Border (default) | N/A | Neutral 020 `#D1D1D1` | 1.6:1 vs white | ⚠️ Use 2px border |
| Input Border (focus) | N/A | Brand 100 `#5046C5` | 6.4:1 vs white | ✅ Pass |

#### Updated Usage Guidelines

1. **Text Color Selection:**
2. **Color Contrast:**
  - **Headings on light backgrounds:** Neutral 100 `#1A1A1A` (16.1:1) ✅
  - **Body text on light backgrounds:** Neutral 090 or 080 (8.9:1+) ✅
  - **Subheadings on light backgrounds:** Neutral 060 `#767676` (4.5:1) - minimum, use larger if possible ✅
  - **Disabled text:** Use Neutral 040 with reduced opacity or non-text indicators ⚠️
  - **Warning text:** Use Yellow 140 `#9F690C` instead of Yellow 100 ✅
  - **Error text (small):** Use Red 140 `#8F3A32` for <18px, Red 100 for ≥18px ✅
  - **Success text (small):** Use Green 140 `#0C6D44` for <18px, Green 100 for ≥18px ✅

2. **Focus States:**
  - Use Brand 100 outline (6.4:1 contrast with white) ✅
  - Minimum 2px outline width
  - Ensure 3:1 contrast between focus indicator and adjacent colors

3. **Touch Targets:**
  - Maintain minimum touch target size of 44x44px for mobile
  - Ensure 24px spacing between adjacent interactive elements

4. **Screen Readers:**
  - Use semantic HTML and proper ARIA labels
  - Provide text alternatives for icon-only buttons

5. **Color Independence:**
  - Don't rely solely on color to convey information
  - Use icons, labels, or patterns in addition to color coding
  - Example: Use ✓ icon with green for success, ⚠ icon with yellow for warnings

6. **Form Validation:**
  - Combine color with icons and text descriptions
  - Error states: Red border + error icon + error message
  - Success states: Green border + checkmark + success message

#### Accessibility Testing Tools
- **Contrast Checker:** [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- **Browser Extensions:**
  - WAVE (Web Accessibility Evaluation Tool)
  - axe DevTools
  - Lighthouse (built into Chrome DevTools)
- **Screen Readers:** Test with VoiceOver (Mac), NVDA (Windows), or JAWS
---
## Implementation Notes
### CSS Variables
It's recommended to implement these design tokens as CSS custom properties:
```javascript
:root {
  /* Neutral Colors */
  --color-neutral-000: #ffffff;
  --color-neutral-005: #f4f4f4;
  --color-neutral-010: #e8e8e8;
  --color-neutral-020: #d1d1d1;
  --color-neutral-040: #a3a3a3;
  --color-neutral-060: #767676;
  --color-neutral-080: #484848;
  --color-neutral-090: #313131;
  --color-neutral-100: #1a1a1a;

  /* Brand Colors */
  --color-brand-100: #5046c5;
  --color-brand-080: #736bd1;
  /* ... etc */

  /* Spacing */
  --spacing-small: 2px;
  --spacing-medium: 4px;
  --spacing-large: 8px;
  --spacing-xlarge: 12px;
  --spacing-2xlarge: 16px;
  --spacing-3xlarge: 20px;
  --spacing-4xlarge: 24px;

  /* Border Radius */
  --radius-small: 2px;
  --radius-medium: 4px;
  --radius-large: 8px;
  --radius-xlarge: 12px;
  --radius-2xlarge: 16px;
  --radius-3xlarge: 20px;
  --radius-4xlarge: 24px;
  --radius-full: 999px;

  /* Shadows */
  --shadow-100: 0px 0px 5px 0px rgba(0, 0, 0, 0.1);
  --shadow-100-up: 0px -1px 5px 0px rgba(28, 28, 28, 0.1);
  --shadow-100-down: 0px 1px 5px 0px rgba(28, 28, 28, 0.1);
  --shadow-200: 0px 3px 15px 0px rgba(28, 28, 28, 0.08);

  /* Typography */
  --font-family: 'Inter', sans-serif;
  
  /* Font Sizes */
  --font-size-10: 10px;
  --font-size-12: 12px;
  --font-size-14: 14px;
  --font-size-16: 16px;
  --font-size-18: 18px;
  --font-size-20: 20px;
  --font-size-24: 24px;
  --font-size-32: 32px;

  /* Font Weights */
  --font-weight-regular: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;

  /* Line Heights */
  --line-height-14: 14px;
  --line-height-16: 16px;
  --line-height-20: 20px;
  --line-height-24: 24px;
  --line-height-32: 32px;
  --line-height-40: 40px;
}
```
### Tailwind Configuration
For projects using Tailwind CSS, extend the default theme:
```javascript
module.exports = {
  theme: {
    extend: {
      colors: {
        neutral: {
          0: '#ffffff',
          5: '#f4f4f4',
          10: '#e8e8e8',
          20: '#d1d1d1',
          40: '#a3a3a3',
          60: '#767676',
          80: '#484848',
          90: '#313131',
          100: '#1a1a1a',
        },
        brand: {
          5: '#f6f6fc',
          10: '#edecf9',
          20: '#dcdaf3',
          40: '#b9b5e8',
          60: '#9690dc',
          80: '#736bd1',
          90: '#6259cb',
          100: '#5046c5',
          140: '#3c3682',
        },
        // ... add other color palettes
      },
      spacing: {
        'xs': '2px',
        'sm': '4px',
        'md': '8px',
        'lg': '12px',
        'xl': '16px',
        '2xl': '20px',
        '3xl': '24px',
      },
      borderRadius: {
        'xs': '2px',
        'sm': '4px',
        'md': '8px',
        'lg': '12px',
        'xl': '16px',
        '2xl': '20px',
        '3xl': '24px',
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
    },
  },
}
```
---
## Change Log
### Version 1.0.0 - January 15, 2026
- Initial comprehensive design system documentation
- Extracted all colors, typography, spacing, radius, and shadow values from Figma
- Documented gradients and semantic color applications
- Added implementation notes for CSS and Tailwind
---
## Resources
- **Figma File:** [HeyMax Altitude Design System](https://www.figma.com/design/dbfFXfoinjUfJaPOnOi7Dc/-HeyMax--Altitude)
- **Color Palette:** [View in Figma](https://www.figma.com/design/dbfFXfoinjUfJaPOnOi7Dc/-HeyMax--Altitude?node-id=102-2989)
- **Typography:** [View in Figma](https://www.figma.com/design/dbfFXfoinjUfJaPOnOi7Dc/-HeyMax--Altitude?node-id=102-2990)
- **Spacing & Misc:** [View in Figma](https://www.figma.com/design/dbfFXfoinjUfJaPOnOi7Dc/-HeyMax--Altitude?node-id=107-3975)
---
*This style guide is a living document and should be updated as the design system evolves.*