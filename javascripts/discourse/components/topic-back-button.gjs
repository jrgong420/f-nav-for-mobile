import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DiscourseURL from "discourse/lib/url";
import { on } from "@ember/modifier";
import dIcon from "discourse-common/helpers/d-icon";

export default class TopicBackButton extends Component {
  @service router;
  @service site;

  constructor() {
    super(...arguments);
    this.applyBodyClass();
    this._onRouteChange = () => this.applyBodyClass();
    this.router.on?.("routeDidChange", this._onRouteChange);
  }

  willDestroy() {
    super.willDestroy?.(...arguments);
    this.router.off?.("routeDidChange", this._onRouteChange);
    document.body.classList.remove("topic-back-button-active");
  }

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

  applyBodyClass() {
    document.body.classList.toggle("topic-back-button-active", this.shouldRender);
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
      <button class="topic-back-button" {{on "click" this.onClick}} aria-label="Back">
        {{dIcon "arrow-left"}}
      </button>
    {{/if}}
  </template>
}

