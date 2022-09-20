import 'package:curricuts/core/theme/app.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:webview_flutter/webview_flutter.dart';

class SubjectOverviewDialog extends StatelessWidget {
  const SubjectOverviewDialog({
    Key? key,
    required this.subject,
    // required this.onGetHelpTapped,
  }) : super(key: key);

  final SubjectEntity subject;
  // final VoidCallback onGetHelpTapped;

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
              child: WebView(initialUrl: subject.link),
              size: Size(1500, 1500),
            ),
            // const SizedBox(height: AppPaddingValues.xxSmallVerticalPadding),
            // _ContentWidget(subject: subject),
            // const SizedBox(height: AppPaddingValues.smallVerticalPadding),
            // _FooterWidget(onGetHelpTapped: onGetHelpTapped),
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

// class _ContentWidget extends StatelessWidget {
//   const _ContentWidget({
//     Key? key,
//     required this.subject,
//   }) : super(key: key);

//   final SubjectEntity subject;
//   static const keyPrefix = SubjectOverviewDialog.keyPrefix;

//   @override
//   Widget build(BuildContext context) {
//     const horizontalPadding = AppPaddingValues.mediumHorizontalPadding;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             // const SizedBox(height: AppPaddingValues.mediumVerticalPadding),
//             Text(
//               'Description',
//               // key: const Key('$keyPrefix-Description'),
//               textAlign: TextAlign.left,
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             Text(
//               subject.description ?? '',
//               key: const Key('$keyPrefix-Description'),
//               textAlign: TextAlign.left,
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//             const SizedBox(height: AppPaddingValues.mediumVerticalPadding),
//             Text(
//               'Teaching and learning Strategies',
//               // key: const Key('$keyPrefix-Description'),
//               textAlign: TextAlign.left,
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             Text(
//               subject.teachingLearningStrategies ?? '',
//               key: const Key('$keyPrefix-TeachingLearningStrategies'),
//               textAlign: TextAlign.left,
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _FooterWidget extends StatelessWidget {
//   const _FooterWidget({
//     Key? key,
//     required this.onGetHelpTapped,
//   }) : super(key: key);

//   final VoidCallback onGetHelpTapped;
//   static const keyPrefix = GetHelpDialog.keyPrefix;

//   @override
//   Widget build(BuildContext context) {
//     const horizontalPadding = AppPaddingValues.mediumHorizontalPadding;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
//       child: SingleChildScrollView(
//         child: OutlinedButton(
//           key: const Key('$keyPrefix-HelpButton'),
//           onPressed: onGetHelpTapped,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.phone_outlined, color: Theme.of(context).primaryColor),
//               const SizedBox(width: AppPaddingValues.xSmallVerticalPadding),
//               const Text(HelpConsts.getHelpPopUpButton),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
