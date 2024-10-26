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

  /// `Please Enter Customer Name`
  String get please_enter_customer_name {
    return Intl.message(
      'Please Enter Customer Name',
      name: 'please_enter_customer_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Customer Mobile`
  String get please_enter_customer_mobile {
    return Intl.message(
      'Please Enter Customer Mobile',
      name: 'please_enter_customer_mobile',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Car Name`
  String get please_enter_car_name {
    return Intl.message(
      'Please Enter Car Name',
      name: 'please_enter_car_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Car License Plate`
  String get please_enter_car_license_plate {
    return Intl.message(
      'Please Enter Car License Plate',
      name: 'please_enter_car_license_plate',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Brand`
  String get please_enter_brand {
    return Intl.message(
      'Please Enter Brand',
      name: 'please_enter_brand',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Model`
  String get please_enter_model {
    return Intl.message(
      'Please Enter Model',
      name: 'please_enter_model',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Year of Manufacture`
  String get please_enter_year_of_manufacture {
    return Intl.message(
      'Please Enter Year of Manufacture',
      name: 'please_enter_year_of_manufacture',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Odometer Reading`
  String get please_enter_odometer_reading {
    return Intl.message(
      'Please Enter Odometer Reading',
      name: 'please_enter_odometer_reading',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Next Oil Change`
  String get please_enter_next_oil_change {
    return Intl.message(
      'Please Enter Next Oil Change',
      name: 'please_enter_next_oil_change',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Rental Amount`
  String get please_enter_rental_amount {
    return Intl.message(
      'Please Enter Rental Amount',
      name: 'please_enter_rental_amount',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Rental Date`
  String get please_enter_rental_date {
    return Intl.message(
      'Please Enter Rental Date',
      name: 'please_enter_rental_date',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Return Date`
  String get please_enter_return_date {
    return Intl.message(
      'Please Enter Return Date',
      name: 'please_enter_return_date',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Description`
  String get please_enter_description {
    return Intl.message(
      'Please Enter Description',
      name: 'please_enter_description',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Customer ID`
  String get please_enter_customer_id {
    return Intl.message(
      'Please Enter Customer ID',
      name: 'please_enter_customer_id',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Rental Days`
  String get please_enter_rental_days {
    return Intl.message(
      'Please Enter Rental Days',
      name: 'please_enter_rental_days',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Rental Kilometers`
  String get please_enter_rental_kilometers {
    return Intl.message(
      'Please Enter Rental Kilometers',
      name: 'please_enter_rental_kilometers',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Pickup Date`
  String get please_enter_pickup_date {
    return Intl.message(
      'Please Enter Pickup Date',
      name: 'please_enter_pickup_date',
      desc: '',
      args: [],
    );
  }

  /// `Remove Image`
  String get remove_image {
    return Intl.message(
      'Remove Image',
      name: 'remove_image',
      desc: '',
      args: [],
    );
  }

  /// `Add Image`
  String get add_image {
    return Intl.message(
      'Add Image',
      name: 'add_image',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get take_photo {
    return Intl.message(
      'Take Photo',
      name: 'take_photo',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get upload_photo {
    return Intl.message(
      'Upload Photo',
      name: 'upload_photo',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer`
  String get add_customer {
    return Intl.message(
      'Add Customer',
      name: 'add_customer',
      desc: '',
      args: [],
    );
  }

  /// `Select From Gallery`
  String get select_from_gallery {
    return Intl.message(
      'Select From Gallery',
      name: 'select_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Add Car`
  String get Add_Car {
    return Intl.message(
      'Add Car',
      name: 'Add_Car',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer`
  String get Add_Customer {
    return Intl.message(
      'Add Customer',
      name: 'Add_Customer',
      desc: '',
      args: [],
    );
  }

  /// `Add Order`
  String get Add_Order {
    return Intl.message(
      'Add Order',
      name: 'Add_Order',
      desc: '',
      args: [],
    );
  }

  /// `Edit Car`
  String get Edit_Car {
    return Intl.message(
      'Edit Car',
      name: 'Edit_Car',
      desc: '',
      args: [],
    );
  }

  /// `Edit Customer`
  String get Edit_Customer {
    return Intl.message(
      'Edit Customer',
      name: 'Edit_Customer',
      desc: '',
      args: [],
    );
  }

  /// `Edit Order`
  String get Edit_Order {
    return Intl.message(
      'Edit Order',
      name: 'Edit_Order',
      desc: '',
      args: [],
    );
  }

  /// `Update Car`
  String get Update_Car {
    return Intl.message(
      'Update Car',
      name: 'Update_Car',
      desc: '',
      args: [],
    );
  }

  /// `Update Customer`
  String get Update_Customer {
    return Intl.message(
      'Update Customer',
      name: 'Update_Customer',
      desc: '',
      args: [],
    );
  }

  /// `Update Order`
  String get Update_Order {
    return Intl.message(
      'Update Order',
      name: 'Update_Order',
      desc: '',
      args: [],
    );
  }

  /// `Delete Car`
  String get Delete_Car {
    return Intl.message(
      'Delete Car',
      name: 'Delete_Car',
      desc: '',
      args: [],
    );
  }

  /// `Delete Customer`
  String get Delete_Customer {
    return Intl.message(
      'Delete Customer',
      name: 'Delete_Customer',
      desc: '',
      args: [],
    );
  }

  /// `Delete Order`
  String get Delete_Order {
    return Intl.message(
      'Delete Order',
      name: 'Delete_Order',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get Expenses {
    return Intl.message(
      'Expenses',
      name: 'Expenses',
      desc: '',
      args: [],
    );
  }

  /// `Expenses Data`
  String get Expenses_Data {
    return Intl.message(
      'Expenses Data',
      name: 'Expenses_Data',
      desc: '',
      args: [],
    );
  }

  /// `Add Expenses`
  String get Add_Expenses {
    return Intl.message(
      'Add Expenses',
      name: 'Add_Expenses',
      desc: '',
      args: [],
    );
  }

  /// `Edit expenses`
  String get Edit_Expenses {
    return Intl.message(
      'Edit expenses',
      name: 'Edit_Expenses',
      desc: '',
      args: [],
    );
  }

  /// `Update Expenses`
  String get Update_Expenses {
    return Intl.message(
      'Update Expenses',
      name: 'Update_Expenses',
      desc: '',
      args: [],
    );
  }

  /// `Delete expenses`
  String get Delete_Expenses {
    return Intl.message(
      'Delete expenses',
      name: 'Delete_Expenses',
      desc: '',
      args: [],
    );
  }

  /// `Expenses added successfully`
  String get Expenses_Added_Successfully {
    return Intl.message(
      'Expenses added successfully',
      name: 'Expenses_Added_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Expenses updated successfully`
  String get Expenses_Updated_Successfully {
    return Intl.message(
      'Expenses updated successfully',
      name: 'Expenses_Updated_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Expenses deleted successfully`
  String get Expenses_Deleted_Successfully {
    return Intl.message(
      'Expenses deleted successfully',
      name: 'Expenses_Deleted_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Expenses not found`
  String get Expenses_Not_Found {
    return Intl.message(
      'Expenses not found',
      name: 'Expenses_Not_Found',
      desc: '',
      args: [],
    );
  }

  /// `Car Details`
  String get car_details {
    return Intl.message(
      'Car Details',
      name: 'car_details',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Remaining`
  String get remaining {
    return Intl.message(
      'Remaining',
      name: 'remaining',
      desc: '',
      args: [],
    );
  }

  /// `Paid Amount`
  String get paid_amount {
    return Intl.message(
      'Paid Amount',
      name: 'paid_amount',
      desc: '',
      args: [],
    );
  }

  /// `Cost`
  String get cost {
    return Intl.message(
      'Cost',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Add Expenses`
  String get add_expenses {
    return Intl.message(
      'Add Expenses',
      name: 'add_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Update Expenses`
  String get update_expenses {
    return Intl.message(
      'Update Expenses',
      name: 'update_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Delete Expenses`
  String get delete_expenses {
    return Intl.message(
      'Delete Expenses',
      name: 'delete_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Expenses not found`
  String get Expenses_not_found {
    return Intl.message(
      'Expenses not found',
      name: 'Expenses_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Expenses not deleted`
  String get Expenses_not_deleted {
    return Intl.message(
      'Expenses not deleted',
      name: 'Expenses_not_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Check Internet`
  String get check_internet {
    return Intl.message(
      'Check Internet',
      name: 'check_internet',
      desc: '',
      args: [],
    );
  }

  /// `No Internet`
  String get no_internet {
    return Intl.message(
      'No Internet',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet`
  String get please_check_your_internet {
    return Intl.message(
      'Please check your internet',
      name: 'please_check_your_internet',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_internet_connection {
    return Intl.message(
      'No internet connection',
      name: 'no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Car data updated`
  String get car_data_updated {
    return Intl.message(
      'Car data updated',
      name: 'car_data_updated',
      desc: '',
      args: [],
    );
  }

  /// `Expense added successfully`
  String get expense_added_successfully {
    return Intl.message(
      'Expense added successfully',
      name: 'expense_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Expense updated successfully`
  String get expense_updated_successfully {
    return Intl.message(
      'Expense updated successfully',
      name: 'expense_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Expense deleted successfully`
  String get expense_deleted_successfully {
    return Intl.message(
      'Expense deleted successfully',
      name: 'expense_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Expense not found`
  String get expense_not_found {
    return Intl.message(
      'Expense not found',
      name: 'expense_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Expense not deleted`
  String get expense_not_deleted {
    return Intl.message(
      'Expense not deleted',
      name: 'expense_not_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Add Task`
  String get Add_Task {
    return Intl.message(
      'Add Task',
      name: 'Add_Task',
      desc: '',
      args: [],
    );
  }

  /// `Edit Task`
  String get Edit_Task {
    return Intl.message(
      'Edit Task',
      name: 'Edit_Task',
      desc: '',
      args: [],
    );
  }

  /// `Update Task`
  String get Update_Task {
    return Intl.message(
      'Update Task',
      name: 'Update_Task',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task`
  String get Delete_Task {
    return Intl.message(
      'Delete Task',
      name: 'Delete_Task',
      desc: '',
      args: [],
    );
  }

  /// `Task added successfully`
  String get Task_Added_Successfully {
    return Intl.message(
      'Task added successfully',
      name: 'Task_Added_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get Error {
    return Intl.message(
      'Error',
      name: 'Error',
      desc: '',
      args: [],
    );
  }

  /// `Task updated successfully`
  String get Task_Updated_Successfully {
    return Intl.message(
      'Task updated successfully',
      name: 'Task_Updated_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Task deleted successfully`
  String get Task_Deleted_Successfully {
    return Intl.message(
      'Task deleted successfully',
      name: 'Task_Deleted_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Task not found`
  String get Task_Not_Found {
    return Intl.message(
      'Task not found',
      name: 'Task_Not_Found',
      desc: '',
      args: [],
    );
  }

  /// `Task not deleted`
  String get Task_Not_Deleted {
    return Intl.message(
      'Task not deleted',
      name: 'Task_Not_Deleted',
      desc: '',
      args: [],
    );
  }

  /// `Add Task Type`
  String get Add_Task_Type {
    return Intl.message(
      'Add Task Type',
      name: 'Add_Task_Type',
      desc: '',
      args: [],
    );
  }

  /// `Edit Task Type`
  String get Edit_Task_Type {
    return Intl.message(
      'Edit Task Type',
      name: 'Edit_Task_Type',
      desc: '',
      args: [],
    );
  }

  /// `Update Task Type`
  String get Update_Task_Type {
    return Intl.message(
      'Update Task Type',
      name: 'Update_Task_Type',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task Type`
  String get Delete_Task_Type {
    return Intl.message(
      'Delete Task Type',
      name: 'Delete_Task_Type',
      desc: '',
      args: [],
    );
  }

  /// `Task type added successfully`
  String get Task_Type_Added_Successfully {
    return Intl.message(
      'Task type added successfully',
      name: 'Task_Type_Added_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Task type updated successfully`
  String get Task_Type_Updated_Successfully {
    return Intl.message(
      'Task type updated successfully',
      name: 'Task_Type_Updated_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Task type deleted successfully`
  String get Task_Type_Deleted_Successfully {
    return Intl.message(
      'Task type deleted successfully',
      name: 'Task_Type_Deleted_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Task type not found`
  String get Task_Type_Not_Found {
    return Intl.message(
      'Task type not found',
      name: 'Task_Type_Not_Found',
      desc: '',
      args: [],
    );
  }

  /// `Task type not deleted`
  String get Task_Type_Not_Deleted {
    return Intl.message(
      'Task type not deleted',
      name: 'Task_Type_Not_Deleted',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get Success {
    return Intl.message(
      'Success',
      name: 'Success',
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
