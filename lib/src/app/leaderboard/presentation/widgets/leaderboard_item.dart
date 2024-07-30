import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/util/types.dart';
import 'package:flutter/material.dart';

class LeaderboardItem extends StatelessWidget {
  const LeaderboardItem({
    required this.data,
    this.name,
    super.key,
  });

  final String? name;
  final LeaderboardPosition data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '${data.position}',
              style: context.textTheme.bodyLarge,
            ),
          ),
        ),
      ),
      title: Text(name ?? ''),
      subtitle: Text(
        'Last updated ${data.model.updatedAt.formatEDMY}',
        style: context.textTheme.bodySmall,
      ),
      trailing: Text('${data.model.points} pts'),
    );
  }
}
