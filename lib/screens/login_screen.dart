import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final Function(Locale) setLocale;
  final Locale selectedLocale;
  const LoginScreen({Key? key, required this.setLocale, required this.selectedLocale}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '', password = '';
  String userType = 'farmer'; // default farmer

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.login)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              const SizedBox(height: 20),
              Text(AppLocalizations.of(context)!.select_user_type, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(label: Text(AppLocalizations.of(context)!.farmer), selected: userType=='farmer', onSelected: (_) => setState(() => userType='farmer')),
                  const SizedBox(width: 20),
                  ChoiceChip(label: Text(AppLocalizations.of(context)!.admin), selected: userType=='admin', onSelected: (_) => setState(() => userType='admin')),
                ],
              ),
             const SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.email,
                border: const OutlineInputBorder(),
               ),
               validator: (v) {
                if (v == null || v.isEmpty) {
                  return AppLocalizations.of(context)!.invalid_email;
                }
                // Email regex: something@something.com
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(v.trim())) {
                  return AppLocalizations.of(context)!.invalid_email;
                }
                return null;
               },
                onSaved: (v) => email = v!.trim(),
              ),

              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.password, border: const OutlineInputBorder()),
                obscureText: true,
                validator: (v) => v==null || v.length<4 ? AppLocalizations.of(context)!.invalid_password : null,
                onSaved: (v) => password = v!.trim(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: Text(AppLocalizations.of(context)!.login),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    await auth.login(email, password);
                    Navigator.pushReplacementNamed(context, userType=='admin'?'/admin':'/home');
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
