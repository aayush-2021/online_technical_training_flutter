import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppCheckBox extends ConsumerWidget {
  const AppCheckBox({
    super.key,
    required this.textName,
    required this.status,
    required this.isChanged,
  });

  final String textName;
  final bool status;
  final Function(bool?) isChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            textName,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Checkbox(
          activeColor: Colors.blue,
          value: status,
          onChanged: isChanged,
        ),
      ],
    );
  }
}
