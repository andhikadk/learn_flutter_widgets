import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
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
            icon: Icon(Icons.analytics),
            label: 'Analytics',
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
