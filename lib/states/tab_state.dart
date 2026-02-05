class TabState {
  final int tabIndex;
  final String tabTitle;
  final bool isBackAvailable;

  TabState(this.tabIndex, this.tabTitle, this.isBackAvailable);

  TabState copyWith({int? tabIndex, String? tabTitle, bool? isBackAvailable}) {
    return TabState(
      tabIndex ?? this.tabIndex,
      tabTitle ?? this.tabTitle,
      isBackAvailable ?? this.isBackAvailable,
    );
  }
}
