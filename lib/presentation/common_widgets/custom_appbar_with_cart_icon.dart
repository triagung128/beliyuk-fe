import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/bloc/cart/cart_bloc.dart';
import 'package:beliyuk/presentation/pages/cart/cart_page.dart';

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
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              return CustomBadge(totalItems: state.totalItems);
            }

            return const CustomBadge(totalItems: 0);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.totalItems,
  });

  final int totalItems;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 5, end: 8),
      badgeAnimation: const badges.BadgeAnimation.scale(),
      badgeContent: Text(
        '$totalItems',
        style: const TextStyle(color: Colors.white),
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const CartPage();
          }));
        },
        iconSize: 28,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
