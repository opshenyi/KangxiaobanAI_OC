/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import {
  HdsListItemCard,
  IconSize,
  PrefixIcon,
  SuffixArrowIconText,
  SuffixCheckbox,
  SuffixImage,
  SuffixSelect,
  SuffixSubIcon,
  SuffixSwitch,
  SuffixText,
  SuffixTextAndArrow
} from '@kit.UIDesignKit';
import { Logger } from 'componentuxexamplesbase';

const TAG = 'EfficientList';

@Builder
export function EfficientList() {
  ListItem() {
    HdsListItemCard({
      textItem: {
        primaryText: {
          text: $r('app.string.single_line_list_and_drop_down_options_label')
        }
      },
      suffixItem: new SuffixSelect({
        value: $r('app.string.pull_down_button_label'),
        optionValues: [$r('app.string.menu_item_label'), $r('app.string.menu_item_label'),
          $r('app.string.menu_item_label'), $r('app.string.menu_item_label')],
        optionSymbol: [],
        onSelect: (index: number, text: string) => {
          Logger.info(TAG, `Selected item index ${index}, value ${text}`);
        }
      })
    })
  }

  ListItem() {
    HdsListItemCard({
      textItem: {
        primaryText: {
          text: $r('app.string.right_side_checkbox_label')
        }
      },
      suffixItem: new SuffixCheckbox({
        onChange: (isChecked: boolean) => {
          Logger.info(TAG, `Checkbox isChecked ${isChecked}`);
        }
      })
    })
  }

  ListItem() {
    HdsListItemCard({
      textItem: {
        primaryText: {
          text: $r('app.string.right_text_select_label')
        }
      },
      suffixItem: new SuffixArrowIconText({
        startArrow: {},
        endArrow: {},
        text: { text: $r('app.string.list_right_text_label') }
      })
    })
  }

  ListItem() {
    HdsListItemCard({
      textItem: {
        primaryText: {
          text: $r('app.string.double_line_list_and_switch_label')
        },
        secondaryText: {
          text: $r('app.string.auxiliary_text_label')
        },
      },
      suffixItem: new SuffixSwitch({
        isCheck: false,
        onChange: (isOn: boolean) => {
          Logger.info(TAG, `Current toggle isSelected status: ${isOn}`);
        },
      })
    })
  }

  ListItem() {
    HdsListItemCard({
      textItem: {
        primaryText: {
          text: $r('app.string.right_side_image_label')
        },
        secondaryText: {
          text: $r('app.string.auxiliary_text_label')
        },
      },
      suffixItem: new SuffixImage({
        image: $r('app.media.img_1'),
      })
    })
  }

  ListItem() {
    HdsListItemCard({
      textItem: {
        primaryText: {
          text: $r('app.string.three_line_list_label'),
        },
        secondaryText: {
          text: $r('app.string.auxiliary_text_label')
        },
        description: {
          text: $r('app.string.auxiliary_text_label')
        }
      }
    })
  }

  ListItem() {
    HdsListItemCard({
      prefixItem: new PrefixIcon({
        iconSize: IconSize.SYSTEM_ICON,
        iconValue: {
          symbol: $r('sys.symbol.star_circle_fill')
        },
      }),
      textItem: {
        primaryText: {
          text: $r('app.string.icon_and_single_line_text_label')
        },
      }
    })
  }

  ListItem() {
    HdsListItemCard({
      prefixItem: new PrefixIcon({
        iconSize: IconSize.SYSTEM_ICON,
        iconValue: {
          symbol: $r('sys.symbol.star_circle_fill')
        },
      }),
      textItem: {
        primaryText: {
          text: $r('app.string.two_icons_on_the_right_label')
        },
      },
      suffixItem: new SuffixSubIcon({
        iconValue: {
          symbol: $r('sys.symbol.circle_dashed')
        },
        onClick: () => {
          Logger.info(TAG, 'The circle dash has been clicked currently.');
        },
      }, {
        iconValue: {
          symbol: $r('sys.symbol.circle_dashed')
        },
        onClick: () => {
          Logger.info(TAG, 'The circle dash has been clicked currently.');
        },
      })
    })

  }

  ListItem() {
    HdsListItemCard({
      prefixItem: new PrefixIcon({
        iconSize: IconSize.SYSTEM_ICON,
        iconValue: {
          symbol: $r('sys.symbol.star_circle_fill')
        },
      }),
      textItem: {
        primaryText: {
          text: $r('app.string.icon_and_double_line_text_label')
        },
        secondaryText: {
          text: $r('app.string.auxiliary_text_label')
        },
      },
      suffixItem: new SuffixText({
        text: $r('app.string.list_right_text_label')
      })
    })
  }

  ListItem() {
    HdsListItemCard({
      prefixItem: new PrefixIcon({
        iconSize: IconSize.SYSTEM_ICON,
        iconValue: {
          symbol: $r('sys.symbol.star_circle_fill')
        },
      }),
      textItem: {
        primaryText: {
          text: $r('app.string.icon_and_double_line_text_label')
        },
        secondaryText: {
          text: $r('app.string.auxiliary_text_label')
        },
      },
      suffixItem: new SuffixTextAndArrow({
        text: $r('app.string.list_right_text_label')
      }, {})
    })
  }
}