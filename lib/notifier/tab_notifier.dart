import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:store/states/tab_state.dart';

part 'tab_notifier.g.dart';

@riverpod
class TabNotifier extends _$TabNotifier {
  @override
  TabState build() {
    return TabState(0, "Asset Management", false);
  }

  void setTab(int tab) {
    final TabState tabState = state;
    String tabTitle = "Asset Management";
    bool isBackButtonVisible = false;

    switch (tab) {
      case 0:
        tabTitle = "Asset Management";
        isBackButtonVisible = false;
        break;
      case 1:
        tabTitle = "Total Assets";
        isBackButtonVisible = true;
        break;
      case 2:
        tabTitle = "Orders";
        isBackButtonVisible = true;
        break;
    }
    state = tabState.copyWith(tabIndex: tab, tabTitle: tabTitle, isBackAvailable: isBackButtonVisible);
  }
}
