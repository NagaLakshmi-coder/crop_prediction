// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get welcome => 'स्वागत है';

  @override
  String get welcome_to => 'Welcome to';

  @override
  String get home => 'होम';

  @override
  String get admin_dashboard => 'एडमिन डैशबोर्ड';

  @override
  String get farmer_dashboard => 'किसान डैशबोर्ड';

  @override
  String get welcome_admin => 'स्वागत है, एडमिन!';

  @override
  String get welcome_farmer => 'स्वागत है, किसान!';

  @override
  String get login => 'लॉगिन';

  @override
  String get register => 'रजिस्टर';

  @override
  String get name => 'नाम';

  @override
  String get required => 'यह फ़ील्ड आवश्यक है';

  @override
  String get email => 'ईमेल';

  @override
  String get invalid_email => 'कृपया एक मान्य ईमेल दर्ज करें';

  @override
  String get password => 'पासवर्ड';

  @override
  String get invalid_password => 'पासवर्ड कम से कम 4 अक्षरों का होना चाहिए';

  @override
  String get phone => 'फ़ोन';

  @override
  String get invalid_phone => 'कृपया एक मान्य फ़ोन नंबर दर्ज करें';

  @override
  String get village => 'गाँव';

  @override
  String get select_user_type => 'यूज़र प्रकार चुनें';

  @override
  String get farmer => 'किसान';

  @override
  String get admin => 'एडमिन';

  @override
  String get crop_prediction => 'फसल पूर्वानुमान';

  @override
  String get weather_forecast => 'मौसम पूर्वानुमान';

  @override
  String get govt_schemes => 'सरकारी योजनाएँ';

  @override
  String get error_fetching_data => 'डेटा प्राप्त करने में त्रुटि';

  @override
  String get recommended_crop => 'अनुशंसित फसल';

  @override
  String get expected_yield => 'अपेक्षित उपज';

  @override
  String get advice => 'सलाह';

  @override
  String get temp => 'तापमान';
}
