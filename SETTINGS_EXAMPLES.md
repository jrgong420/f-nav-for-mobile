# F-NAV Custom Submenu - Settings Examples

## Overview
This document provides example configurations for the custom submenu feature in f-nav-for-mobile.

## Settings Structure

### 1. f_nav_tabs Configuration

To enable the custom submenu, add a tab with `function: customMenu` to your `f_nav_tabs` setting:

```json
[
  { "name": "Home", "icon": "house", "function": "home" },
  { "name": "Menu", "icon": "bars", "function": "customMenu" },
  { "name": "Notification", "icon": "bell", "function": "notificationMenu" },
  { "name": "Search", "icon": "magnifying-glass", "function": "search" }
]
```

### 2. f_nav_submenu_items Configuration

Define the items that appear in the custom submenu:

```json
[
  { "icon": "users", "label": "Community", "url": "/c/community" },
  { "icon": "question-circle", "label": "Support", "url": "/c/support" },
  { "icon": "book", "label": "Documentation", "url": "/docs" },
  { "label": "External Link", "url": "https://example.com" }
]
```

## Complete Examples

### Example 1: Basic Community Navigation

**f_nav_tabs:**
```json
[
  { "name": "Home", "icon": "house", "function": "home" },
  { "name": "Quick Links", "icon": "link", "function": "customMenu" },
  { "name": "Messages", "icon": "message", "function": "multi" },
  { "name": "Notifications", "icon": "bell", "function": "notificationMenu" }
]
```

**f_nav_submenu_items:**
```json
[
  { "icon": "users", "label": "All Categories", "url": "/categories" },
  { "icon": "fire", "label": "Latest", "url": "/latest" },
  { "icon": "star", "label": "Top", "url": "/top" },
  { "icon": "tags", "label": "Tags", "url": "/tags" }
]
```

### Example 2: Support & Resources

**f_nav_tabs:**
```json
[
  { "name": "Home", "icon": "house", "function": "home" },
  { "name": "Resources", "icon": "circle-info", "function": "customMenu" },
  { "name": "Search", "icon": "magnifying-glass", "function": "search" }
]
```

**f_nav_submenu_items:**
```json
[
  { "icon": "question-circle", "label": "Help Center", "url": "/c/help" },
  { "icon": "book", "label": "Documentation", "url": "/docs" },
  { "icon": "video", "label": "Tutorials", "url": "/c/tutorials" },
  { "icon": "comments", "label": "Community Forum", "url": "/c/community" },
  { "icon": "external-link", "label": "Official Website", "url": "https://example.com" }
]
```

### Example 3: Multi-Language Site

**f_nav_tabs:**
```json
[
  { "name": "Home", "icon": "house", "function": "home" },
  { "name": "Languages", "icon": "globe", "function": "customMenu" },
  { "name": "Hamburger", "icon": "bars", "function": "hamburger" }
]
```

**f_nav_submenu_items:**
```json
[
  { "icon": "flag-usa", "label": "English", "url": "/c/english" },
  { "icon": "flag", "label": "Español", "url": "/c/espanol" },
  { "icon": "flag", "label": "Français", "url": "/c/francais" },
  { "icon": "flag", "label": "Deutsch", "url": "/c/deutsch" }
]
```

### Example 4: E-commerce/Product Site

**f_nav_tabs:**
```json
[
  { "name": "Home", "icon": "house", "function": "home" },
  { "name": "Shop", "icon": "cart-shopping", "function": "customMenu" },
  { "name": "Account", "icon": "user", "function": "notificationMenu" }
]
```

**f_nav_submenu_items:**
```json
[
  { "icon": "shirt", "label": "Clothing", "url": "/c/clothing" },
  { "icon": "laptop", "label": "Electronics", "url": "/c/electronics" },
  { "icon": "house", "label": "Home & Garden", "url": "/c/home-garden" },
  { "icon": "tag", "label": "Sale Items", "url": "/c/sale" },
  { "icon": "truck", "label": "Track Order", "url": "/orders" }
]
```

### Example 5: Minimal Setup (No Icons)

**f_nav_tabs:**
```json
[
  { "name": "Home", "icon": "house", "function": "home" },
  { "name": "More", "icon": "ellipsis", "function": "customMenu" }
]
```

**f_nav_submenu_items:**
```json
[
  { "label": "About Us", "url": "/about" },
  { "label": "Contact", "url": "/contact" },
  { "label": "Privacy Policy", "url": "/privacy" },
  { "label": "Terms of Service", "url": "/terms" }
]
```

## Field Reference

### f_nav_tabs Fields
- **name** (required): Display name for the tab
- **icon** (required): FontAwesome 6 icon name
- **function** (required): Tab function type
  - Use `customMenu` to enable the custom submenu
- **destination** (optional): URL for direct navigation (not used with customMenu)

### f_nav_submenu_items Fields
- **icon** (optional): FontAwesome 6 icon name
- **label** (required): Display text for the menu item
- **url** (required): Destination URL
  - Internal: `/c/category`, `/latest`, `/tags`
  - External: `https://example.com`

## Tips

1. **Icon Selection**: Browse FontAwesome 6 icons at https://fontawesome.com/icons
2. **Menu Length**: Keep submenu items to 5-7 for optimal mobile experience
3. **Label Length**: Use concise labels (1-3 words) for better mobile display
4. **URL Validation**: All URLs are validated - ensure they're properly formatted
5. **Testing**: Test on actual mobile devices to verify usability

## Common Use Cases

- **Category Navigation**: Quick access to main forum categories
- **Resource Links**: Documentation, help, tutorials
- **External Links**: Company website, social media, related sites
- **User Actions**: Profile, settings, account management
- **Language Selection**: Multi-language site navigation
- **Product Categories**: E-commerce category browsing

## Troubleshooting

**Submenu not appearing?**
- Verify tab has `function: customMenu` in f_nav_tabs
- Check that f_nav_submenu_items has at least one item
- Ensure all required fields (label, url) are filled

**Icons not showing?**
- Verify icon names match FontAwesome 6 naming
- Check svg_icons setting includes your custom icons
- Icons are optional - items work without them

**Links not working?**
- Verify URL format is correct
- Internal links should start with `/`
- External links need full URL with `https://`

