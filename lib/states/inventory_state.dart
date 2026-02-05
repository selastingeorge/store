class InventoryState {
  final List<Map<String, dynamic>> assets;
  final int offset;

  InventoryState({
    required this.assets,
    this.offset = 0,
  });

  InventoryState copyWith({
    List<Map<String, dynamic>>? assets,
    int? offset,
  }) {
    return InventoryState(
      assets: assets ?? this.assets,
      offset: offset ?? this.offset,
    );
  }
}
