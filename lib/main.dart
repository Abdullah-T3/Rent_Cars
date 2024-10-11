import 'package:bookingcars/MVVM/Models/cars_data_model.dart';
import 'package:bookingcars/MVVM/Models/task_model.dart';
import 'package:bookingcars/MVVM/View%20Model/orders_view_model.dart';
import 'package:bookingcars/MVVM/Views/bottom_nav_view.dart';
import 'package:bookingcars/MVVM/Views/orders/order_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants/Colors.dart';
import 'MVVM/View Model/cars_data_view_model.dart';
import 'MVVM/View Model/task_view_model.dart';
import 'MVVM/View Model/user_view_model.dart';
import 'MVVM/Views/Login_View.dart';
import 'MVVM/Views/tasks/add_task_view.dart';
import 'MVVM/Views/cars_data_view.dart';
import 'MVVM/Views/tasks/Tasks_View.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences
  await SharedPreferences.getInstance();

  // Initialize Hive and Flutter adapter
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(CarsDataModelAdapter());

  // Open Hive boxes
  await Hive.openBox<CarsDataModel>('carsBox');
  await Hive.openBox('tasksBox');
  // Load environment variables
  await dotenv.load(fileName: ".env");
  // Create user view model and check login status
  final userViewModel = UserViewModel();
  await userViewModel.isLoggedIn();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OrdersViewModel(),
        ),
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
      child: DevicePreview(
       enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
       ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Locale state
  Locale _locale = const Locale('en'); // Default is English
  
  // Function to toggle language
  void toggleLanguage() {
    setState(() {
      if (_locale.languageCode == 'en') {
        _locale = const Locale('ar');
      } else {
        _locale = const Locale('en');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return MaterialApp(
      locale: _locale, // Use the _locale variable
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: MyColors.bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: MyColors.secondaryColor,
      ),
      home: userViewModel.token.isNotEmpty
          ? BottomNavScreen(
              toggleLanguage:
                  toggleLanguage) // Pass the toggleLanguage function
          : LoginView(toggleLanguage: toggleLanguage),
      routes: {
        '/login': (context) => LoginView(toggleLanguage: toggleLanguage),
        '/tasks': (context) => const TasksView(),
        '/home': (context) =>
            BottomNavScreen(toggleLanguage: toggleLanguage), // Pass here too
        '/cars_data': (context) => const CarsDataView(),
        '/add_task': (context) => const AddTaskView(),
        '/orders': (context) => OrdersView(),
      },
    );
  }
}
