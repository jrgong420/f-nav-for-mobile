import { apiInitializer } from "discourse/lib/api";
import TopicBackButton from "../components/topic-back-button";

export default apiInitializer("1.14.0", (api) => {
  // Render our back button component inside the header logo wrapper
  api.renderInOutlet("home-logo-wrapper-outlet", TopicBackButton);
});

