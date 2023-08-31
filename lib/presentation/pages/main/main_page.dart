import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/global_variables.dart';
import 'package:beliyuk/presentation/blocs/auth/auth_bloc.dart';
import 'package:beliyuk/presentation/blocs/main/main_bloc.dart';
import 'package:beliyuk/presentation/pages/auth/auth_page.dart';
import 'package:beliyuk/presentation/pages/home/home_page.dart';
import 'package:beliyuk/presentation/pages/profile/profile_page.dart';
import 'package:beliyuk/presentation/pages/transaction_history/transaction_history_page.dart';
import 'package:beliyuk/presentation/pages/wishlist/wishlist_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();
    _isLogin = context.read<MainBloc>().state.isLogin;
  }

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: 'Beranda',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Wishlist',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list_alt_rounded),
      label: 'Transaksi',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Akun',
    ),
  ];

  final List<Widget> _listWidget = [
    const HomePage(),
    const WishlistPage(),
    const TransactionHistoryPage(),
    const ProfilePage(),
  ];

  void _onBottomNavTapped(int index) async {
    if (index == 0 || _isLogin) {
      context.read<MainBloc>().add(DoTabChangeEvent(tabIndex: index));
    } else {
      final String? result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AuthPage()),
      );

      if (!mounted) return;

      if (result != null && result == GlobalVariables.successLogin) {
        context.read<MainBloc>().add(DoTabChangeEvent(tabIndex: index));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MainBloc, MainState>(
          listener: (context, state) {
            _isLogin = state.isLogin;
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            context.read<MainBloc>().add(DoIsLoginEvent());
          },
        ),
      ],
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Scaffold(
            body: _listWidget[state.tabIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.tabIndex,
              items: _bottomNavBarItems,
              onTap: _onBottomNavTapped,
            ),
          );
        },
      ),
    );
  }
}
