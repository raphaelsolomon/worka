import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worka/phoenix/dashboard_work/inbox_screen.dart';
import 'package:worka/screens/main_screens/alert_page.dart';
import 'package:worka/screens/main_screens/home_page.dart';
import 'package:worka/screens/see_more/see_more.dart';

import '../../phoenix/Controller.dart';

class MainNav extends StatefulWidget {
  const MainNav({Key? key}) : super(key: key);

  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _selectedIndex = 0;

  void _NavigateBottomBar(int index) {
    setState(() {
      if (index == 0) {
        if (context.read<Controller>().homePage > 0) {
          context.read<Controller>().setHomePage(0);
        }
        _selectedIndex = index;
        return;
      }
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    SeeMore(),
    InboxScreen(),
    AlertPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _NavigateBottomBar,
            selectedItemColor: const Color(0xff0039A5),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
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
