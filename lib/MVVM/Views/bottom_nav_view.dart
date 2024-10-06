import 'package:bookingcars/MVVM/Views/orders/rental_view.dart';
import 'package:bookingcars/MVVM/Views/tasks/Tasks_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

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

  final pages = [
    const TasksView(),
    const OrdersDataView(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
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
                  "assets/images/task.svg",
                  colorFilter: const ColorFilter.mode(
                    inActiveIconColor,
                    BlendMode.srcIn,
                  ),
                  width: 30,
                  height: 30,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/images/task.svg",
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

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Settings Page"),
    );
  }
}
