import 'package:flutter/material.dart';

/// Represents a single menu item in the navigation bar.
class MenuItem {
  final IconData icon;
  final String? label;
  final Widget screen;

  MenuItem({
    required this.icon,
    required this.screen,
    this.label,
  });
}
