# Implementation Workflow - Custom Submenu Navigation

## Overview
This document outlines the workflow for implementing the custom submenu navigation feature with incremental testing and GitHub integration.

## Workflow Process

After each major implementation task, we follow this process:

1. **Implement Feature** - Code the feature component/functionality
2. **Commit Changes** - Git commit with descriptive message
3. **Compile Build** - Create zip file for testing
4. **Push to GitHub** - Push changes to feature branch
5. **Update Tasks** - Mark tasks as complete

## Task Structure

```
[x] Main Implementation Task
  ├─ [x] Compile and Test Build
  └─ [x] Push to GitHub
```

## Build Releases

All builds are stored in the `builds/` directory with version naming:

- `f-nav-mobile-v1-settings-schema.zip`
- `f-nav-mobile-v2-custom-submenu-component.zip`
- `f-nav-mobile-v3-fnav-integration.zip`
- `f-nav-mobile-v4-styling.zip`
- `f-nav-mobile-v5-final-with-tests.zip`

## GitHub Integration

**Branch:** `feature/multi-level-navigation`  
**Remote:** `origin`

Each push includes:
- Feature implementation code
- Documentation updates
- Build artifacts (tracked in builds/README.md)

## Testing Workflow

### For Each Build:

1. **Download** the zip file from `builds/` directory
2. **Install** in Discourse Admin → Customize → Themes
3. **Configure** settings as documented
4. **Test** functionality on mobile devices
5. **Report** any issues or bugs
6. **Iterate** if needed before moving to next task

### Testing Checklist:

- [ ] Settings save without errors
- [ ] No console errors in browser
- [ ] Mobile responsiveness verified
- [ ] Touch interactions work smoothly
- [ ] Visual appearance matches design
- [ ] Navigation functions correctly

## Current Status

### ✅ Completed Tasks:

1. **Research & Analysis Phase**
   - Discourse development guidelines researched
   - Existing codebase analyzed
   - Implementation pattern identified

2. **Settings Schema Design**
   - Added `customMenu` function type
   - Created `f_nav_submenu_items` setting
   - Documentation created (SETTINGS_EXAMPLES.md)
   - **Build:** v1-settings-schema.zip
   - **Commit:** 655da49
   - **Pushed:** ✅ origin/feature/multi-level-navigation

### 🔄 Next Tasks:

3. **Create Custom Submenu Component**
   - Implement CustomSubmenu.gjs
   - Follow avatar-menu/profile.gjs pattern
   - DMenu integration
   - **Build:** v2-custom-submenu-component.zip

4. **Update F-Nav Item Component**
   - Add isCustomMenu getter
   - Integrate CustomSubmenu component
   - **Build:** v3-fnav-integration.zip

5. **Add SCSS Styling**
   - Create custom-submenu.scss
   - Mobile-optimized styles
   - **Build:** v4-styling.zip

6. **Testing & Validation**
   - Write QUnit tests
   - Manual testing
   - **Build:** v5-final-with-tests.zip

## Git Commands Reference

### After Each Task:

```bash
# Stage changes
git add <files>

# Commit with descriptive message
git commit -m "feat: <description>"

# Create build
zip -r builds/f-nav-mobile-v<N>-<name>.zip <files>

# Push to GitHub
git push origin feature/multi-level-navigation
```

### Useful Commands:

```bash
# Check status
git status

# View commit history
git log --oneline

# View remote branches
git branch -a

# View diff
git diff
```

## Build Testing Instructions

### v1-settings-schema (Current)

**Installation:**
1. Download `builds/f-nav-mobile-v1-settings-schema.zip`
2. Install via Discourse Admin → Themes → Install → From a file
3. Enable on your active theme

**Configuration:**
1. Go to theme settings
2. Find `f_nav_tabs` setting
3. Add a tab with `function: customMenu`:
   ```json
   { "name": "Menu", "icon": "bars", "function": "customMenu" }
   ```
4. Find `f_nav_submenu_items` setting
5. Add test items:
   ```json
   [
     { "icon": "users", "label": "Community", "url": "/c/community" },
     { "icon": "question-circle", "label": "Support", "url": "/c/support" }
   ]
   ```

**Expected Results:**
- ✅ Settings save successfully
- ✅ No console errors
- ❌ Submenu doesn't appear yet (component not implemented)

**What to Test:**
- Settings UI works correctly
- Validation prevents invalid URLs
- Required fields are enforced
- Optional icon field works

## Documentation

### Key Files:

- **SETTINGS_EXAMPLES.md** - Configuration examples and use cases
- **builds/README.md** - Build release notes and testing instructions
- **IMPLEMENTATION_WORKFLOW.md** - This file, workflow documentation

### For Users:

- See SETTINGS_EXAMPLES.md for configuration help
- See builds/README.md for installation instructions

### For Developers:

- See implementation plan in conversation history
- See commit messages for change details
- See task list for progress tracking

## Support & Issues

### Before Reporting Issues:

1. Check you're using the latest build
2. Verify settings are configured correctly
3. Check browser console for errors
4. Test on a clean Discourse instance

### When Reporting Issues:

Include:
- Build version (e.g., v1-settings-schema)
- Discourse version
- Browser and device
- Steps to reproduce
- Console errors (if any)
- Screenshots (if applicable)

## Next Steps

1. **Implement CustomSubmenu Component** (Next task)
2. Test v2 build
3. Continue with F-Nav integration
4. Add styling
5. Write tests
6. Final release

---

**Last Updated:** 2025-10-04  
**Current Build:** v1-settings-schema  
**Branch:** feature/multi-level-navigation  
**Status:** Settings Schema Complete ✅

