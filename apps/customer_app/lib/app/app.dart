import 'package:criminal_brushes/app/router.dart';
import 'package:criminal_brushes/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CriminalBrushesApp extends StatelessWidget {
  const CriminalBrushesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Criminal Brushes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
