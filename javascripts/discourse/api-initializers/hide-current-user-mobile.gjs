import { apiInitializer } from "discourse/lib/api";

export default apiInitializer("1.8.0", (api) => {
  if (settings.custom_user_menu_installed) {
    api.addBodyClass("custom-user-menu-installed");
  }
});

