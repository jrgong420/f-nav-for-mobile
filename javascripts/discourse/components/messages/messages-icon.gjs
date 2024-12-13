import Component from "@glimmer/component";
import { service } from "@ember/service";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";
import { i18n } from "discourse-i18n";
import MessagesModal from "../modal/messages-modal";

export default class MessagesIcon extends Component {
  @service currentUser;
  @service site;
  @service modal;

  get isInDoNotDisturb() {
    return this.currentUser.isInDoNotDisturb();
  }

  @action
  openMessagesModal() {
    this.modal.show(MessagesModal);
  }

  <template>
    <DButton
      @icon="envelope"
      class="icon btn-flat message-icon"
      @translatedTitle={{i18n "user.private_messages"}}
      @action={{this.openMessagesModal}}
    >
      {{#unless this.isInDoNotDisturb}}
        {{#if this.currentUser.new_personal_messages_notifications_count}}
          <div class="message-unread-indicator -urgent">
            {{this.currentUser.new_personal_messages_notifications_count}}
          </div>
        {{/if}}
      {{/unless}}
    </DButton>
  </template>
}
