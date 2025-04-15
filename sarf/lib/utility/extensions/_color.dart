part of 'extensions_lib.dart';

extension ThemeColors on BuildContext {
  //Primary
  Color get primary => Theme.of(this).colorScheme.primary;
  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;
  Color get primaryFixed => Theme.of(this).colorScheme.primaryFixed;
  Color get primaryFixedDim => Theme.of(this).colorScheme.primaryFixedDim;
  Color get inversePrimary => Theme.of(this).colorScheme.inversePrimary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get onPrimaryContainer => Theme.of(this).colorScheme.onPrimaryContainer;
  Color get onPrimaryFixed => Theme.of(this).colorScheme.onPrimaryFixed;
  Color get onPrimaryFixedVariant =>
      Theme.of(this).colorScheme.onPrimaryFixedVariant;

  //Secondary
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;
  Color get secondaryFixed => Theme.of(this).colorScheme.secondaryFixed;
  Color get secondaryFixedDim => Theme.of(this).colorScheme.secondaryFixedDim;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get onSecondaryContainer =>
      Theme.of(this).colorScheme.onSecondaryContainer;
  Color get onSecondaryFixed => Theme.of(this).colorScheme.onSecondaryFixed;
  Color get onSecondaryFixedVariant =>
      Theme.of(this).colorScheme.onSecondaryFixedVariant;

  //Surface
  Color get surface => Theme.of(this).colorScheme.surface;
  Color get surfaceBright => Theme.of(this).colorScheme.surfaceBright;
  Color get surfaceContainer => Theme.of(this).colorScheme.surfaceContainer;
  Color get surfaceContainerHigh =>
      Theme.of(this).colorScheme.surfaceContainerHigh;
  Color get surfaceContainerHighest =>
      Theme.of(this).colorScheme.surfaceContainerHighest;
  Color get surfaceContainerLow =>
      Theme.of(this).colorScheme.surfaceContainerLow;
  Color get surfaceContainerLowest =>
      Theme.of(this).colorScheme.surfaceContainerLowest;
  Color get surfaceDim => Theme.of(this).colorScheme.surfaceDim;
  Color get surfaceTint => Theme.of(this).colorScheme.surfaceTint;
  Color get inverseSurface => Theme.of(this).colorScheme.inverseSurface;

  Color get onSurface => Theme.of(this).colorScheme.onSurface;
  Color get onSurfaceVariant => Theme.of(this).colorScheme.onSurfaceVariant;
  Color get onInverseSurface => Theme.of(this).colorScheme.onInverseSurface;

  //Error
  Color get error => Theme.of(this).colorScheme.error;
  Color get errorContainer => Theme.of(this).colorScheme.errorContainer;

  Color get onError => Theme.of(this).colorScheme.onError;
  Color get onErrorContainer => Theme.of(this).colorScheme.onErrorContainer;

  //Tertiary
  Color get tertiary => Theme.of(this).colorScheme.tertiary;
  Color get tertiaryContainer => Theme.of(this).colorScheme.tertiaryContainer;
  Color get tertiaryFixed => Theme.of(this).colorScheme.tertiaryFixed;
  Color get tertiaryFixedDim => Theme.of(this).colorScheme.tertiaryFixedDim;

  Color get onTertiary => Theme.of(this).colorScheme.onTertiary;
  Color get onTertiaryContainer =>
      Theme.of(this).colorScheme.onTertiaryContainer;
  Color get onTertiaryFixed => Theme.of(this).colorScheme.onTertiaryFixed;
  Color get onTertiaryFixedVariant =>
      Theme.of(this).colorScheme.onTertiaryFixedVariant;

  //Outline
  Color get outline => Theme.of(this).colorScheme.outline;
  Color get outlineVariant => Theme.of(this).colorScheme.outlineVariant;

  //Shadow
  Color get shadow => Theme.of(this).colorScheme.shadow;
}
