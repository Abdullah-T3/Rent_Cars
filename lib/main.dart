import 'package:bookingcars/MVVM/Models/cars_data_model.dart';
import 'package:bookingcars/MVVM/Views/HomePage_View.dart';
import 'package:bookingcars/MVVM/Views/tasks/edit_task.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants/Colors.dart';
import 'MVVM/View%20Model/cars_data_view_model.dart';
import 'MVVM/View%20Model/task_view_model.dart';
import 'MVVM/View%20Model/user_view_model.dart';
import 'MVVM/Views/Login_View.dart';
import 'MVVM/Views/tasks/add_task_view.dart';
import 'MVVM/Views/cars_data_view.dart';
import 'MVVM/Views/tasks/Tasks_View.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  final userViewModel = UserViewModel();
   // Check if user is logged in
  await userViewModel.isLoggedIn();
    // Initialize Hive and Flutter adapter
  await Hive.initFlutter();
  // Register the CarsDataModel adapter
  Hive.registerAdapter(CarsDataModelAdapter());
  // Open the box (storage) for cars
  await Hive.openBox<CarsDataModel>('carsBox');
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
      child:   DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return MaterialApp(
      builder: DevicePreview.appBuilder,
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
        '/Edit_task' : (context) => const EditTask(),
        '/tasks': (context) => const TasksView(),
        '/home': (context) => const HomePageView(),
        '/cars_data': (context) => CarsDataView(),
        '/add_task': (context) => const AddTaskView(),
      },
    );
  }
}
