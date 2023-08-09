import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class CustomAppBarWithCartIcon extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithCartIcon({
    super.key,
    this.automaticallyImplyLeading = true,
    this.centerTitle = false,
    this.title,
  });

  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      elevation: 0,
      title: title,
      actions: [
        badges.Badge(
          position: badges.BadgePosition.topEnd(top: 5, end: 8),
          badgeContent: const Text(
            '99',
            style: TextStyle(color: Colors.white),
          ),
          // stackFit: StackFit.passthrough,
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.red,
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: IconButton(
            onPressed: () {},
            iconSize: 28,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
