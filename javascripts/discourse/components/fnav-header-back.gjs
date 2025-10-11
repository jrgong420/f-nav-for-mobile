import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { on } from "@ember/modifier";
import dIcon from "discourse-common/helpers/d-icon";
import DiscourseURL from "discourse/lib/url";

export default class FnavHeaderBack extends Component {
  @service router;

  static shouldRender(args) {
    // Render only when header is minimized AND topic route is active
    return !!(args?.minimized && document.body.classList.contains("fnav-header-back-active"));
  }

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
    {{! Only render on topic routes }}
    {{#if this.isTopicRoute}}
      <span class="fnav-header-back">
        <button
          type="button"
          class="btn btn-flat btn-icon no-text"
          title="Back"
          aria-label="Back"
          {{on "click" this.handleClick}}
        >
          {{dIcon "angle-left"}}
        </button>
      </span>
    {{/if}}
  </template>
}

