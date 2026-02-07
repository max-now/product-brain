Create a visual UX mockup for: {{arg1}}

## Determine Mockup Type

Extract from the user's request:
1. **Platform**: Mobile (React Native) or Web
  - If not specified, ask the user which platform they want
  - Mobile mockups should mimic React Native styling and components
  - Web mockups should use standard web patterns

2. **Mockup Type**: Determine if this is:
3. **New screen/feature** - Something that doesn't exist yet
4. **Modification to existing screen** - Changes to an existing UI in the codebase
  - **New screen/feature** - Something that doesn't exist yet
  - **Modification to existing screen** - Changes to an existing UI in the codebase

## Steps for NEW Screens

1. **Parse the request** - Understand what UI/screen/feature the user wants to mock up

2. **Load the style guide** - Read `nimbalyst-local/existing-screens/style-guide.mockup.md`
  - This contains the Design System with:
    - Complete colour palette (neutral, brand, semantic colours)
    - Typography system (Inter font family with all heading/body/label styles)
    - Spacing scale (2px-24px)
    - Border radius values
    - Shadow definitions
    - Component specifications (buttons, cards, forms, alerts, navigation)
    - Accessibility guidelines with WCAG-compliant colour combinations
  - **IMPORTANT**: Always use this style guide for consistency across all mockups
  - If additional platform-specific patterns are needed, supplement (don't replace) the style guide

3. **Create mockup file** - Create `nimbalyst-local/mockups/[descriptive-name].mockup.html`

4. **Build the mockup** - Write HTML with inline CSS using the design system:

  **For MOBILE (React Native) mockups:**
  - Use a mobile device frame (375x812px iPhone dimensions)
  - Mimic React Native styling patterns:
    - Use flexbox layouts (React Native's default)
    - Apply the design system colour palette from the style guide
    - Use Inter font family with the typography scale from the style guide
    - Implement the spacing system (2px-24px scale)
    - Include React Native-style components (TouchableOpacity appearance, native inputs)
    - Add platform-appropriate navigation (tab bar at bottom, header at top)
    - Use the border radius and shadow values from the style guide
    - Ensure touch targets meet 44x44px minimum
    - Include status bar at top
    - Read it to understand the app's design system
    - Call relevant MCPs required to obtain the information required

  **For WEB mockups:**
  - Use standard web dimensions (1200px+ desktop or responsive)
  - Apply the design system colour palette from the style guide
  - Use Inter font family with the typography scale from the style guide
  - Implement the spacing system (2px-24px scale)
  - Use the button, card, and form component styles from the style guide
  - Apply the border radius and shadow values from the style guide
  - Include web-appropriate navigation (top nav, sidebar, etc.)
  - Ensure accessibility compliance per the style guide (WCAG AA)

  **Common to both platforms:**
  - Colours: Use the complete design system palette (neutral, brand, semantic colours)
  - Typography: Inter font with the defined heading/body/label styles
  - Spacing: Use the 2px/4px/8px/12px/16px/20px/24px scale
  - Components: Follow the button, card, form, and alert specifications
  - Always reference the style guide for exact hex values and measurements

5. **Verify visually** - Use the Task tool to spawn a sub-agent that will:
  - Capture screenshot with `mcp__nimbalyst-mcp__capture_mockup_screenshot`
  - Analyze for layout issues or problems
  - Fix with Edit tool if needed
  - Re-capture and iterate until correct

### Design Principles (New Screens)

**CRITICAL: New screen mockups should look realistic and consistent with the existing app.**

- **Use the style guide**: Apply the HeyMax colour palette, Inter typography, and spacing system exactly
- **Platform-appropriate**:
  - Mobile: Mimic React Native patterns with native-looking components
  - Web: Use standard web UI patterns with hover states and desktop interactions
- **Realistic appearance**: Mockups should look like finished UI, not sketches
- **Clear hierarchy**: Use the typography scale (H1-H5, body styles) to show importance
- **Accessibility**: Follow WCAG AA guidelines from the style guide (proper contrast ratios, touch targets)
- **Consistent components**: Use the defined button, card, form, and alert styles
- **colour semantics**: Use Brand 100 for primary actions, semantic colours (red/green/yellow/blue) for status

## Steps for MODIFYING Existing Screens

### Directory Structure

- `nimbalyst-local/existing-screens/` - Cached replicas of existing UI screens
- `nimbalyst-local/mockups/` - Modified copies showing proposed changes

### Workflow

1. **Identify the screen** - Determine which existing screen/component is being modified

2. **Check for cached replica** - Look in `nimbalyst-local/existing-screens/` for `[screen-name].mockup.html`

3. **If cached replica EXISTS**:
  - Use the Task tool to spawn a sub-agent that will:
    - Check `git log` and `git diff` for changes to the relevant source files since the cached replica was last modified
    - If source files have changed, update the cached replica to match current implementation
    - If no changes, the cached replica is up-to-date
  - **No styling analysis needed** - The replica already contains all the styling information from the existing screen

4. **If cached replica DOES NOT EXIST**:
  - **Try to get a live screenshot first**:
    - If you have the ability to run the app and capture a screenshot automatically, do so - this gives the most accurate reference
    - If you cannot run the app, ask the user: "Would you like to provide a screenshot of the current screen? This will help me create a pixel-perfect replica. Otherwise, I'll recreate it from the source code."
  - **Deep code analysis** - Use the Task tool to spawn a sub-agent that will analyze the specific screen being replicated:
    - Find ALL relevant React components, CSS files, theme files, and related code **for this specific screen**
    - Extract exact colours (hex values), font sizes, font weights, line heights **used in this screen**
    - Document exact spacing values (padding, margin, gap) **in this screen**
    - Identify border radii, shadows, and other visual details **specific to this screen**
    - Spawn additional sub-agents if needed to cover different aspects (layout, typography, colours, icons)
    - If a screenshot was provided, use it as the reference to match pixel-for-pixel
    - **Note**: This is screen-specific analysis, not app-wide styling research
  - Create `nimbalyst-local/existing-screens/[screen-name].mockup.html` - a **pixel-perfect** HTML/CSS replica including:
    - Exact colours from the existing CSS
    - Exact typography (font family, size, weight, line height)
    - Exact spacing and dimensions
    - All visual details (shadows, borders, hover states if relevant)
  - Verify the replica visually with screenshot capture - iterate until it matches the original exactly

5. **Copy to mockups** - Copy the existing-screen replica to `nimbalyst-local/mockups/[descriptive-name].mockup.html`

6. **Apply modifications** - Edit the copy in mockups to include the proposed changes, keeping modifications **in full colour**

7. **Verify visually** - Use the Task tool to spawn a sub-agent to capture and verify the mockup

8. **If the replica was updated or created and you were not able to obtain a screenshot**, after creating the replica, prompt the user in bold: **If you are able to give me a screenshot of the existing screen I can improve the mockup**

### Design Principles (Modifications)

**CRITICAL: Modifications to existing screens should be in FULL COLOUR to show realistic integration.**

- **Use the style guide**: Apply design system colours if available, Inter typography, and spacing values
- **Match existing styles**: Ensure consistency with the cached replica's visual style
- **Platform consistency**:
  - Mobile: Maintain React Native patterns and native component appearance
  - Web: Keep web-appropriate patterns and interactions
- **Highlight changes**: Consider using a subtle indicator (like a coloured border or label) to show what's new/changed
- **Maintain consistency**: The mockup should look like it belongs in the existing app
- **Never modify existing-screens directly**: Always copy to mockups first, then modify the copy

## File Naming

- Use kebab-case: `settings-page.mockup.html`, `checkout-flow.mockup.html`
- Always use `.mockup.html` extension

## HTML Structure

Use standalone HTML with inline CSS. No external dependencies.

## User Annotations

The user can draw on mockups (circles, arrows, highlights). These annotations are **NOT** in the HTML source - you can only see them by capturing a screenshot with `mcp__nimbalyst-mcp__capture_mockup_screenshot`.

When the user draws annotations:
1. Capture a screenshot to see what they marked
2. Interpret their feedback
3. Update the mockup accordingly

## Error Handling

- **No description provided**: Ask the user what they want to mock up
- **Ambiguous request**: Ask clarifying questions about scope, layout, or specific components
- **Can't find existing screen**: Ask the user to clarify which screen they mean, or offer to create a new mockup instead
- **Complex multi-screen flow**: Offer to create separate mockup files for each screen

## Important Notes

- **All mockups should look realistic - Full colour, proper styling, consistent with the app and reference the design system if available** - Reference `nimbalyst-local/existing-screens/style-guide.mockup.md`
- **Platform specification required**: Always ask if mobile (React Native) or web if not specified
- **Mobile mockups**: Use 375x812px frame, React Native patterns, native-looking components, bottom tab navigation
- **Web mockups**: Use desktop dimensions, standard web patterns, top navigation or sidebar
- **colour palette**: Use HeyMax neutral, brand, and semantic colours from the style guide
- **Typography**: Inter font family with the defined heading/body/label scale
- **Spacing**: Apply the 2px-24px spacing system consistently
- **Accessibility**: Follow WCAG AA guidelines (proper contrast, touch targets, semantic HTML)
- **All mockups should look realistic** - Full colour, proper styling, production-ready appearance
- Focus on communicating the concept clearly
- Include enough detail to make decisions, but no more
