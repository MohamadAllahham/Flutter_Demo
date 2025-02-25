import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class TextStylesStory extends StatelessWidget {
  const TextStylesStory({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.knobs.string(label: 'text');
    final textTheme = Theme.of(context).textTheme;
    final textStyles = {
      'displaySmall': textTheme.displaySmall,
      'headlineLarge': textTheme.headlineLarge,
      'headlineMedium': textTheme.headlineMedium,
      'headlineSmall': textTheme.headlineSmall,
      'titleLarge': textTheme.titleLarge,
      'titleMedium': textTheme.titleMedium,
      'titleSmall': textTheme.titleSmall,
      'bodyLarge': textTheme.bodyLarge,
      'bodyMedium': textTheme.bodyMedium,
      'bodySmall': textTheme.bodySmall,
      'labelLarge': textTheme.labelLarge,
      'labelMedium': textTheme.labelMedium,
      'labelSmall': textTheme.labelSmall,
    };

    return ListView(
      children: [
        for (var styleKey in textStyles.keys)
          Text(
            '$text ($styleKey)',
            style: textStyles[styleKey],
          ),
      ],
    );
  }
}
