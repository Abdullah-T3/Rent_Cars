// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Cars`
  String get cars {
    return Intl.message(
      'Cars',
      name: 'cars',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `User Type`
  String get user_type {
    return Intl.message(
      'User Type',
      name: 'user_type',
      desc: '',
      args: [],
    );
  }

  /// `Project ID`
  String get project_id {
    return Intl.message(
      'Project ID',
      name: 'project_id',
      desc: '',
      args: [],
    );
  }

  /// `Login Error`
  String get login_error {
    return Intl.message(
      'Login Error',
      name: 'login_error',
      desc: '',
      args: [],
    );
  }

  /// `Register Error`
  String get register_error {
    return Intl.message(
      'Register Error',
      name: 'register_error',
      desc: '',
      args: [],
    );
  }

  /// `Register Success`
  String get register_success {
    return Intl.message(
      'Register Success',
      name: 'register_success',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get Tasks {
    return Intl.message(
      'Tasks',
      name: 'Tasks',
      desc: '',
      args: [],
    );
  }

  /// `Add Task`
  String get AddTask {
    return Intl.message(
      'Add Task',
      name: 'AddTask',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Cars`
  String get WelcomeMassage {
    return Intl.message(
      'Welcome to Cars',
      name: 'WelcomeMassage',
      desc: '',
      args: [],
    );
  }

  /// `Plate Number`
  String get plate_number {
    return Intl.message(
      'Plate Number',
      name: 'plate_number',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get model {
    return Intl.message(
      'Model',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// `Year of Manufacture`
  String get year_of_manufacture {
    return Intl.message(
      'Year of Manufacture',
      name: 'year_of_manufacture',
      desc: '',
      args: [],
    );
  }

  /// `Odometer Reading`
  String get odometer_reading {
    return Intl.message(
      'Odometer Reading',
      name: 'odometer_reading',
      desc: '',
      args: [],
    );
  }

  /// `Next Oil Change`
  String get next_oil_change {
    return Intl.message(
      'Next Oil Change',
      name: 'next_oil_change',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Rental Amount`
  String get rental_amount {
    return Intl.message(
      'Rental Amount',
      name: 'rental_amount',
      desc: '',
      args: [],
    );
  }

  /// `Rental Date`
  String get rental_date {
    return Intl.message(
      'Rental Date',
      name: 'rental_date',
      desc: '',
      args: [],
    );
  }

  /// `Return Date`
  String get return_date {
    return Intl.message(
      'Return Date',
      name: 'return_date',
      desc: '',
      args: [],
    );
  }

  /// `Customer Name`
  String get customer_name {
    return Intl.message(
      'Customer Name',
      name: 'customer_name',
      desc: '',
      args: [],
    );
  }

  /// `Rental Date`
  String get booking_date {
    return Intl.message(
      'Rental Date',
      name: 'booking_date',
      desc: '',
      args: [],
    );
  }

  /// `Pickup Date`
  String get pickup_date {
    return Intl.message(
      'Pickup Date',
      name: 'pickup_date',
      desc: '',
      args: [],
    );
  }

  /// `Customer ID`
  String get customer_id {
    return Intl.message(
      'Customer ID',
      name: 'customer_id',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Rental Days`
  String get rental_days {
    return Intl.message(
      'Rental Days',
      name: 'rental_days',
      desc: '',
      args: [],
    );
  }

  /// `Rental Kilometers`
  String get rental_kilometers {
    return Intl.message(
      'Rental Kilometers',
      name: 'rental_kilometers',
      desc: '',
      args: [],
    );
  }

  /// `Active Order`
  String get active_order {
    return Intl.message(
      'Active Order',
      name: 'active_order',
      desc: '',
      args: [],
    );
  }

  /// `Expired Order`
  String get expired_order {
    return Intl.message(
      'Expired Order',
      name: 'expired_order',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Password`
  String get please_enter_your_password {
    return Intl.message(
      'Please Enter Your Password',
      name: 'please_enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Username`
  String get please_enter_your_username {
    return Intl.message(
      'Please Enter Your Username',
      name: 'please_enter_your_username',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email`
  String get please_enter_your_email {
    return Intl.message(
      'Please Enter Your Email',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Name`
  String get please_enter_your_name {
    return Intl.message(
      'Please Enter Your Name',
      name: 'please_enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Phone`
  String get please_enter_your_phone {
    return Intl.message(
      'Please Enter Your Phone',
      name: 'please_enter_your_phone',
      desc: '',
      args: [],
    );
  }

  /// `Continue to login`
  String get Continue_to_login {
    return Intl.message(
      'Continue to login',
      name: 'Continue_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username or password`
  String get Invalid_username_or_password {
    return Intl.message(
      'Invalid username or password',
      name: 'Invalid_username_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Switch to Arabic`
  String get Switch_to_Arabic {
    return Intl.message(
      'Switch to Arabic',
      name: 'Switch_to_Arabic',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Settings Page`
  String get Settings_Page {
    return Intl.message(
      'Settings Page',
      name: 'Settings_Page',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Customer Mobile`
  String get customer_mobile {
    return Intl.message(
      'Customer Mobile',
      name: 'customer_mobile',
      desc: '',
      args: [],
    );
  }

  /// `Car License Plate`
  String get car_license_plate {
    return Intl.message(
      'Car License Plate',
      name: 'car_license_plate',
      desc: '',
      args: [],
    );
  }

  /// `Car Name`
  String get car_name {
    return Intl.message(
      'Car Name',
      name: 'car_name',
      desc: '',
      args: [],
    );
  }

  /// `Add Car`
  String get add_car {
    return Intl.message(
      'Add Car',
      name: 'add_car',
      desc: '',
      args: [],
    );
  }

  /// `Car added successfully`
  String get car_added_successfully {
    return Intl.message(
      'Car added successfully',
      name: 'car_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Car updated successfully`
  String get car_updated_successfully {
    return Intl.message(
      'Car updated successfully',
      name: 'car_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Car deleted successfully`
  String get car_deleted_successfully {
    return Intl.message(
      'Car deleted successfully',
      name: 'car_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Car not found`
  String get car_not_found {
    return Intl.message(
      'Car not found',
      name: 'car_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Car not deleted`
  String get car_not_deleted {
    return Intl.message(
      'Car not deleted',
      name: 'car_not_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Add Order`
  String get add_order {
    return Intl.message(
      'Add Order',
      name: 'add_order',
      desc: '',
      args: [],
    );
  }

  /// `Order added successfully`
  String get order_added_successfully {
    return Intl.message(
      'Order added successfully',
      name: 'order_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Order updated successfully`
  String get order_updated_successfully {
    return Intl.message(
      'Order updated successfully',
      name: 'order_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Order deleted successfully`
  String get order_deleted_successfully {
    return Intl.message(
      'Order deleted successfully',
      name: 'order_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Order not found`
  String get order_not_found {
    return Intl.message(
      'Order not found',
      name: 'order_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Order not deleted`
  String get order_not_deleted {
    return Intl.message(
      'Order not deleted',
      name: 'order_not_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
