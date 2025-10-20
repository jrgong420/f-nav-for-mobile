import { apiInitializer } from "discourse/lib/api";

export default apiInitializer("1.8.0", (api) => {
  if (!settings.custom_user_menu_installed) {
    return;
  }

  // Add body class directly using DOM API
  document.body.classList.add("custom-user-menu-installed");
});

