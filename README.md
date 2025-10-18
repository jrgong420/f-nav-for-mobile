# F‑NAV for Mobile (Fork)

A fork of the F‑NAV Mobile Navigation Tabs theme component for Discourse with added mobile ergonomics, a configurable custom submenu, group‑based visibility controls, and an optional header back icon.

- Original: https://github.com/VaperinaDEV/f-nav-for-mobile
- Fork (this repo): https://github.com/jrgong420/f-nav-for-mobile

## Why this fork

- Provide a native‑feeling Back affordance on topic pages
- Offer a "customMenu" tab that opens a configurable submenu
- Control visibility of tabs and items by user group
- Fix deprecations and polish styles/accessibility

## Feature summary

- Header Back Icon (optional)
  - Replaces header home logo with a back arrow on topic routes
  - Behavior: go back if history exists; fallback to "/"
  - Toggle: `header_back_icon_enabled`
  - Files: `javascripts/discourse/components/fnav-header-back.gjs`, `javascripts/discourse/api-initializers/init-fnav-header-back.gjs`, `scss/mobile/fnav-header-back.scss`, `common/common.scss`

- Custom Submenu tab type
  - New `function: "customMenu"` for `f_nav_tabs` entries
  - New setting: `f_nav_submenu_items` (label, url; optional icon, groups)
  - Component: `javascripts/discourse/components/custom-submenu/custom-submenu.gjs`
  - Styling: `scss/mobile/custom-submenu.scss`
  - Integrated in F‑NAV item rendering flow

- Group‑based visibility controls
  - Tabs (`f_nav_tabs`), submenu items (`f_nav_submenu_items`), and `profile_extra_items` support optional `groups` restrictions
  - Anonymous users never see restricted items; empty `groups` means visible to all

- Optional: hide nav bar on topic pages
  - Toggle: `hide_nav_in_topic`
  - Adds/removes a body class to hide/show `.f-nav` on topic routes

- UX/A11y and maintenance
  - Polished hover/active/focus‑visible states
  - Consistent border radius via Discourse CSS variables
  - Resolved `site.mobileView` deprecation warnings by moving checks into components

## Comparison with the original

Original (VaperinaDEV):
- Mobile nav tabs component with optional chat integration
- No header back icon feature
- No `customMenu` tab type or submenu
- No group‑based visibility for tabs/items

This fork adds:
- Header back icon feature (optional, topic‑aware)
- `customMenu` tab type with configurable submenu items
- Group‑based visibility for tabs, submenu, and profile extra items
- Optional hide‑on‑topic behavior
- Testing docs and packaged builds (`/builds` directory)

## Requirements & compatibility

- Discourse with Theme/Plugin API v1.14.0 or newer (as referenced in initializers)
- Mobile‑focused component; desktop behavior depends on your theme
- If using custom icons, ensure they are included in the theme’s `svg_icons` list

## Installation

Install this as a Theme Component in your Discourse instance:

1. Admin → Customize → Themes → Components → Install → From a git repository
2. Repository URL: `https://github.com/jrgong420/f-nav-for-mobile`
3. Select the component on your active theme
4. Configure settings as needed (see below)

Optional: Test incremental builds from `/builds` (zip files) if you prefer file‑based installation.

## Configuration

Settings are defined in `settings.yml`. Key ones include:

- `f_nav_tabs` (objects list)
  - Add tabs to the nav bar. Example entry for a custom submenu tab:
    ```json
    { "name": "Menu", "icon": "bars", "function": "customMenu" }
    ```
  - Optional `groups` field to restrict visibility.

- `f_nav_submenu_items` (objects list)
  - Define submenu items shown when a `customMenu` tab is clicked.
  - Fields: `label` (required), `url` (required), `icon` (optional), `groups` (optional)
  - Example:
    ```json
    [
      { "icon": "users", "label": "Community", "url": "/c/community" },
      { "icon": "question-circle", "label": "Support", "url": "/c/support" },
      { "icon": "book", "label": "Documentation", "url": "/docs" }
    ]
    ```

- `profile_extra_items` (objects list)
  - Same shape as core setting, with optional `groups` for visibility.

- `header_back_icon_enabled` (bool)
  - Replaces the header home logo with a back arrow on topic pages. Default: `false`.

- `hide_nav_in_topic` (bool)
  - Hides the custom nav bar on topic pages. Default: `true`.

- `svg_icons` (list)
  - Include all Font Awesome 6 icons you plan to use (e.g. submenu icons). Default includes `angle-left|message|arrow-right`.

## Usage notes

- Back icon visibility
  - Appears on topic routes and when the header is minimized (rendered into the `home-logo-contents` outlet)
  - Click behavior: back if browser history length > 1; otherwise go home (`/`)

- Group restrictions
  - If `groups` is empty or omitted: visible to everyone
  - If `groups` is set: only members of at least one listed group can see the item/tab; anonymous users cannot

- Styling
  - Submenu and back icon styles align with Discourse variables for consistent theming
  - Touch‑friendly spacing and focus states included; dark‑mode supported

## Known limitations

- Mobile‑first component; desktop integration may require additional tweaks depending on your theme
- Back icon shows on topic routes; behavior elsewhere intentionally routes to home
- Some icons may require adding to `svg_icons` for proper rendering
- Tested on recent Discourse builds; older versions may require adjustments

## Development & testing

- See:
  - `TESTING_GUIDE.md` for test procedures
  - `TEST_RESULTS.md` for validation summaries
  - `IMPLEMENTATION_WORKFLOW.md` and `SETTINGS_EXAMPLES.md` for examples and notes
- Incremental build artifacts are available under `/builds` for convenience

## Acknowledgments

This project is a fork of the excellent work by **VaperinaDEV**.

- Original: https://github.com/VaperinaDEV/f-nav-for-mobile
- Fork: https://github.com/jrgong420/f-nav-for-mobile

Contributions and feedback are welcome!

