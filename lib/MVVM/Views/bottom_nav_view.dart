import 'package:bookingcars/MVVM/Views/cars/add_car_view.dart';
import 'package:bookingcars/MVVM/Views/orders/add_order_view.dart';
import 'package:bookingcars/MVVM/Views/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);
class BottomNavScreen extends StatefulWidget {
  final VoidCallback toggleLanguage; // Accept the toggleLanguage function

  const BottomNavScreen({super.key, required this.toggleLanguage});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const AddCarView(),
       const AddOrderView(),
      SettingsPage(toggleLanguage: widget.toggleLanguage), // Pass the function to SettingsPage
    ];

    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: BottomNavigationBar(
            onTap: updateCurrentIndex,
            currentIndex: currentSelectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/car_icon.svg",
                  colorFilter: const ColorFilter.mode(
                    inActiveIconColor,
                    BlendMode.srcIn,
                  ),
                  width: 30,
                  height: 30,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/images/car_icon.svg",
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFFF7643),
                    BlendMode.srcIn,
                  ),
                  width: 30,
                  height: 30,
                ),
                label: "Fav",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/add.svg",
                  colorFilter: const ColorFilter.mode(
                    inActiveIconColor,
                    BlendMode.srcIn,
                  ),
                  width: 30,
                  height: 30,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/images/add.svg",
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFFF7643),
                    BlendMode.srcIn,
                  ),
                  width: 30,
                  height: 30,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/settings.svg",
                  colorFilter: const ColorFilter.mode(
                    inActiveIconColor,
                    BlendMode.srcIn,
                  ),
                  width: 30,
                  height: 30,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/images/settings.svg",
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFFF7643),
                    BlendMode.srcIn,
                  ),
                  width: 30,
                  height: 30,
                ),
                label: "settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
