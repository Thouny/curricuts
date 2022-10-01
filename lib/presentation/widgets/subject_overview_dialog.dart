import 'package:curricuts/core/theme/app.dart';
import 'package:curricuts/presentation/models/subject.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:webview_flutter/webview_flutter.dart';

class SubjectOverviewDialog extends StatelessWidget {
  const SubjectOverviewDialog({
    Key? key,
    required this.subject,
  }) : super(key: key);

  final SubjectModel subject;

  static const keyPrefix = 'SubjectOverviewDialog';

  @override
  Widget build(BuildContext context) {
    const radius = AppBorderRadiusValues.xSmallBorderRadius;
    final borderRadius = BorderRadius.circular(radius);

    return Dialog(
      key: const Key(keyPrefix),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _CloseButtonWidget(),
            _TitleWidget(title: subject.name),
            SizedBox.fromSize(
              size: const Size(1500, 1500),
              child: WebView(initialUrl: subject.link),
            ),
            const SizedBox(height: AppPaddingValues.mediumVerticalPadding),
          ],
        ),
      ),
    );
  }
}

class _CloseButtonWidget extends StatelessWidget {
  const _CloseButtonWidget({Key? key}) : super(key: key);

  static const keyPrefix = SubjectOverviewDialog.keyPrefix;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: RawMaterialButton(
        key: const Key('$keyPrefix-CloseButton'),
        onPressed: () => Navigator.pop(context),
        fillColor: Colors.black54,
        constraints: const BoxConstraints(
          minWidth: AppWidthValues.closeButtonMinWidth,
          minHeight: AppHeightValues.closeButtonMinHeight,
        ),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.close,
          size: AppSizeValues.closeIconDialog,
          color: Colors.white54,
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  static const keyPrefix = SubjectOverviewDialog.keyPrefix;

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = AppPaddingValues.mediumHorizontalPadding;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        title,
        key: const Key('$keyPrefix-TitleText'),
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
