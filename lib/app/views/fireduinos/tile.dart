import 'package:flutter/material.dart';

class FireduinoTile extends StatelessWidget {
  const FireduinoTile({
    required this.index,
    required this.name,
    required this.serialId,
    super.key
  });

  final int index;
  final String name;
  final String serialId;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text("#$index", style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant
            )),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant
                  )),
                  const SizedBox(height: 4),
                  Text(serialId.toString(), style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}