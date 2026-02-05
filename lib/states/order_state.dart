class OrderState {
  final List<Map<String, dynamic>> orders;
  final int offset;

  OrderState({required this.orders, this.offset = 0});

  OrderState copyWith({List<Map<String, dynamic>>? orders, int? offset}) {
    return OrderState(orders: orders ?? this.orders, offset: offset ?? this.offset);
  }
}
