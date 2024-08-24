import 'package:flutter/material.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/util/types.dart';

class LeaderboardItem extends StatelessWidget {
  const LeaderboardItem({
    required this.data,
    this.name,
    this.avatarColor,
    super.key,
  });

  final String? name;
  final LeaderboardPosition data;
  final Color? avatarColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: avatarColor ?? context.theme.inputDecorationTheme.fillColor,
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
        context.loc.lastUpdatedAt(data.model.updatedAt.formatEDMHM),
        style: context.textTheme.bodySmall,
      ),
      trailing: Text(
        context.loc.npts(data.model.points),
        style: context.textTheme.bodySmall,
      ),
    );
  }
}
