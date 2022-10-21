import 'package:flutter/material.dart';
import 'package:worka/redesigns/employer/re_notification.dart';
import 'package:worka/redesigns/employer/redesign_home_page.dart';
import '../phoenix/dashboard_work/inbox_screen.dart';
import 'EmployerDashboard.dart';

class EmployerNav extends StatefulWidget {
  const EmployerNav({Key? key}) : super(key: key);

  // const MainNav({Key? key, required this.user}) : super(key: key);
  // final UserModel user;

  @override
  _EmployerNavState createState() => _EmployerNavState();
}

class _EmployerNavState extends State<EmployerNav> {
  int _selectedIndex = 0;

  void NavigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    EmployerDashboard(),
    ReHomePage(),
    InboxScreen(),
    ReNotification(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: NavigateBottomBar,
            selectedItemColor: const Color(0xff0039A5),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Jobs'),
              BottomNavigationBarItem(icon: Icon(Icons.mail_lock_outlined), label: 'Inbox'),
              BottomNavigationBarItem(icon: Icon(Icons.add_alert), label: 'Alerts')
            ]),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
