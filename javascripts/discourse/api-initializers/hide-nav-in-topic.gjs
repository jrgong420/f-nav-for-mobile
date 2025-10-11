import { apiInitializer } from "discourse/lib/api";

export default apiInitializer("1.14.0", (api) => {
  if (!settings.hide_nav_in_topic) {
    return;
  }

  const router = api.container.lookup("service:router");
  
  const applyTopicClass = () => {
    const currentRoute = router.currentRouteName;
    const isInTopic = currentRoute?.startsWith("topic.");
    document.body.classList.toggle("hide-nav-in-topic", isInTopic);
  };

  // Apply on initial load
  applyTopicClass();

  // Apply on route changes
  router.on("routeDidChange", applyTopicClass);
});

