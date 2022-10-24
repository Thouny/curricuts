import 'package:curricuts/core/enums/availability.dart';
import 'package:curricuts/core/enums/relative_relationship.dart';
import 'package:curricuts/core/theme/app.dart';
import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({Key? key}) : super(key: key);

  List<Widget> _getLabels(BuildContext context) {
    final widgets = <Widget>[];
    for (final element in RelativeRelationship.values) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppPaddingValues.xSmallPadding,
          ),
          child: Row(
            children: [
              Container(
                width: AppSizeValues.icon,
                height: AppSizeValues.icon,
                decoration: BoxDecoration(color: element.color),
              ),
              const SizedBox(width: 50),
              Text(
                element.label,
                style: Theme.of(context).textTheme.caption,
                maxLines: 2,
              ),
            ],
          ),
        ),
      );
    }
    for (final element in Availability.values) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppPaddingValues.xSmallPadding,
          ),
          child: Row(
            children: [
              Container(
                width: AppSizeValues.icon,
                height: AppSizeValues.icon,
                decoration: BoxDecoration(
                  color: element.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 50),
              Text(element.label, style: Theme.of(context).textTheme.caption),
            ],
          ),
        ),
      );
    }
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    widgets.add(
      Padding(
        padding: const EdgeInsets.only(
          bottom: AppPaddingValues.xSmallPadding,
        ),
        child: Row(
          children: [
            SizedBox(
                height: AppSizeValues.icon,
                width: AppSizeValues.icon,
                child: Text(
                  'cp',
                  textAlign: TextAlign.center,
                  style: bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                )),
            const SizedBox(width: 50),
            Text(
              'Credit Points',
              style: Theme.of(context).textTheme.caption,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: 300,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppPaddingValues.mediumPadding,
            AppPaddingValues.mediumPadding,
            AppPaddingValues.mediumPadding,
            0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Legends', style: Theme.of(context).textTheme.titleMedium),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: AppPaddingValues.xSmallPadding,
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: AppPaddingValues.xSmallPadding,
                ),
              ),
              ..._getLabels(context),
            ],
          ),
        ),
      ),
    );
  }
}
