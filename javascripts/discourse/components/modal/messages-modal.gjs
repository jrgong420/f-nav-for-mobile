import Component from "@glimmer/component";
import { tracked, cached } from "@glimmer/tracking";
import { service } from "@ember/service";
import { action } from "@ember/object";
import { on } from "@ember/modifier";
import { htmlSafe } from "@ember/template";
import replaceEmoji from "discourse/helpers/replace-emoji";
import dirSpan from "discourse/helpers/dir-span";
import formatDate from "discourse/helpers/format-date";
import { ajax } from "discourse/lib/ajax";
import { fn, concat } from "@ember/helper";
import { and, or, eq } from "truth-helpers";
import concatClass from "discourse/helpers/concat-class";
import { renderAvatar } from "discourse/helpers/user-avatar";
import loadingSpinner from "discourse/helpers/loading-spinner";
import Composer from "discourse/models/composer";
import dIcon from "discourse-common/helpers/d-icon";
import DModal from "discourse/components/d-modal";
import DButton from "discourse/components/d-button";
import getURL from "discourse-common/lib/get-url";
import { i18n } from "discourse-i18n";

export default class MessageModal extends Component {
  @service currentUser;
  @service site;
  @service composer;
  @service modal;

  @tracked inboxes = null;
  @tracked loading = true;
  @tracked selectedTabIndex = 0;

  constructor() {
    super(...arguments);
    this.fetchAllInboxes();
  }

  async fetchAllInboxes() {
    if (this.inboxes) {
      return this.inboxes; // Cache
    }

    const currentUser = this.currentUser;

    try {
      const data = await ajax("/u/" + currentUser.username + "/messages.json");

      const personalRequests = [
        "/topics/private-messages/" + currentUser.username + ".json",
        "/topics/private-messages-sent/" + currentUser.username + ".json",
        "/topics/private-messages-new/" + currentUser.username + ".json",
        "/topics/private-messages-unread/" + currentUser.username + ".json",
      ];

      const personalData = await Promise.all(
        personalRequests.map(async (url, index) => {
          const messages = await ajax(url);
          const fullName = [
            i18n("user.messages.latest"),
            i18n("user.messages.sent"),
            i18n("user.messages.new"),
            i18n("user.messages.unread")
          ][index];
          return {
            full_name: fullName,
            ...messages,
          };
        })
      );

      const groupInboxes = await Promise.all(
        data.user.groups
          .filter((inbox) => inbox.has_messages)
          .map(async (inbox) => {
            const messages = await ajax(
              "/topics/private-messages-group/" +
                currentUser.username +
                "/" +
                inbox.name +
                ".json"
            );
            return { ...inbox, ...messages };
          })
      );

      const inboxes = groupInboxes.concat(
        personalData.map((messages) => ({
          full_name: messages.full_name,
          ...messages,
        }))
      );

      inboxes.forEach((inbox) => {
        inbox.unread_total = inbox.topic_list?.topics?.reduce((total, topic) => {
          if (!topic) return total;

          const unread =
            (Number.isInteger(topic.unread_posts) && topic.unread_posts > 0) ||
            (Number.isInteger(topic.unread_posts) && topic.unseen === true) ||
            (Number.isInteger(topic.unread_posts) && topic.last_read_post_number === null);

          if (unread) {
            total++;
            topic.unread = 1;
          } else {
            topic.unread = 0;
          }

          topic.posters.forEach((poster) => {
            const matchingUser = inbox.users.find((user) => user.id === poster.user_id);
            if (matchingUser) {
              Object.assign(poster, matchingUser);
            }
          });

          topic.participants.forEach((participant) => {
            const matchingUser = inbox.users.find((user) => user.id === participant.user_id);
            if (matchingUser) {
              Object.assign(participant, matchingUser);
            }
          });

          topic.first_poster = topic.posters[0];
          topic.last_poster = topic.posters[topic.posters.length - 1];
          topic.first_participant = topic.participants[0];
          topic.less_count = topic.allowed_user_count < 3;
          topic.more_count = topic.allowed_user_count - 2;
          topic.no_replies = topic.participants.length === 1 && topic.posters.length === 1;
          topic.valid_reply_count = topic.posts_count - 1;
          topic.first_last_poster = topic.first_poster === topic.last_poster;
          topic.has_one_poster = topic.posters.length === 1;

          return total;
        }, 0);
      });

      this.inboxes = inboxes;
      this.loading = false;
    } catch (error) {
      console.error("Error fetching inbox data:", error);
    }
  }

  @cached
  get allUnread() {
    return this.inboxes.reduce((total, inbox) => total + (inbox.unread_total || 0), 0);
  }

  get canSendPm() {
    return this.currentUser.can_send_private_messages;
  }

  @action
  selectTab(index) {
    this.selectedTabIndex = index;
  }

  @action
  newMessage() {
    this.composer.open({
      action: Composer.PRIVATE_MESSAGE,
      draftKey: Composer.NEW_PRIVATE_MESSAGE_KEY,
      archetypeId: "private_message",
    });
    this.modal.close();
  }

  <template>
    <DModal 
      @closeModal={{@closeModal}}
      @title={{i18n "js.user.private_messages"}}
      class="message-modal"
    >
      <:body>
        <div class="message-panel">
          <ul class="message-panel__inboxes nav-pills">
            {{#each this.inboxes as |inbox index|}}
              <li class="message-panel__inbox">
                <a
                  {{on "click" (fn this.selectTab index)}}
                  class={{concatClass
                    "inbox-item"
                    (if (eq index this.selectedTabIndex) "active")
                  }}
                >
                  {{if inbox.full_name inbox.full_name inbox.name}}
                  {{#unless (eq inbox.unread_total 0)}}
                    ({{inbox.unread_total}})
                  {{/unless}}
                </a>
              </li>
            {{/each}}
          </ul>
          
          {{#if this.loading}}
            {{loadingSpinner}}
          {{else}}
            {{#each this.inboxes as |inbox index|}}
              <ul
                class={{concatClass
                  "message-panel__messages"
                  (if (eq index this.selectedTabIndex) "active")
                }}
              >
                {{#if inbox.topic_list.topics}}
                  {{#each inbox.topic_list.topics as |message|}}
                    <li class={{concatClass (unless (eq message.unread 0) "unread")}}>
                      <a
                        class="message-panel__main-link"
                        href={{concat
                          "/t/"
                          message.slug
                          "/"
                          message.id
                          "/"
                          message.last_read_post_number
                        }}
                      >
                        <div 
                          class={{concatClass
                            "message-panel__info"
                            (unless message.has_one_poster "has-reply")
                          }}
                        >
                          <span class="message-panel__title">
                            {{#if (or message.closed message.bookmarked)}}
                              <div class="topic-statuses">
                                {{#if message.bookmarked}}
                                  <span
                                    title={{i18n "js.topic_statuses.bookmarked.help"}}
                                    class="topic-status op-bookmark"
                                  >
                                    {{dIcon "bookmark"}}
                                  </span>
                                {{/if}}
                                {{#if message.closed}}
                                  <span
                                    title={{i18n "js.topic_statuses.locked.help"}}
                                    class="topic-status"
                                  >
                                    {{dIcon "lock"}}
                                  </span>
                                {{/if}}
                              </div>
                            {{/if}}
                            {{htmlSafe (replaceEmoji message.title)}}
                            {{#unless (eq message.unread_posts 0)}}
                              <span class="badge-notification unread-notifications">
                                {{message.unread_posts}}
                              </span>
                            {{/unless}}
                          </span>
                          
                          <span class="message-panel__participants">
                            {{#unless message.has_one_poster}}
                              {{#each message.posters as |poster|}}
                                <a
                                  href={{concat "/u/" poster.username}}
                                  data-user-card={{poster.username}}
                                >
                                  {{htmlSafe
                                    (renderAvatar
                                      poster
                                      avatarTemplatePath="avatar_template"
                                      title=this.user.username
                                      usernamePath="username"
                                      imageSize="tiny"
                                    )
                                  }}
                                </a>
                              {{/each}}
                            {{else}}
                              {{#if 
                                (and message.no_replies
                                (eq message.first_poster.username message.first_participant.username))
                              }}
                                <a
                                  href={{concat "/u/" message.first_poster.username}}
                                  data-user-card={{message.first_poster.username}}
                                >
                                  {{htmlSafe
                                    (renderAvatar
                                      message.first_poster
                                      avatarTemplatePath="avatar_template"
                                      title=this.user.username
                                      imageSize="tiny"
                                    )
                                  }}
                                </a>
                              {{else if (eq message.first_poster.username message.first_participant.username)}}
                                {{#each message.participants as |participant|}}
                                  <a
                                    href={{concat "/u/" participant.username}}
                                    data-user-card={{participant.username}}
                                  >
                                    {{htmlSafe
                                      (renderAvatar
                                        participant
                                        avatarTemplatePath="avatar_template"
                                        title=this.user.username
                                        imageSize="tiny"
                                      )
                                    }}
                                  </a>
                                {{/each}}
                              {{else}}
                                <a
                                  href={{concat "/u/" message.first_poster.username}}
                                  data-user-card={{message.first_poster.username}}
                                >
                                  {{htmlSafe
                                    (renderAvatar
                                      message.first_poster
                                      avatarTemplatePath="avatar_template"
                                      title=this.user.username
                                      imageSize="tiny"
                                    )
                                  }}
                                </a>
                                {{#each message.participants as |participant|}}
                                  <a
                                    href={{concat "/u/" participant.username}}
                                    data-user-card={{participant.username}}
                                  >
                                    {{htmlSafe
                                      (renderAvatar
                                        participant
                                        avatarTemplatePath="avatar_template"
                                        title=this.user.username
                                        imageSize="tiny"
                                      )
                                    }}
                                  </a>
                                {{/each}}
                              {{/if}}
                            {{/unless}}
                          </span>
                          
                          <span class="message-panel__excerpt">
                            {{replaceEmoji (dirSpan message.excerpt htmlSafe="true")}}
                          </span>
                          
                          {{#if message.tags}}
                            <ul class="message-panel__tags">
                              {{#each message.tags as |tag|}}
                                <li>{{tag}}</li>
                              {{/each}}
                            </ul>
                          {{/if}}
                          
                          {{#if message.image_url}}
                            <div class="message-panel__topic-image">
                              <div class="topic-image">
                                <img src={{message.image_url}} alt="" />
                              </div>
                            </div>
                          {{/if}}
                          
                          <div class="message-panel__info-bottom">
                            <span class="message-panel__date">
                              {{formatDate message.last_posted_at format="tiny"}}
                              {{dIcon "clock"}}
                            </span>
                            <span class="message-panel__comment">
                              {{message.valid_reply_count}}
                              {{dIcon "comment"}}
                            </span>
                            <span class="message-panel__reactions">
                              {{message.like_count}}
                              {{dIcon "heart"}}
                            </span>
                            <span class="message-panel__views">
                              {{message.views}}
                              {{dIcon "eye"}}
                            </span>
                          </div>
                        </div>
                      </a>
                    </li>
                  {{/each}}
                {{else}}
                  <div class="empty-state">
                    <span class="empty-state-title">
                      {{i18n "user.no_messages_title"}}
                    </span>
                    <div class="empty-state-body">
                      <p>
                        {{htmlSafe
                          (i18n
                            "user.no_messages_body"
                            icon=(dIcon "envelope")
                            aboutUrl=(getURL "/about")
                          )
                        }}
                      </p>
                    </div>
                  </div>
                {{/if}}
              </ul>
            {{/each}}
          {{/if}}
        </div>
      </:body>
      <:footer>
        {{#unless this.loading}}
          {{#if this.canSendPm}}
            <DButton
              @class="btn-primary new-pm"
              @icon="envelope"
              @translatedLabel={{i18n "js.user.new_private_message"}}
              @action={{this.newMessage}}
            />
          {{/if}}
          <DButton
            @class="btn-transparent all-messages"
            @translatedLabel={{i18n "js.user.messages.all"}}
            @href={{concat "/u/" this.currentUser.username_lower "/messages"}}
          >
            {{dIcon "angle-right"}}
          </DButton>
        {{/unless}}
      </:footer>
    </DModal>
  </template>
}
