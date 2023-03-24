import 'package:flutter/material.dart';
import 'package:tic_tac_toe/design_system/color/ds_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Icon? icon;
  final String? title;
  final VoidCallback? onTap;

  const AppBarWidget({
    super.key,
    this.backgroundColor,
    this.icon,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: onTap,
          child: Center(
            child: SizedBox(
              height: 16,
              width: 16,
              child: icon,
            ),
          ),
        ),
        title: Text(
          title!,
          style: const TextStyle(
            color: DSColors.white100,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
