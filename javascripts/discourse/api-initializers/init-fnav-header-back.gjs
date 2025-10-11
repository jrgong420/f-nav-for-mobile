import { apiInitializer } from "discourse/lib/api";
import FnavHeaderBack from "../components/fnav-header-back";

const BODY_CLASS = "fnav-header-back-active";

export default apiInitializer("1.14.0", (api) => {
  // Only render if the setting is enabled
  if (!settings.header_back_icon_enabled) {
    return;
  }

  // Get router service to check current route
  const router = api.container.lookup("service:router");

  // Toggle body class based on route
  const updateBodyClass = () => {
    const isTopicRoute = router.currentRouteName?.startsWith("topic.");
    document.body.classList.toggle(BODY_CLASS, isTopicRoute);
  };

  // Update on page change
  api.onPageChange(() => {
    updateBodyClass();
  });

  // Initial update
  updateBodyClass();

  // Replace the home logo contents with our custom back arrow
  // Only render when header is minimized (small logo state)
  api.renderInOutlet("home-logo-contents", <template>
    {{#if @outletArgs.minimized}}
      <FnavHeaderBack />
    {{/if}}
  </template>);
});

