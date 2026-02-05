import 'package:flutter/material.dart';

enum OrderStatus {
  all('All Status'),
  draft('Draft'),
  pending('Pending'),
  processingStarted('Processing Started'),
  approved('Approved'),
  accepted('Accepted'),
  inTransit('In Transit'),
  delivered('Delivered'),
  returnAccepted('Return Accepted'),
  rejected('Rejected');

  const OrderStatus(this.label);

  final String label;

  // ---------- Parsing ----------

  static OrderStatus fromLabel(String label) =>
      OrderStatus.values.firstWhere(
            (e) => e.label.toLowerCase() == label.toLowerCase(),
        orElse: () => OrderStatus.all,
      );

  static OrderStatus fromString(String value) {
    final normalized = value.toLowerCase().replaceAll('_', ' ').trim();

    switch (normalized) {
      case 'draft':
        return OrderStatus.draft;
      case 'processing':
      case 'processing started':
        return OrderStatus.processingStarted;
      case 'in transit':
        return OrderStatus.inTransit;
      case 'return accepted':
      case 'return_accepted':
        return OrderStatus.returnAccepted;
      default:
        return OrderStatus.fromLabel(value);
    }
  }

  // ---------- Labels ----------

  String get shortLabel {
    switch (this) {
      case OrderStatus.processingStarted:
        return 'Processing';
      case OrderStatus.returnAccepted:
        return 'Return';
      default:
        return label;
    }
  }

  // ---------- Colors ----------

  static Color getStatusBackgroundColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.draft:
        return const Color(0xFFf1f5f9); // slate-100
      case OrderStatus.approved:
        return const Color(0xFFdbeafe);
      case OrderStatus.accepted:
      case OrderStatus.delivered:
        return const Color(0xFFd0fae5);
      case OrderStatus.pending:
        return const Color(0xFFfef3c6);
      case OrderStatus.processingStarted:
        return const Color(0xFFe0f2fe);
      case OrderStatus.returnAccepted:
        return const Color(0xFFffe4e6); // rose-100
      case OrderStatus.rejected:
        return const Color(0xFFffe2e2);
      case OrderStatus.inTransit:
        return const Color(0xFFf3e8ff);
      default:
        return const Color(0xFF314158);
    }
  }

  static Color getStatusForegroundColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.draft:
        return const Color(0xFF475569); // slate-600
      case OrderStatus.approved:
        return const Color(0xFF1447e6);
      case OrderStatus.accepted:
      case OrderStatus.delivered:
        return const Color(0xFF007a55);
      case OrderStatus.pending:
        return const Color(0xFFb45309);
      case OrderStatus.processingStarted:
        return const Color(0xFF0369a1);
      case OrderStatus.returnAccepted:
        return const Color(0xFFbe123c); // rose-700
      case OrderStatus.rejected:
        return const Color(0xFFb91c1c);
      case OrderStatus.inTransit:
        return const Color(0xFF6d28d9);
      default:
        return Colors.white;
    }
  }
}
