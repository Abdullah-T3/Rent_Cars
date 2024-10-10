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

  /// ` Password`
  String get password {
    return Intl.message(
      ' Password',
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

  /// ` Welcome to Cars`
  String get WelcomeMassage {
    return Intl.message(
      ' Welcome to Cars',
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

  // skipped getter for the 'year of manufacture' key

  // skipped getter for the 'odometer reading' key

  // skipped getter for the 'next oil change' key

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

  /// ` Customer Name`
  String get customer_name {
    return Intl.message(
      ' Customer Name',
      name: 'customer_name',
      desc: '',
      args: [],
    );
  }

  /// ` Rental Date`
  String get booking_date {
    return Intl.message(
      ' Rental Date',
      name: 'booking_date',
      desc: '',
      args: [],
    );
  }

  /// ` Pickup Date`
  String get pickup_date {
    return Intl.message(
      ' Pickup Date',
      name: 'pickup_date',
      desc: '',
      args: [],
    );
  }

  /// ` Customer ID`
  String get customer_id {
    return Intl.message(
      ' Customer ID',
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

  /// ` Rental Days`
  String get rental_days {
    return Intl.message(
      ' Rental Days',
      name: 'rental_days',
      desc: '',
      args: [],
    );
  }

  /// ` Rental Kilometers`
  String get rental_kilometers {
    return Intl.message(
      ' Rental Kilometers',
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
