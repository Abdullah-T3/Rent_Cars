import 'package:bookingcars/MVVM/Views/HomePage_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants/Colors.dart';
import 'MVVM/View%20Model/cars_data_view_model.dart';
import 'MVVM/View%20Model/task_view_model.dart';
import 'MVVM/View%20Model/user_view_model.dart';
import 'MVVM/Views/Login_View.dart';
import 'MVVM/Views/add_task_view.dart';
import 'MVVM/Views/cars_data_view.dart';
import 'MVVM/Views/Tasks_View.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  final userViewModel = UserViewModel();
  await userViewModel.isLoggedIn(); // Check if user is logged in
await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CarsViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: MyColors.bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: MyColors.secondaryColor,
      ),
      home: userViewModel.token.isNotEmpty
          ? const HomePageView()
          : const LoginView(),
      routes: {
        '/login': (context) => const LoginView(),
        '/tasks': (context) => const TasksView(),
        '/home': (context) => const HomePageView(),
        '/cars_data': (context) => CarsDataView(),
        '/add_task': (context) => const AddTaskView(),
      },
    );
  }
}
