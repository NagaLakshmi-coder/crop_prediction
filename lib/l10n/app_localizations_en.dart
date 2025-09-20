// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome';

  @override
  String get welcome_to => 'Welcome to';

  @override
  String get home => 'Home';

  @override
  String get admin_dashboard => 'Admin Dashboard';

  @override
  String get farmer_dashboard => 'Farmer Dashboard';

  @override
  String get welcome_admin => 'Welcome, Admin!';

  @override
  String get welcome_farmer => 'Welcome, Farmer!';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get name => 'Name';

  @override
  String get required => 'This field is required';

  @override
  String get email => 'Email';

  @override
  String get invalid_email => 'Invalid email address';

  @override
  String get password => 'Password';

  @override
  String get invalid_password => 'Password must be at least 4 characters';

  @override
  String get phone => 'Phone Number';

  @override
  String get invalid_phone => 'Invalid phone number';

  @override
  String get village => 'Village';

  @override
  String get select_user_type => 'Select User Type';

  @override
  String get farmer => 'Farmer';

  @override
  String get admin => 'Admin';

  @override
  String get crop_prediction => 'Crop Prediction';

  @override
  String get weather_forecast => 'Weather Forecast';

  @override
  String get govt_schemes => 'Government Schemes';

  @override
  String get error_fetching_data => 'Error fetching data';

  @override
  String get recommended_crop => 'Recommended Crop';

  @override
  String get expected_yield => 'Expected Yield';

  @override
  String get advice => 'Advice';

  @override
  String get temp => 'Temperature';
}
