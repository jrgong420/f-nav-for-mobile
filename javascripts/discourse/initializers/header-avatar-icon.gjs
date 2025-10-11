import { apiInitializer } from "discourse/lib/api";
import AvatarProfile from "../components/avatar-menu/profile";

export default apiInitializer("1.8.0", (api) => {
  const user = api.getCurrentUser();

  if (!user) {
    return;
  }

  // The AvatarProfile component will handle mobile view check during rendering
  api.headerIcons.add("avatar", AvatarProfile);
});
