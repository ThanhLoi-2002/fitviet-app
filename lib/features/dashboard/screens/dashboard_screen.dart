import 'package:fitness_client/features/dashboard/screens/favorite_screen.dart';
import 'package:fitness_client/features/dashboard/screens/home_screen.dart';
import 'package:fitness_client/features/dashboard/screens/inbox_screen.dart';
import 'package:fitness_client/features/dashboard/screens/setting_screen.dart';
import 'package:fitness_client/features/dashboard/widgets/bottom_nav_item_widget.dart';
import 'package:fitness_client/util/images.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.pageIndex});
  final int pageIndex;
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageIndex.clamp(0, _pages.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    const FavoriteScreen(),
    const _NavPlaceholder(title: 'Thẻ của tôi'),
    const InboxScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: PageView(controller: _pageController, physics: const NeverScrollableScrollPhysics(), children: _pages)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: NavigationBar(
          height: 65,
          selectedIndex: _currentIndex,
          destinations: <BottomNavItemWidget>[
            BottomNavItemWidget(icon: Images.search, isSelected: _currentIndex == 0, onTap: () => _setPage(0)),
            BottomNavItemWidget(icon: Images.favorite, isSelected: _currentIndex == 1, onTap: () => _setPage(1)),
            BottomNavItemWidget(icon: Images.card, isSelected: _currentIndex == 2, onTap: () => _setPage(2)),
            BottomNavItemWidget(icon: Images.chat, isSelected: _currentIndex == 3, onTap: () => _setPage(3)),
            BottomNavItemWidget(icon: Images.profile, isSelected: _currentIndex == 4, onTap: () => _setPage(4)),
          ],
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _currentIndex = pageIndex;
    });
  }
}

class _NavPlaceholder extends StatelessWidget {
  const _NavPlaceholder({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
