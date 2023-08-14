import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/auth/auth_bloc.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/auth/auth_page.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/home_page.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/profile/profile_page.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/transaction_history/transaction_history_page.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/wishlist/wishlist_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(DoAuthCheckEvent());
  }

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
    const HomePage(
      key: PageStorageKey('mainHomePage'),
    ),
    const WishlistPage(),
    const TransactionHistoryPage(),
    const ProfilePage(),
  ];

  void _onBottomNavTapped(int index) async {
    if (index != 0) {
      if (_token == null) {
        final String result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AuthPage()),
        );

        if (!mounted) return;

        if (result == GlobalVariables.successLogin) {
          setState(() => _bottomNavIndex = index);
        }
      } else {
        setState(() => _bottomNavIndex = index);
      }
    } else {
      setState(() => _bottomNavIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        _token = state.token;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _bottomNavIndex,
          children: _listWidget,
        ),
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
