import 'package:flutter/material.dart';
import 'package:learn_flutter_widgets/pages/account_page.dart';
import 'package:learn_flutter_widgets/pages/history_page.dart';
import 'package:learn_flutter_widgets/pages/home_page.dart';

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
            HistoryPage(),
            AccountPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedPage: _selectedPage,
          pageController: _pageController,
        ),
      ),
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    super.key,
    required int selectedPage,
    required PageController pageController,
  })  : _selectedPage = selectedPage,
        _pageController = pageController;

  final int _selectedPage;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Theme.of(context).colorScheme.primary,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(
              color: Colors.white,
            );
          }
          return IconThemeData(
            color: Theme.of(context).colorScheme.primary,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: _selectedPage,
        onDestinationSelected: (index) {
          _pageController.jumpToPage(
            index,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
