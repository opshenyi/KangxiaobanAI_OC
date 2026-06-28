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
import { ContactModel } from '../model/ContactModel';
import ContactListModel from '../model/ContactListModel';

@ObservedV2
export default class ContactListViewModel {
  @Trace public contacts: Record<string, Array<ContactModel>> = {};
  @Trace public nameFirstLetter: string[] = [];

  loadContacts() {
    let contactList = new ContactListModel([]);
    let contactSource = contactList.loadContacts();
    let sortedContactList = contactSource.sort((a: ContactModel, b: ContactModel) => a.name.localeCompare(b.name));
    for (let i = 0; i < sortedContactList.length; i++) {
      if (!sortedContactList[i].name || sortedContactList[i].name.length === 0) {
        continue;
      }
      const firstLetter = sortedContactList[i].name.substring(0, 1);
      if (!this.contacts[firstLetter]) {
        this.contacts[firstLetter] = [];
      }
      this.contacts[firstLetter].push(sortedContactList[i]);
    }
    this.nameFirstLetter = Object.keys(this.contacts).sort();
  }
}