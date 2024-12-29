import 'package:bottom_navigation_spotlight/bottom_navigation_spotlight.dart';
import 'package:flutter/material.dart';

class BottomNavigationSpotlight extends StatefulWidget {
  final List<MenuItem> menuItems;

  /// Colors
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;

  /// Icon Styles
  final double iconSize;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;

  /// Text Styles
  final double textSize;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  /// Padding and Spacing
  final double padding;
  final EdgeInsetsGeometry? itemPadding;

  /// Gradient and Border
  final Gradient? selectedGradient;
  final Gradient? unselectedGradient;
  final BorderRadius? borderRadius;
  final BorderSide? selectedBorder;
  final BorderSide? unselectedBorder;

  /// Shadow
  final BoxShadow? boxShadow;

  const BottomNavigationSpotlight({
    super.key,
    required this.menuItems,
    this.backgroundColor = Colors.white,
    this.selectedItemColor = Colors.green,
    this.unselectedItemColor = Colors.grey,
    this.iconSize = 24.0,
    this.textSize = 12.0,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.padding = 8.0,
    this.itemPadding,
    this.selectedGradient,
    this.unselectedGradient,
    this.borderRadius,
    this.selectedBorder,
    this.unselectedBorder,
    this.boxShadow,
  });

  @override
  State<BottomNavigationSpotlight> createState() =>
      _BottomNavigationSpotlightState();
}

class _BottomNavigationSpotlightState extends State<BottomNavigationSpotlight> {
  int _selectedIndex = 0;

  bool get hasLabels =>
      widget.menuItems.any((menuItem) => menuItem.label != null);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildMenuItem(MenuItem menu, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: widget.itemPadding ?? EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          gradient: isSelected
              ? widget.selectedGradient ??
                  LinearGradient(
                    colors: [
                      widget.selectedItemColor.withValues(alpha: 0.2),
                      Colors.white
                    ],
                  )
              : widget.unselectedGradient ??
                  LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
          border: Border(
            top: isSelected
                ? widget.selectedBorder ??
                    BorderSide(
                      color: widget.selectedItemColor,
                      width: 2,
                    )
                : widget.unselectedBorder ?? BorderSide.none,
          ),
          boxShadow: widget.boxShadow != null ? [widget.boxShadow!] : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              menu.icon,
              size: widget.iconSize,
              color: isSelected
                  ? widget.selectedIconColor ?? widget.selectedItemColor
                  : widget.unselectedIconColor ?? widget.unselectedItemColor,
            ),
            if (menu.label != null)
              Text(
                menu.label!,
                style: isSelected
                    ? widget.selectedTextStyle ??
                        TextStyle(
                          color: widget.selectedItemColor,
                          fontSize: widget.textSize,
                        )
                    : widget.unselectedTextStyle ??
                        TextStyle(
                          color: widget.unselectedItemColor,
                          fontSize: widget.textSize,
                        ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: widget.menuItems[_selectedIndex].screen,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          boxShadow: widget.boxShadow != null ? [widget.boxShadow!] : [],
        ),
        padding: EdgeInsets.symmetric(vertical: widget.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.menuItems.length,
            (index) => _buildMenuItem(
              widget.menuItems[index],
              index,
            ),
          ),
        ),
      ),
    );
  }
}
