import 'package:bookingcars/MVVM/Models/cars/cars_data_model.dart';
import 'package:bookingcars/MVVM/Models/task/task_model.dart';
import 'package:bookingcars/MVVM/View%20Model/customer_view_model.dart';
import 'package:bookingcars/MVVM/View%20Model/expenses_data_view_model.dart';
import 'package:bookingcars/MVVM/View%20Model/orders_view_model.dart';
import 'package:bookingcars/MVVM/Views/bottom_nav_view.dart';
import 'package:bookingcars/MVVM/Views/cars/add_car_view.dart';
import 'package:bookingcars/MVVM/Views/customer/add_customer_view.dart';
import 'package:bookingcars/MVVM/Views/customer/customer_data_view.dart';
import 'package:bookingcars/MVVM/Views/expenses/add_expenses_view.dart';
import 'package:bookingcars/MVVM/Views/expenses/expenses_data_view.dart';
import 'package:bookingcars/MVVM/Views/orders/add_order_view.dart';
import 'package:bookingcars/MVVM/Views/orders/order_view.dart';
import 'package:bookingcars/MVVM/Views/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'Constants/Colors.dart';
import 'MVVM/View Model/cars_data_view_model.dart';
import 'MVVM/View Model/task_view_model.dart';
import 'MVVM/View Model/user_view_model.dart';
import 'MVVM/Views/Login_View.dart';
import 'MVVM/Views/tasks/add_task_view.dart';
import 'MVVM/Views/cars/cars_data_view.dart';
import 'MVVM/Views/tasks/Tasks_View.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive and Flutter adapters
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");
  // Register Hive adapters and open Hive boxes
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(CarsDataModelAdapter());
  await Hive.openBox<CarsDataModel>('carsBox');
  await Hive.openBox('tasksBox');
  // Initialize user view model and check login status
  final userViewModel = UserViewModel();
  await userViewModel.isLoggedIn();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrdersViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CarsViewModel()),
        ChangeNotifierProvider(create: (_) => ExpensesViewModel()),
        ChangeNotifierProvider(create: (_) => CustomerViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Default is English

  void toggleLanguage() {
    setState(() {
      _locale = _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return MaterialApp(
      locale: _locale,
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
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        canvasColor: MyColors.secondaryColor,
      ),
      home: userViewModel.token.isNotEmpty
          ? BottomNavScreen(toggleLanguage: toggleLanguage)
          : LoginView(toggleLanguage: toggleLanguage),
      routes: {
        '/login': (context) => LoginView(toggleLanguage: toggleLanguage),
        '/tasks': (context) => const TasksView(),
        '/home': (context) => BottomNavScreen(toggleLanguage: toggleLanguage),
        '/cars_data': (context) => const CarsDataView(),
        '/add_task': (context) => const AddTaskView(),
        '/add_car': (context) => const AddCarView(),
        '/orders': (context) => const OrdersView(),
        '/expenses': (context) => const ExpensesDataView(),
        '/settings': (context) => SettingsPage(toggleLanguage: toggleLanguage),
        '/customers': (context) => const CustomerDataView(),
        "/add_customer": (context) => AddCustomerView(),
        "/add_order": (context) => const AddOrderView(),
        "/add_expenses": (context) => const AddExpenseView(),
      },
    );
  }
}
