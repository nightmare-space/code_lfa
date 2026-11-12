import 'dart:ui';

/// Minimal replacement for the screen-adaptation `num.w` extension.
///
/// The upstream project uses `8.w`-style values in terminal_page.dart, but no
/// package in the dependency graph provides that extension any more (the old
/// `ScreenAdapter`/`ViewMetric` adaptor is never initialized in this app).
/// With no adaptor, ViewMetric's scale would be 1.0, so `w` maps 1:1 to
/// logical pixels — which is exactly what this extension returns.
extension ScreenWExt on num {
  double get w => toDouble();
}
