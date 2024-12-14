import { apiInitializer } from "discourse/lib/api";
import AvatarProfile from "../components/avatar-menu/profile";

export default apiInitializer("1.8.0", (api) => {
  const site = api.container.lookup("site:main");
  const user = api.getCurrentUser();

  if (!site.mobileView || !user) {
    return;
  }
      
  api.headerIcons.add("avatar", AvatarProfile);
});
