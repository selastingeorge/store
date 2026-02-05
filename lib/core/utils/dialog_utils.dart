import 'package:flutter/material.dart';

class DialogUtils {
  static BuildContext? _messageDialogContext;
  static bool _isMessageDialogShowing = false;


  static void showMessageDialog(
      BuildContext context,
      String title,
      String message, {
        List<Widget>? actions,
      }) {

    if (_isMessageDialogShowing) return;
    _isMessageDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        _messageDialogContext = dialogContext;
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(message, style: const TextStyle(fontSize: 14, fontFamily: 'Inter')),
            actions:
            actions ?? [TextButton(onPressed: hideMessageDialog, child: const Text('Close'))],
          ),
        );
      },
    ).then((_) {
      _isMessageDialogShowing = false;
      _messageDialogContext = null;
    });
  }

  static void hideMessageDialog() {
    if (_messageDialogContext != null && _isMessageDialogShowing) {
      try {
        Navigator.of(_messageDialogContext!).pop();
      } catch (e) {
        debugPrint('Error closing message dialog: $e');
      }
      _messageDialogContext = null;
      _isMessageDialogShowing = false;
    }
  }

  static void showConfirmationDialog({
    required BuildContext context,
    String title = 'Confirm',
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) {
    if (_isMessageDialogShowing) hideMessageDialog();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, fontFamily: 'Inter', fontWeight: FontWeight.w600),
          ),
          content: Text(message, style: const TextStyle(fontSize: 14, fontFamily: 'Inter')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (onCancel != null) onCancel();
              },
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onConfirm();
              },
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }

  static bool isAnyDialogShowing() {
    return _isMessageDialogShowing;
  }
}
