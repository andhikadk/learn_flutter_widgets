import 'package:flutter/material.dart';
import 'package:learn_flutter_widgets/pages/account_page.dart';
import 'package:learn_flutter_widgets/pages/analytics_page.dart';
import 'package:learn_flutter_widgets/pages/home_page.dart';
import 'package:learn_flutter_widgets/components/bottom_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() {
            _selectedPage = index;
          }),
          children: const [
            HomePage(),
            AnalyticsPage(),
            AccountPage(),
          ],
        ),
        bottomNavigationBar: BottomNavbar(
          selectedPage: _selectedPage,
          pageController: _pageController,
        ),
      ),
    );
  }
}
