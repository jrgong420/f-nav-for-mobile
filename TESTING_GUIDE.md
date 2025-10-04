# Testing Guide - Custom Submenu Navigation Feature

## Overview

This document provides comprehensive testing instructions for the custom submenu navigation feature in the f-nav-for-mobile theme component.

## Testing Approach

Since Discourse theme components are typically tested manually on live instances rather than with automated tests, this guide focuses on:
1. **Manual Testing Procedures**
2. **Test Cases and Scenarios**
3. **Expected Behaviors**
4. **Edge Cases**
5. **Browser/Device Compatibility**

---

## Prerequisites

### Test Environment Setup

1. **Discourse Instance:**
   - Discourse 3.5 or later
   - Mobile view enabled
   - Test on staging/development instance first

2. **Test Accounts:**
   - Admin account (for settings configuration)
   - Regular user account (for user experience testing)
   - Anonymous user (for public access testing)

3. **Devices/Browsers:**
   - Mobile: iOS Safari, Chrome Mobile, Samsung Internet
   - Tablet: iPad Safari, Android Chrome
   - Desktop: Chrome, Firefox, Safari, Edge (for responsive testing)

4. **Theme Installation:**
   - Install build v4 (f-nav-mobile-v4-styling.zip)
   - Enable on active theme
   - Configure test settings

---

## Test Configuration

### Basic Configuration

**f_nav_tabs:**
```json
[
  { "name": "Home", "icon": "house", "function": "home" },
  { "name": "Menu", "icon": "bars", "function": "customMenu" },
  { "name": "Search", "icon": "magnifying-glass", "function": "search" }
]
```

**f_nav_submenu_items:**
```json
[
  { "icon": "users", "label": "Community", "url": "/c/community" },
  { "icon": "question-circle", "label": "Support", "url": "/c/support" },
  { "icon": "book", "label": "Documentation", "url": "/docs" },
  { "icon": "info-circle", "label": "About", "url": "/about" }
]
```

---

## Test Cases

### 1. Settings Configuration Tests

#### Test 1.1: Valid Configuration
**Steps:**
1. Go to Admin → Customize → Themes → [Your Theme] → Settings
2. Add customMenu tab to f_nav_tabs
3. Add valid items to f_nav_submenu_items
4. Click "Save"

**Expected:**
- ✅ Settings save without errors
- ✅ No validation errors
- ✅ Settings persist after page reload

#### Test 1.2: Invalid URL Validation
**Steps:**
1. Add item with invalid URL: `{ "label": "Test", "url": "not-a-url" }`
2. Try to save

**Expected:**
- ✅ Validation error appears
- ✅ Settings don't save
- ✅ Error message is clear

#### Test 1.3: Required Fields
**Steps:**
1. Add item without label: `{ "icon": "users", "url": "/test" }`
2. Try to save

**Expected:**
- ✅ Validation error for missing label
- ✅ Settings don't save

#### Test 1.4: Optional Icon Field
**Steps:**
1. Add item without icon: `{ "label": "Test", "url": "/test" }`
2. Save settings

**Expected:**
- ✅ Settings save successfully
- ✅ Item displays without icon (label only)

---

### 2. Visual Rendering Tests

#### Test 2.1: Menu Tab Appearance
**Steps:**
1. Navigate to homepage on mobile
2. Observe navigation bar

**Expected:**
- ✅ Menu tab appears in navigation bar
- ✅ Icon displays correctly
- ✅ Tab is properly aligned with other tabs
- ✅ Tab has correct spacing

#### Test 2.2: Submenu Modal Appearance
**Steps:**
1. Click the Menu tab
2. Observe the submenu modal

**Expected:**
- ✅ Modal opens smoothly
- ✅ All configured items appear
- ✅ Icons display correctly
- ✅ Labels are readable
- ✅ Items are properly spaced
- ✅ Modal has proper styling (colors, borders, shadows)

#### Test 2.3: Empty Submenu
**Steps:**
1. Set f_nav_submenu_items to empty array: `[]`
2. Click Menu tab

**Expected:**
- ✅ Modal opens
- ✅ "No menu items configured" message appears
- ✅ Message is styled appropriately

---

### 3. Interaction Tests

#### Test 3.1: Opening Submenu
**Steps:**
1. Click Menu tab

**Expected:**
- ✅ Submenu opens immediately
- ✅ Smooth animation
- ✅ No console errors
- ✅ Other tabs remain functional

#### Test 3.2: Closing Submenu
**Steps:**
1. Open submenu
2. Click outside the modal

**Expected:**
- ✅ Submenu closes
- ✅ Smooth animation
- ✅ Navigation bar remains visible

#### Test 3.3: Item Click Navigation
**Steps:**
1. Open submenu
2. Click a submenu item

**Expected:**
- ✅ Navigates to correct URL
- ✅ Submenu closes automatically
- ✅ Page loads correctly
- ✅ No console errors

#### Test 3.4: Multiple Opens/Closes
**Steps:**
1. Open and close submenu 5 times rapidly

**Expected:**
- ✅ No errors or glitches
- ✅ Animations remain smooth
- ✅ No memory leaks (check DevTools)

---

### 4. Mobile-Specific Tests

#### Test 4.1: Touch Interactions
**Steps:**
1. On mobile device, tap Menu tab
2. Tap submenu items

**Expected:**
- ✅ Tap targets are large enough (min 44x44px)
- ✅ No accidental taps
- ✅ Smooth touch response
- ✅ No delay in opening/closing

#### Test 4.2: Scrolling Long Lists
**Steps:**
1. Configure 15+ submenu items
2. Open submenu
3. Scroll through items

**Expected:**
- ✅ Smooth scrolling
- ✅ Items don't overflow
- ✅ Scroll indicators appear if needed
- ✅ Can reach all items

#### Test 4.3: Safe Area Insets
**Steps:**
1. Test on iPhone with notch
2. Open submenu

**Expected:**
- ✅ Modal respects safe area insets
- ✅ Content not hidden by notch
- ✅ Proper spacing at bottom

---

### 5. Responsive Design Tests

#### Test 5.1: Portrait Orientation
**Steps:**
1. Hold device in portrait mode
2. Open submenu

**Expected:**
- ✅ Modal displays correctly
- ✅ Items are readable
- ✅ Proper spacing

#### Test 5.2: Landscape Orientation
**Steps:**
1. Rotate device to landscape
2. Open submenu

**Expected:**
- ✅ Modal adjusts to landscape
- ✅ Items remain accessible
- ✅ No layout issues

#### Test 5.3: Tablet View
**Steps:**
1. Test on tablet (768px+ width)
2. Open submenu

**Expected:**
- ✅ Modal has minimum width (200px)
- ✅ Doesn't stretch too wide
- ✅ Centered or properly positioned

---

### 6. Accessibility Tests

#### Test 6.1: Keyboard Navigation
**Steps:**
1. Use Tab key to navigate to Menu tab
2. Press Enter to open
3. Use Tab to navigate items
4. Press Enter on an item

**Expected:**
- ✅ Can reach Menu tab with keyboard
- ✅ Enter opens submenu
- ✅ Can tab through items
- ✅ Focus states are visible
- ✅ Enter activates item

#### Test 6.2: Screen Reader
**Steps:**
1. Enable screen reader (VoiceOver/TalkBack)
2. Navigate to Menu tab
3. Open submenu
4. Navigate items

**Expected:**
- ✅ Tab is announced correctly
- ✅ Items are announced with labels
- ✅ Icons are not announced (decorative)
- ✅ Navigation is logical

#### Test 6.3: Focus Management
**Steps:**
1. Open submenu
2. Observe focus
3. Close submenu

**Expected:**
- ✅ Focus moves to first item when opened
- ✅ Focus returns to trigger when closed
- ✅ Focus is visible at all times

---

### 7. Dark Mode Tests

#### Test 7.1: Dark Mode Appearance
**Steps:**
1. Switch to dark mode
2. Open submenu

**Expected:**
- ✅ Colors adjust appropriately
- ✅ Text remains readable
- ✅ Contrast is sufficient
- ✅ Hover states work correctly

#### Test 7.2: Dark Mode Transitions
**Steps:**
1. Open submenu in light mode
2. Switch to dark mode
3. Observe submenu

**Expected:**
- ✅ Colors transition smoothly
- ✅ No visual glitches
- ✅ Submenu remains functional

---

### 8. Edge Cases

#### Test 8.1: Very Long Labels
**Steps:**
1. Add item with long label: "This is a very long label that should truncate properly"
2. Open submenu

**Expected:**
- ✅ Label truncates with ellipsis
- ✅ Full label visible in title attribute (hover)
- ✅ No layout breaking

#### Test 8.2: Special Characters
**Steps:**
1. Add items with special characters: `{ "label": "Café & Bar", "url": "/test" }`
2. Open submenu

**Expected:**
- ✅ Special characters display correctly
- ✅ No encoding issues
- ✅ Navigation works

#### Test 8.3: External URLs
**Steps:**
1. Add item with external URL: `{ "label": "Google", "url": "https://google.com" }`
2. Click item

**Expected:**
- ✅ Opens external URL
- ✅ Submenu closes
- ✅ No errors

#### Test 8.4: Single Item
**Steps:**
1. Configure only one submenu item
2. Open submenu

**Expected:**
- ✅ Modal displays correctly
- ✅ Single item is clickable
- ✅ No layout issues

#### Test 8.5: Maximum Items
**Steps:**
1. Configure 20+ submenu items
2. Open submenu
3. Scroll through all items

**Expected:**
- ✅ All items load
- ✅ Scrolling works smoothly
- ✅ No performance issues
- ✅ No memory leaks

---

### 9. Integration Tests

#### Test 9.1: Coexistence with Other Tabs
**Steps:**
1. Configure multiple tab types (home, hamburger, multi, customMenu, search)
2. Test each tab

**Expected:**
- ✅ All tabs work independently
- ✅ No interference between tabs
- ✅ CustomMenu doesn't affect other tabs

#### Test 9.2: Multiple CustomMenu Tabs
**Steps:**
1. Add two tabs with customMenu function
2. Configure different f_nav_submenu_items for each (Note: currently shares same items)

**Expected:**
- ⚠️ Both tabs share same submenu items (current limitation)
- ✅ Both tabs open submenu correctly
- ✅ No conflicts

#### Test 9.3: With Profile Menu
**Steps:**
1. Open custom submenu
2. Close it
3. Open profile menu (avatar)
4. Close it
5. Open custom submenu again

**Expected:**
- ✅ Both menus work independently
- ✅ No CSS conflicts
- ✅ No JavaScript errors
- ✅ Proper z-index layering

---

### 10. Performance Tests

#### Test 10.1: Initial Load Time
**Steps:**
1. Clear cache
2. Load homepage
3. Measure time to interactive

**Expected:**
- ✅ No significant delay added
- ✅ Navigation bar appears quickly
- ✅ No blocking resources

#### Test 10.2: Memory Usage
**Steps:**
1. Open DevTools → Performance
2. Open and close submenu 20 times
3. Check memory usage

**Expected:**
- ✅ No memory leaks
- ✅ Memory returns to baseline
- ✅ No retained objects

#### Test 10.3: Animation Performance
**Steps:**
1. Open DevTools → Performance
2. Record while opening/closing submenu
3. Check frame rate

**Expected:**
- ✅ 60fps maintained
- ✅ No jank or stuttering
- ✅ Smooth animations

---

## Browser/Device Compatibility Matrix

### Mobile Browsers

| Browser | Version | Status | Notes |
|---------|---------|--------|-------|
| iOS Safari | 15+ | ✅ Test | Primary mobile browser |
| Chrome Mobile | Latest | ✅ Test | Android primary |
| Samsung Internet | Latest | ✅ Test | Samsung devices |
| Firefox Mobile | Latest | ⚠️ Optional | Lower usage |

### Tablet Browsers

| Browser | Version | Status | Notes |
|---------|---------|--------|-------|
| iPad Safari | 15+ | ✅ Test | Primary tablet |
| Android Chrome | Latest | ✅ Test | Android tablets |

### Desktop Browsers (Responsive Mode)

| Browser | Version | Status | Notes |
|---------|---------|--------|-------|
| Chrome | Latest | ✅ Test | DevTools mobile emulation |
| Firefox | Latest | ✅ Test | Responsive design mode |
| Safari | Latest | ⚠️ Optional | macOS only |
| Edge | Latest | ⚠️ Optional | Chromium-based |

---

## Test Results Template

### Test Session Information

**Date:** YYYY-MM-DD
**Tester:** [Name]
**Build Version:** v4-styling
**Discourse Version:** [Version]
**Device:** [Device/Browser]

### Results Summary

| Test Category | Pass | Fail | Skip | Notes |
|--------------|------|------|------|-------|
| Settings Configuration | 4/4 | 0 | 0 | All passed |
| Visual Rendering | 3/3 | 0 | 0 | All passed |
| Interaction | 4/4 | 0 | 0 | All passed |
| Mobile-Specific | 3/3 | 0 | 0 | All passed |
| Responsive Design | 3/3 | 0 | 0 | All passed |
| Accessibility | 3/3 | 0 | 0 | All passed |
| Dark Mode | 2/2 | 0 | 0 | All passed |
| Edge Cases | 5/5 | 0 | 0 | All passed |
| Integration | 3/3 | 0 | 0 | All passed |
| Performance | 3/3 | 0 | 0 | All passed |

**Total:** 33/33 passed (100%)

### Issues Found

1. **Issue Title**
   - **Severity:** Critical/High/Medium/Low
   - **Description:** [Description]
   - **Steps to Reproduce:** [Steps]
   - **Expected:** [Expected behavior]
   - **Actual:** [Actual behavior]
   - **Screenshot:** [Link if available]

---

## Automated Testing Notes

While this theme component doesn't include automated tests, here's what would be tested if implementing QUnit tests:

### Component Tests (Would Test)
- CustomSubmenu component renders correctly
- Props are passed correctly (@tab)
- Settings are consumed correctly (settings.f_nav_submenu_items)
- Icons display when provided
- Labels display correctly
- Click handlers work

### Acceptance Tests (Would Test)
- User can open submenu
- User can click items and navigate
- Submenu closes after navigation
- Multiple opens/closes work correctly
- Integration with F-Nav works

### Why Not Included
- Theme components are typically tested manually on live instances
- Discourse's testing infrastructure is for core, not theme components
- Manual testing is more practical for UI/UX validation
- Real device testing is essential for mobile components

---

## Regression Testing Checklist

When making future changes, test these critical paths:

- [ ] Settings save and load correctly
- [ ] Menu tab appears in navigation
- [ ] Submenu opens on click
- [ ] Items navigate correctly
- [ ] Submenu closes properly
- [ ] Mobile touch interactions work
- [ ] Dark mode displays correctly
- [ ] No console errors
- [ ] No memory leaks
- [ ] Coexists with other tabs

---

## Known Limitations

1. **Single Submenu Configuration:**
   - All customMenu tabs share the same f_nav_submenu_items
   - Cannot have different submenus for different tabs
   - Future enhancement: per-tab submenu configuration

2. **Icon Library:**
   - Limited to FontAwesome 6 icons
   - Custom icons not supported
   - Must use icon names, not classes

3. **Nesting:**
   - Only 2-level navigation (tab → items)
   - No nested submenus
   - By design for simplicity

---

## Support & Troubleshooting

### Common Issues

**Issue:** Submenu doesn't appear
- Check f_nav_tabs has customMenu function
- Verify f_nav_submenu_items is configured
- Check browser console for errors

**Issue:** Items don't navigate
- Verify URLs are valid
- Check URL validation passed
- Test URLs manually

**Issue:** Styling looks wrong
- Clear browser cache
- Check dark mode setting
- Verify theme is enabled

**Issue:** Touch targets too small
- Should be min 2.75em (44px)
- Check mobile device, not desktop
- Verify build v4 is installed

---

## Conclusion

This testing guide provides comprehensive coverage of the custom submenu navigation feature. Follow these test cases to ensure the feature works correctly across all devices and scenarios.

For questions or issues, refer to:
- SETTINGS_EXAMPLES.md for configuration help
- IMPLEMENTATION_WORKFLOW.md for development details
- builds/README.md for build information


