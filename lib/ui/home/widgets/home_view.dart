import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/ui/home/constants/constant.dart';
import 'package:movies_app/ui/home/widgets/movies_list_screen.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int tabIndex = 0;

  final List<BottomNavigationBarItem> navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.laptop_mac), label: 'Latest'),
    BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Popular'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _body(),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _body() {
    return IndexedStack(
      index: tabIndex,
      children: [
        MoviesListScreen(Constant.latest),
        MoviesListScreen(Constant.popular),
      ],
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
        items: navItems,
        currentIndex: tabIndex,
        onTap: (index) {
          setState(() {
            tabIndex = index;
            if (index == 0) {
              ref.read(categoryProvider.notifier).state = Constant.latest;
            } else {
              ref.read(categoryProvider.notifier).state = Constant.popular;
            }
          });
        });
  }
}

///provider for the selected category bottom nav tab
final categoryProvider = StateProvider((ref) => Constant.latest);
