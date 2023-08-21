import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/global_variables.dart';
import 'package:beliyuk/presentation/blocs/auth/auth_bloc.dart';
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
  String? _token;

  int _bottomNavIndex = 0;

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
    if (index == 0 || _token != null) {
      setState(() => _bottomNavIndex = index);
    } else {
      final String? result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AuthPage()),
      );

      if (!mounted) return;

      if (result != null && result == GlobalVariables.successLogin) {
        setState(() => _bottomNavIndex = index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.user != null) {
          _token = state.user!.token;
        } else {
          _token = null;
        }
      },
      child: Scaffold(
        body: _listWidget[_bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _bottomNavIndex,
          items: _bottomNavBarItems,
          onTap: _onBottomNavTapped,
        ),
      ),
    );
  }
}
