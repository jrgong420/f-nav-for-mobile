import { apiInitializer } from "discourse/lib/api";
import FnavHeaderBack from "../components/fnav-header-back";

export default apiInitializer("1.14.0", (api) => {
  // Only render if the setting is enabled
  if (!settings.header_back_icon_enabled) {
    return;
  }

  // Replace the home logo contents with our custom back arrow
  api.renderInOutlet("home-logo-contents", FnavHeaderBack);
});

