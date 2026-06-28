export class BottomTabItem {
  id: number = 0;
  title: Resource = $r('app.string.app_name');
  icon: Resource = $r('app.media.startIcon');
  selectIcon: Resource = $r('app.media.startIcon');
}

export class TopTabItem {
  id: number = 0;
  title: string = '';
}

export function getBottomTabs(): BottomTabItem[] {
  let tabs: BottomTabItem[] = [];
  let tab0 = new BottomTabItem();
  tab0.id = 0;
  tab0.title = $r('app.string.tab_home');
  tab0.icon = $r('sys.symbol.house');
  tab0.selectIcon = $r('sys.symbol.house_fill');
  tabs.push(tab0);

  let tab1 = new BottomTabItem();
  tab1.id = 1;
  tab1.title = $r('app.string.tab_discover');
  tab1.icon = $r('sys.symbol.compass');
  tab1.selectIcon = $r('sys.symbol.compass');
  tabs.push(tab1);

  let tab2 = new BottomTabItem();
  tab2.id = 2;
  tab2.title = $r('app.string.tab_message');
  tab2.icon = $r('sys.symbol.message');
  tab2.selectIcon = $r('sys.symbol.message_fill');
  tabs.push(tab2);

  let tab3 = new BottomTabItem();
  tab3.id = 3;
  tab3.title = $r('app.string.tab_mine');
  tab3.icon = $r('sys.symbol.person');
  tab3.selectIcon = $r('sys.symbol.person_fill');
  tabs.push(tab3);

  return tabs;
}

export function getTopTabs(): TopTabItem[] {
  let tabs: TopTabItem[] = [];
  let tab0 = new TopTabItem();
  tab0.id = 0;
  tab0.title = '推荐';
  tabs.push(tab0);

  let tab1 = new TopTabItem();
  tab1.id = 1;
  tab1.title = '热门';
  tabs.push(tab1);

  let tab2 = new TopTabItem();
  tab2.id = 2;
  tab2.title = '关注';
  tabs.push(tab2);

  return tabs;
}
