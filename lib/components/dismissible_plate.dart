import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';

class DismissiblePlate extends StatelessWidget {
  final String id;
  final Widget childWidget;
  final VoidCallback onDismissed;
  final String confirmTitle;
  final String confirmMessage;
  final String dismissSnackBarMessage;

  const DismissiblePlate({
    super.key,
    required this.childWidget,
    required this.onDismissed,
    required this.confirmTitle,
    required this.confirmMessage,
    required this.dismissSnackBarMessage,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: redBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: textPrimary, size: 28),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(confirmTitle),
              content: Text(confirmMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        onDismissed();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dismissSnackBarMessage)));
      },
      child: childWidget
    );
  }
}
