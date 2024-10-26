// ignore: file_names
import 'package:bookingcars/Responsive/enums/DeviceType.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Colors.dart';
import '../MVVM/View%20Model/user_view_model.dart';
import '../Responsive/UiComponanets/InfoWidget.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  Widget buildDrawerHeader(context) {
    return Infowidget(builder: (context, deviceInfo) {
      return Column(
        children: [
          Container(
            padding: deviceInfo.deviceType == DeviceType.mobile ||
                    deviceInfo.deviceType == DeviceType.tablet
                ? EdgeInsetsDirectional.fromSTEB(
                    deviceInfo.screenWidth * 0.03,
                    deviceInfo.screenHeight * 0.01,
                    deviceInfo.screenWidth * 0.03,
                    deviceInfo.screenHeight * 0.01)
                : EdgeInsetsDirectional.fromSTEB(
                    deviceInfo.screenWidth * 0.03,
                    deviceInfo.screenHeight * 0.01,
                    deviceInfo.screenWidth * 0.03,
                    deviceInfo.screenHeight * 0.01),
            child: Image.asset(
              "assets/images/car_logo.gif",
            ),
          ),
        ],
      );
    });
  }

  Widget buildDrawerListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? triling,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? Colors.blue,
      ),
      title: Text(title),
      trailing: triling ??
          const Icon(
            Icons.arrow_right,
            color: Colors.blue,
          ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemDivider() {
    return const Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userView = Provider.of<UserViewModel>(context);
    return Infowidget(builder: (context, deviceInfo) {
      return Drawer(
          backgroundColor: MyColors.bgColor,
          child: ListView(
            children: [
              SizedBox(
                height: deviceInfo.orientation == Orientation.portrait
                    ? deviceInfo.screenHeight * 0.2
                    : deviceInfo.screenHeight * 0.4,
                child: DrawerHeader(
                  child: buildDrawerHeader(context),
                ),
              ),
              buildDrawerListItem(
                  title: S.of(context).Expenses,
                  leadingIcon: Icons.history,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/expenses');
                  }),
              buildDrawerListItemDivider(),
              buildDrawerListItem(
                  title: S.of(context).cars,
                  leadingIcon: Icons.car_rental,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/cars_data');
                  }),
              buildDrawerListItemDivider(),
              buildDrawerListItem(
                  title: S.of(context).Tasks,
                  leadingIcon: Icons.task_alt,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/tasks');
                  }),
              buildDrawerListItemDivider(),
              buildDrawerListItem(
                  title: S.of(context).orders,
                  leadingIcon: Icons.bar_chart,
                  onTap: () {
                    Navigator.of(context).pushNamed('/orders');
                  }),
              buildDrawerListItemDivider(),
              buildDrawerListItem(
                  title: S.of(context).customers,
                  leadingIcon: Icons.person,
                  onTap: () {
                    Navigator.of(context).pushNamed('/customers');
                  }),
              buildDrawerListItemDivider(),
              buildDrawerListItem(
                  title: S.of(context).Settings, leadingIcon: Icons.settings, onTap: () {
                Navigator.of(context).pushNamed('/settings');
                  }),
              buildDrawerListItemDivider(),
              buildDrawerListItem(
                  title: S.of(context).logout,
                  leadingIcon: Icons.logout,
                  onTap: () async {
                    await userView.logout();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  triling: const Icon(Icons.arrow_right),
                  color: Colors.red),
            ],
          ));
    });
  }
}
