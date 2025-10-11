import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DiscourseURL from "discourse/lib/url";
import { on } from "@ember/modifier";
import dIcon from "discourse-common/helpers/d-icon";

export default class TopicBackButton extends Component {
  @service router;
  @service site;

  get isTopicRoute() {
    return this.router.currentRouteName?.startsWith?.("topic.");
  }

  get shouldRender() {
    return (
      settings.hide_nav_in_topic &&
      settings.show_topic_back_button_in_header &&
      this.site.mobileView &&
      this.isTopicRoute
    );
  }

  @action
  onClick() {
    if (window.history.length > 1) {
      window.history.back();
    } else {
      DiscourseURL.routeTo("/");
    }
  }

  <template>
    {{#if this.shouldRender}}
      <div class="topic-back-button-wrapper">
        <button class="topic-back-button" {{on "click" this.onClick}} aria-label="Back">
          {{dIcon "arrow-left"}}
        </button>
      </div>
    {{else}}
      {{! Render default logo content when not in topic }}
      {{yield}}
    {{/if}}
  </template>
}

