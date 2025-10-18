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

  // Determine topic route quickly; fall back to URL path during initial paint
  const isTopicRouteNow = () => {
    const byRouter = router.currentRouteName?.startsWith("topic.");
    if (byRouter !== undefined) {
      return !!byRouter;
    }
    // Fallback: URL-based heuristic (e.g., /t/slug/id or /t/id)
    return /^\/t\//.test(window.location.pathname);
  };

  // Toggle body class based on route
  const updateBodyClass = () => {
    document.body.classList.toggle(BODY_CLASS, isTopicRouteNow());
  };

  // Update ASAP on route transitions
  router.on?.("routeDidChange", updateBodyClass);

  // Update on Discourse page change hook as well
  api.onPageChange(updateBodyClass);

  // Initial update
  updateBodyClass();

  // Register connector that only renders when minimized + topic route via shouldRender
  api.renderInOutlet("home-logo-contents", FnavHeaderBack);
});

