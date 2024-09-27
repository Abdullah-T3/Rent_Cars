import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Colors.dart';
import '../MVVM/View%20Model/user_view_model.dart';
import '../Responsive/UiComponanets/InfoWidget.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  Widget buildDrawerHeader(context) {
    return Infowidget(
        
        builder: (context, deviceInfo) {
      return Column(
        children: [
          Container(
            padding:  EdgeInsetsDirectional.fromSTEB(deviceInfo.screenWidth * 0.05, deviceInfo.screenHeight * 0.02, deviceInfo.screenWidth * 0.05, deviceInfo.screenHeight * 0.02),
      
            child: Image.asset("assets/images/car_logo.gif",),
          ),
      
        ],
      );    
        }
      
    );
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
return Infowidget(
  builder: (context, deviceInfo) {
      return Drawer(
    backgroundColor:MyColors.bgColor,
  
    child: ListView(
      children: [
        SizedBox(
          height:deviceInfo.orientation == Orientation.portrait ? deviceInfo.screenHeight * 0.2 : deviceInfo.screenHeight * 0.4,
          child: DrawerHeader(
            child: 
          buildDrawerHeader(context),),
          
        ),

        buildDrawerListItem( title: "Transactions", leadingIcon: Icons.history, onTap: () {}),
        buildDrawerListItemDivider(),
        buildDrawerListItem( title: "Cars List", leadingIcon: Icons.car_rental, onTap: () {
          Navigator.of(context).pushReplacementNamed('/cars_data');
        }),

        buildDrawerListItemDivider(),

        buildDrawerListItem(title: "Report", leadingIcon: Icons.bar_chart, onTap: () {}),
        buildDrawerListItemDivider(),
        buildDrawerListItem( title: "Settings", leadingIcon: Icons.settings, onTap: () {}),
        buildDrawerListItemDivider(),
        buildDrawerListItem( title: "Logout", leadingIcon: Icons.logout, onTap: () async{
          await userView.logout();
          Navigator.of(context).pushReplacementNamed('/login');
        },triling: const Icon(Icons.arrow_right),color: Colors.red),
      ],
    )
  
  );
  }

);

  }}