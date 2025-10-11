import { apiInitializer } from "discourse/lib/api";
import TopicBackButton from "../components/topic-back-button";

export default apiInitializer("1.14.0", (api) => {
  // Wrap the home logo to conditionally replace it with back button
  api.renderAfterWrapperOutlet("home-logo", TopicBackButton);
});

