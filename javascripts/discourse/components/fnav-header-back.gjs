import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { on } from "@ember/modifier";
import dIcon from "discourse-common/helpers/d-icon";
import DiscourseURL from "discourse/lib/url";

export default class FnavHeaderBack extends Component {
  @service router;

  get isTopicRoute() {
    return this.router.currentRouteName?.startsWith("topic.");
  }

  @action
  handleClick(e) {
    e.preventDefault();
    e.stopPropagation();
    
    if (this.isTopicRoute) {
      // Check if there's history to go back to
      if (window.history.length > 1) {
        window.history.back();
      } else {
        // Fallback to home if no history
        DiscourseURL.routeTo("/");
      }
    } else {
      DiscourseURL.routeTo("/");
    }
  }

  <template>
    <span
      class="fnav-header-back"
      role="button"
      tabindex="0"
      title={{if this.isTopicRoute "Back" "Home"}}
      aria-label={{if this.isTopicRoute "Back" "Home"}}
      {{on "click" this.handleClick}}
    >
      {{dIcon (if this.isTopicRoute "arrow-left" "house")}}
    </span>
  </template>
}

