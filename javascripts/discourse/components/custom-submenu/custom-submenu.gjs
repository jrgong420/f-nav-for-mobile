import Component from "@glimmer/component";
import { action } from "@ember/object";
import { on } from "@ember/modifier";
import DMenu from "float-kit/components/d-menu";
import dIcon from "discourse-common/helpers/d-icon";

export default class CustomSubmenu extends Component {
  @action
  onRegisterApi(api) {
    this.dMenu = api;
  }

  // Uses Discourse core classes for header-style dropdown triggers:
  // - wrapper: .header-dropdown-toggle (state semantics)
  // - trigger: .icon.btn-flat (visual consistency)
  // Scoped with unique roots to preserve f-nav layout and allow customization:
  // - .f-nav-custom-submenu (trigger wrapper)
  // - .f-nav-custom-submenu-content (modal content wrapper)

  <template>
    <div class="f-nav-custom-submenu header-dropdown-toggle">
      <DMenu
        @identifier="custom-submenu"
        @arrow={{true}}
        @closeOnScroll={{true}}
        class="icon btn-flat custom-submenu-trigger"
        @modalForMobile={{true}}
        @onRegisterApi={{this.onRegisterApi}}
      >
        <:trigger>
          {{dIcon @tab.icon}}
        </:trigger>
        <:content as |args|>
          <div class="f-nav-custom-submenu-content custom-submenu-content">
            <ul class="custom-submenu-items">
              {{#each settings.f_nav_submenu_items as |item|}}
                <li {{on "click" args.close}} class="custom-submenu-item">
                  <a title={{item.label}} href={{item.url}}>
                    {{#if item.icon}}
                      {{dIcon item.icon}}
                    {{/if}}
                    <span class="item-label">
                      {{item.label}}
                    </span>
                  </a>
                </li>
              {{/each}}
            </ul>
          </div>
        </:content>
      </DMenu>
    </div>
  </template>
}

