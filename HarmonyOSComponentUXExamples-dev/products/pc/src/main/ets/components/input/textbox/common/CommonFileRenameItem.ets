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

import { KeyCode } from '@kit.InputKit';
import { CommonConstants, CommonUtils, CornerRadiusToken, PaddingToken, SizeToken, SpaceToken } from 'componentuxexamplesbase';
import { FileItemModel } from '../model/FileItemModel';
import { FileItemInputMode, FileItemLayoutMode } from '../model/TextBoxConfig';

/**
 * Enterprise Encapsulation: Universal File Rename Item
 * Handles all focus, blur, rename, and state synchronization internally.
 */
@ComponentV2
export struct CommonFileRenameItem {
  @Param fileItem: FileItemModel = new FileItemModel({ fileName: '', icon: $r('sys.media.ic_grid_unknown') });
  @Param activeFileId: string = '';
  @Param layoutMode: FileItemLayoutMode = FileItemLayoutMode.LIST_ROW;
  @Param inputMode: FileItemInputMode = FileItemInputMode.SINGLE_LINE;
  @Local modifier: TextInputEllipsisModifier =
    new TextInputEllipsisModifier(this.inputMode === FileItemInputMode.SINGLE_LINE);
  @Local isEditing: boolean = false;
  @Local editingText: string = '';
  // Logical flags that do not directly drive UI changes should NOT be state variables,
  // preventing unnecessary render cycles and performance waste.
  private actionLockTimeout: number = -1;
  private textInputController: TextInputController = new TextInputController();
  private textAreaController: TextAreaController = new TextAreaController();
  private originFileName: string = '';

  get isSelected(): boolean {
    return this.activeFileId === this.fileItem.id;
  }

  @Event onActiveIdChange: (id: string) => void = () => {
  };

  aboutToAppear() {
    this.editingText = this.fileItem.fileName;
    this.originFileName = this.fileItem.fileName;
  }

  // Clear the timeout when the component is destroyed to prevent memory leaks
  // or crashes if the timeout triggers after the component is unmounted.
  aboutToDisappear() {
    if (this.actionLockTimeout !== -1) {
      clearTimeout(this.actionLockTimeout);
    }
  }

  build() {
    // Dynamically render layout based on enterprise configuration
    if (this.layoutMode === FileItemLayoutMode.GRID_COLUMN) {
      this.GridColumnLayout()
    } else {
      this.ListRowLayout()
    }
  }

  /**
   * Layout Builder: Grid Style (e.g., MultiInlineTextBox)
   */
  @Builder
  private GridColumnLayout() {
    Column({ space: SpaceToken.SPACE_8 }) {
      Row() {
        Image(this.fileItem.icon)
          .objectFit(ImageFit.Contain)
          .constraintSize({ maxWidth: SizeToken.SIZE_NUM_76, maxHeight: SizeToken.SIZE_NUM_76 })
      }
      .width(SizeToken.SIZE_NUM_90)
      .height(SizeToken.SIZE_NUM_90)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)
      .backgroundColor((this.isSelected || this.isEditing) ? $r('sys.color.comp_emphasize_tertiary') :
        Color.Transparent)
      .focusable(true)
      .focusOnTouch(true)
      .onClick(() => this.handleSelectOrEdit())
      .onBlur(() => this.handleBlur())

      if (this.isEditing) {
        TextArea({ text: this.editingText, controller: this.textAreaController })
          .id(`rename_input_${this.fileItem.id}`)
          .onAppear(() => focusControl.requestFocus(`rename_input_${this.fileItem.id}`))
          .textAlign(TextAlign.Center)
          .width(SizeToken.SIZE_NUM_132)
          .backgroundColor(Color.Transparent)
          .style(TextContentStyle.INLINE)
          .maxLines(CommonConstants.TEXT_MAX_LINES_3, { overflowMode: MaxLinesMode.SCROLL })
          .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
          .enterKeyType(EnterKeyType.Done)
          .wordBreak(WordBreak.BREAK_ALL)
          .borderWidth(SizeToken.SIZE_NUM_2)
          .borderRadius(CornerRadiusToken.CORNER_RADIUS_4)
          .fontSize($r('sys.float.Subtitle_M'))
          .fontColor($r('sys.color.font_primary'))
          .onChange((value: string) => {
            this.editingText = value;
          })
          .onFocus(() => this.handleFocus(this.textAreaController))
          .onKeyEvent((event: KeyEvent) => {
            if (event.type === KeyType.Down && event.keyCode === KeyCode.KEYCODE_ENTER) {
              this.commitRename();
            }
          })
          // Safely bind events; the robust lock in commitRename handles the deduplication
          .onBlur(() => this.commitRename())
          .onSubmit(() => this.commitRename())
      } else {
        Text(this.fileItem.fileName)
          .width(SizeToken.SIZE_NUM_128)
          .textAlign(TextAlign.Center)
          .maxLines(CommonConstants.TEXT_MAX_LINES_2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontSize($r('sys.float.Subtitle_M'))
          .fontColor(!this.isSelected ? $r('sys.color.font_primary') : $r('sys.color.font_on_primary'))
          .backgroundColor(this.isSelected ? $r('sys.color.background_emphasize') : Color.Transparent)
          .borderRadius(CornerRadiusToken.CORNER_RADIUS_4)
          .focusable(true)
          .focusOnTouch(true)
          .onClick(() => this.handleSelectOrEdit())
          .onBlur(() => this.handleBlur())
      }
    }
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * Layout Builder: List Style (e.g., Single/Scrollable InlineTextBox)
   */
  @Builder
  private ListRowLayout() {
    Row() {
      Image(this.fileItem.icon).width(SizeToken.SIZE_NUM_24)

      TextInput({ text: this.editingText, controller: this.textInputController })
        .backgroundColor(Color.Transparent)
        .style(TextInputStyle.Inline)
        .constraintSize({ maxWidth: SizeToken.SIZE_PERCENT_60 })
        .maxLines(this.inputMode === FileItemInputMode.SINGLE_LINE ? CommonConstants.TEXT_MAX_LINES_1 :
          CommonConstants.TEXT_MAX_LINES_3)
        .wordBreak(this.inputMode === FileItemInputMode.SCROLLABLE_INLINE ? WordBreak.BREAK_ALL : WordBreak.NORMAL)
        .borderWidth(this.isEditing ? SizeToken.SIZE_NUM_2 : SizeToken.SIZE_NUM_0)
        .borderRadius(CornerRadiusToken.CORNER_RADIUS_4)
        .fontSize(this.inputMode === FileItemInputMode.SINGLE_LINE ? $r('sys.float.Body_L') :
          $r('sys.float.Subtitle_M'))
        .fontColor($r('sys.color.font_primary'))
        .attributeModifier(this.modifier)
        .maxLength(CommonConstants.TEXT_MAX_LENGTH_100)
        .onChange((value: string) => {
          this.editingText = value;
        })
        .onFocus(() => {
          this.isEditing = true;
          this.onActiveIdChange(this.fileItem.id);
          this.handleFocus(this.textInputController);
        })
        .onBlur(() => this.commitRename())
        .onSubmit(() => this.commitRename())

      Blank()

      Text(this.fileItem.fileTime)
        .fontSize($r('sys.float.Body_S'))
        .fontColor($r('sys.color.font_tertiary'))
    }
    .width(SizeToken.SIZE_PERCENT_100)
    .height(SizeToken.SIZE_NUM_40)
    .backgroundColor((this.isSelected || this.isEditing) ? $r('sys.color.comp_emphasize_tertiary') : Color.Transparent)
    .borderRadius(CornerRadiusToken.CORNER_RADIUS_8)
    .padding({ left: PaddingToken.PADDING_12VP, right: PaddingToken.PADDING_12VP })
    .focusable(true)
    .focusOnTouch(true)
    .onClick(() => this.onActiveIdChange(this.fileItem.id))
    .onBlur(() => this.handleBlur())
  }

  // --- Shared Business Logic ---
  private handleSelectOrEdit() {
    if (!this.isSelected) {
      this.onActiveIdChange(this.fileItem.id);
    } else {
      this.isEditing = true;
      this.onActiveIdChange('');
    }
  }

  private handleBlur() {
    if (!this.isEditing && this.isSelected) {
      this.onActiveIdChange('');
    }
  }

  private handleFocus(controller: TextInputController | TextAreaController) {
    this.originFileName = this.fileItem.fileName;
    this.editingText = this.fileItem.fileName;
    const lastDotIndex = this.editingText.lastIndexOf('.');
    controller.setTextSelection(
      0,
      lastDotIndex === -1 ? this.editingText.length : this.editingText.substring(0, lastDotIndex).length
    );
  }

  private commitRename() {
    // Guard: Prevent execution if not in editing mode OR if the lock is currently active.
    if (!this.isEditing || this.actionLockTimeout !== -1) {
      return;
    }

    // Set an asynchronous lock window (150ms) to absorb 'onSubmit', 'onKeyEvent', and 'onBlur' echo events.
    this.actionLockTimeout = setTimeout(() => {
      this.actionLockTimeout = -1;
    }, CommonConstants.DURATION_150);

    this.isEditing = false;

    if (this.isSelected) {
      this.onActiveIdChange('');
    }

    const newName = this.editingText.replace(/\r?\n/g, '');

    if (newName.length === 0) {
      this.editingText = this.originFileName;
    } else if (newName !== this.originFileName) {
      this.fileItem.fileName = newName;
      this.fileItem.fileTime = CommonUtils.getCurrentFormattedTime();
      this.originFileName = newName;
    }

    this.editingText = this.fileItem.fileName;
    this.textInputController.stopEditing();
    this.textAreaController.stopEditing();
  }
}

class TextInputEllipsisModifier implements AttributeModifier<TextInputAttribute> {
  // Boolean flag controlling whether ellipsis truncation is enabled
  public enableEllipsis: boolean = false;

  constructor(enable?: boolean) {
    this.enableEllipsis = enable ?? false;
  }

  applyNormalAttribute(instance: TextInputAttribute): void {
    if (this.enableEllipsis) {
      instance.textOverflow(TextOverflow.Ellipsis)
        .ellipsisMode(EllipsisMode.CENTER);
    }
  }
}