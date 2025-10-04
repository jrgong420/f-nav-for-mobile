# F-NAV Mobile Theme Component - Build Releases

This directory contains incremental build releases for testing the custom submenu navigation feature.

## How to Test

1. Download the desired zip file
2. Go to your Discourse Admin Panel → Customize → Themes
3. Click "Install" → "From a file"
4. Upload the zip file
5. Enable the theme component on your active theme
6. Configure the settings as needed

## Build Versions

### v3-fnav-integration (Current) ⭐
**File:** `f-nav-mobile-v3-fnav-integration.zip`
**Date:** 2025-10-04
**Commit:** d659fcb

**What's Included:**
- ✅ New `customMenu` function type in f_nav_tabs
- ✅ New `f_nav_submenu_items` setting
- ✅ CustomSubmenu.gjs component with DMenu integration
- ✅ F-Nav Item integration (COMPLETE!)
- ✅ Settings schema with validation
- ✅ Comprehensive documentation

**What's NOT Included:**
- ⚠️ SCSS styling (basic functionality works, styling pending)
- ❌ Tests (not yet implemented)

**Testing Instructions:**
1. Install the theme component
2. Go to theme settings
3. Configure f_nav_tabs with customMenu:
   ```json
   { "name": "Menu", "icon": "bars", "function": "customMenu" }
   ```
4. Configure f_nav_submenu_items:
   ```json
   [
     { "icon": "users", "label": "Community", "url": "/c/community" },
     { "icon": "question-circle", "label": "Support", "url": "/c/support" },
     { "icon": "book", "label": "Documentation", "url": "/docs" }
   ]
   ```
5. **The submenu should now appear!** Click the Menu tab to see the dropdown

**Expected Behavior:**
- ✅ Settings save successfully
- ✅ Menu tab appears in navigation bar
- ✅ Clicking menu tab opens submenu dropdown
- ✅ Submenu items are clickable and navigate correctly
- ✅ Menu closes when item is clicked
- ⚠️ Styling may need refinement (next task)

---

### v2-custom-submenu-component
**File:** `f-nav-mobile-v2-custom-submenu-component.zip`
**Date:** 2025-10-04
**Commit:** d842cae

**What's Included:**
- ✅ CustomSubmenu.gjs component with DMenu integration
- ❌ Not integrated with F-Nav (component exists but not rendered)

---

### v1-settings-schema
**File:** `f-nav-mobile-v1-settings-schema.zip`  
**Date:** 2025-10-04  
**Commit:** 655da49

**What's Included:**
- ✅ New `customMenu` function type in f_nav_tabs
- ✅ New `f_nav_submenu_items` setting
- ✅ Settings schema with validation
- ✅ Comprehensive documentation

---

## Upcoming Builds

### v4-styling (Next)
**Planned Features:**
- Complete SCSS styling
- Mobile-optimized layouts
- Touch-friendly interactions
- Custom submenu modal styling

### v5-final-with-tests
**Planned Features:**
- QUnit component tests
- QUnit acceptance tests
- Complete feature implementation

---

## GitHub Repository

**Branch:** feature/multi-level-navigation  
**Repository:** https://github.com/jrgong420/f-nav-for-mobile

Each build is tagged and pushed to GitHub for version control.

---

## Version History

| Version | Date | Commit | Description |
|---------|------|--------|-------------|
| v3-fnav-integration | 2025-10-04 | d659fcb | F-Nav integration - submenu now functional! |
| v2-custom-submenu-component | 2025-10-04 | d842cae | CustomSubmenu component implementation |
| v1-settings-schema | 2025-10-04 | 655da49 | Initial settings schema implementation |

