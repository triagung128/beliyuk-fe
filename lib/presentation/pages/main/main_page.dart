import 'package:flutter/material.dart';

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

  void _onBottomNavTapped(int index) {
    setState(() => _bottomNavIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
