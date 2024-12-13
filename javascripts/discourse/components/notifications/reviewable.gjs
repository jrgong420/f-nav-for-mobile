import Component from "@glimmer/component";
import { hash } from "@ember/helper";
import { service } from "@ember/service";
import { and, eq, not, or } from "truth-helpers";
import icon from "discourse-common/helpers/d-icon";
import { i18n } from "discourse-i18n";

export default class Reviewable extends Component {
  @service currentUser;

  get isInDoNotDisturb() {
    return this.currentUser.isInDoNotDisturb();
  }

  <template>
    {{#unless this.isInDoNotDisturb}}
      {{#if this.currentUser.unseen_reviewable_count}}
        <a
          href="#"
          class="badge-notification with-icon new-reviewables"
          title={{i18n
            "notifications.tooltip.new_reviewable"
            (hash count=this.currentUser.unseen_reviewable_count)
          }}
          aria-label={{i18n
            "notifications.tooltip.new_reviewable"
            (hash count=this.currentUser.unseen_reviewable_count)
          }}
        >
          {{icon "flag"}}
        </a>
      {{/if}}
    {{/unless}}
  </template>
}
