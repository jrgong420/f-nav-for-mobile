import Component from "@glimmer/component";
import { hash } from "@ember/helper";
import { service } from "@ember/service";
import { and, eq, not, or } from "truth-helpers";
import icon from "discourse-common/helpers/d-icon";
import { i18n } from "discourse-i18n";

export default class NewPM extends Component {
  @service currentUser;

  get isInDoNotDisturb() {
    return this.currentUser.isInDoNotDisturb();
  }

  <template>
    {{#unless this.isInDoNotDisturb}}
      {{#if this.currentUser.new_personal_messages_notifications_count}}
        <a
          href="#"
          class="badge-notification with-icon new-pms"
          title={{i18n
            "notifications.tooltip.new_message_notification"
            (hash
              count=this.currentUser.new_personal_messages_notifications_count
            )
          }}
          aria-label={{i18n
            "notifications.tooltip.new_message_notification"
            (hash
              count=this.currentUser.new_personal_messages_notifications_count
            )
          }}
        >
          {{icon "envelope"}}
        </a>
      {{/if}}
    {{/unless}}
  </template>
}
