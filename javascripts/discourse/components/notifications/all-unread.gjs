import Component from "@glimmer/component";
import { hash } from "@ember/helper";
import { service } from "@ember/service";
import { and, eq, not, or } from "truth-helpers";
import icon from "discourse-common/helpers/d-icon";
import { i18n } from "discourse-i18n";

export default class AllUnread extends Component {
  @service currentUser;

  get isInDoNotDisturb() {
    return this.currentUser.isInDoNotDisturb();
  }

  <template>
    {{#unless this.isInDoNotDisturb}}
      {{#if this.currentUser.all_unread_notifications_count}}
        <a
          href="#"
          class="badge-notification unread-notifications"
          title={{i18n
            "notifications.tooltip.regular"
            (hash count=this.currentUser.all_unread_notifications_count)
          }}
          aria-label={{i18n
            "user.notifications"
            (hash count=this.currentUser.all_unread_notifications_count)
          }}
          tabindex="-1"
        >
          {{this.currentUser.all_unread_notifications_count}}
        </a>
      {{/if}}
    {{/unless}}
  </template>
}
