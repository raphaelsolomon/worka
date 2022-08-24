import 'package:flutter/material.dart';
import '../phoenix/dashboard_work/inbox_screen.dart';
import 'EmployerDashboard.dart';
import 'EmployerPostJob.dart';
import 'phoenix/screens/alertList.dart';

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
    EmployerPostJob(),
    InboxScreen(),
    EmployerAlertPage(),
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
              BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Post Jobs'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mail_outline), label: 'Inbox'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_alert), label: 'Alerts')
            ]),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
