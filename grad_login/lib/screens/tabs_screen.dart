import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_login/providers/cartProvider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import 'profile_screen.dart';
import 'home_screen.dart';
import 'interaction_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = 'tabs-screen';
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _pages = [];

  @override
  void initState() {
    _pages = [
      {
        'page': const HomeScreen(),
        'title': 'Home',
      },
      {
        'page': const InteractionScreen(),
        'title': 'Interactions',
      },
      {
        'page': const CartScreen(),
        'title': 'Cart',
      },
      {
        'page': const Profiles(),
        'title': 'Settings',
      },
    ];

    Future.delayed(Duration.zero)
        .then((_) => Provider.of<Cart>(context, listen: false).fetchCart());
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: SizedBox(
        height: mediaQuery.height * 0.083,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          backgroundColor: const Color.fromARGB(255, 235, 233, 236),
          selectedFontSize: mediaQuery.width * 0.035,
          unselectedFontSize: mediaQuery.width * 0.035,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Roboto-Medium',
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Roboto-Medium',
            fontWeight: FontWeight.w600,
          ),
          unselectedItemColor: const Color.fromARGB(255, 116, 114, 119),
          selectedItemColor: Colors.black,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: _selectedPageIndex == 0
                  ? Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 216, 219),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: mediaQuery.width * 0.18,
                      height: mediaQuery.height * 0.04,
                      child: const Icon(
                        Icons.home_outlined,
                        size: 26,
                      ),
                    )
                  : const Icon(
                      Icons.home_outlined,
                      size: 26,
                    ),
              label: appLocalization.home,
            ),
            BottomNavigationBarItem(
              icon: _selectedPageIndex == 1
                  ? Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 216, 219),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: mediaQuery.width * 0.18,
                      height: mediaQuery.height * 0.04,
                      child: SvgPicture.asset(
                        'assets/icons/pills-interaction.svg',
                      ),
                    )
                  : SvgPicture.asset(
                      'assets/icons/pills-interaction.svg',
                      width: 26,
                      height: 26,
                      color: const Color(0xFF615F63),
                    ),
              label: appLocalization.interactions,
            ),
            BottomNavigationBarItem(
              icon: _selectedPageIndex == 2
                  ? Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 216, 219),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: mediaQuery.width * 0.18,
                      height: mediaQuery.height * 0.04,
                      child: const Icon(
                        MdiIcons.cartOutline,
                        size: 26,
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: const Icon(
                        MdiIcons.cartOutline,
                        size: 26,
                      ),
                    ),
              label: appLocalization.cart,
            ),
            BottomNavigationBarItem(
              icon: _selectedPageIndex == 3
                  ? Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 216, 219),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: mediaQuery.width * 0.18,
                      height: mediaQuery.height * 0.04,
                      child: SvgPicture.asset(
                        'assets/icons/settings-outlined.svg',
                        height: 200,
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: SvgPicture.asset(
                        'assets/icons/settings-outlined.svg',
                        width: 26,
                        height: 26,
                        color: const Color(0xFF615F63),
                      ),
                    ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
