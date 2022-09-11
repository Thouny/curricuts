import 'package:curricuts/core/theme/app.dart';
import 'package:flutter/material.dart';

class ErrorCardWidget extends StatelessWidget {
  static const keyPrefix = 'ErrorCardWidget';
  final String? message;

  /// Sets whether this widget should render its own [Card].
  ///
  /// Set to false if `this` is already contained inside
  /// a [Card] (eg. for content types).
  final bool shouldRenderCard;

  const ErrorCardWidget({
    Key? key,
    required this.message,
    this.shouldRenderCard = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMsg = message ?? 'Failed to load widget';
    return Theme(
      data: _ErrorStyle.theme,
      child: shouldRenderCard
          ? Card(
              child: Padding(
                padding: const EdgeInsets.all(AppPaddingValues.xSmallPadding),
                child: _Content(message: errorMsg),
              ),
            )
          : _Content(message: errorMsg),
    );
  }
}

class _Content extends StatelessWidget {
  final String message;

  const _Content({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

class _ErrorStyle {
  static final theme = ThemeData().copyWith(
    cardTheme: const CardTheme(
      elevation: 0,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        side: BorderSide(
          color: Color(0xFFE0E0E0),
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.red,
      size: 40,
    ),
  );
}
