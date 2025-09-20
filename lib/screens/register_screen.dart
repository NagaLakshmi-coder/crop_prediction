import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  final Function(Locale) setLocale;
  final Locale selectedLocale;
  const RegisterScreen({Key? key, required this.setLocale, required this.selectedLocale}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String name='', email='', password='', phone='', village='';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.register)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.name, border: const OutlineInputBorder()),
                validator: (v)=>v==null||v.isEmpty?AppLocalizations.of(context)!.required:null,
                onSaved: (v)=>name=v!.trim(),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.email, border: const OutlineInputBorder()),
                validator: (v)=>v==null||!v.contains("@")?AppLocalizations.of(context)!.invalid_email:null,
                onSaved: (v)=>email=v!.trim(),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.password, border: const OutlineInputBorder()),
                obscureText: true,
                validator: (v)=>v==null||v.length<4?AppLocalizations.of(context)!.invalid_password:null,
                onSaved: (v)=>password=v!.trim(),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.phone, border: const OutlineInputBorder()),
                validator: (v)=>v==null||v.length<10?AppLocalizations.of(context)!.invalid_phone:null,
                onSaved: (v)=>phone=v!.trim(),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.village, border: const OutlineInputBorder()),
                validator: (v)=>v==null||v.isEmpty?AppLocalizations.of(context)!.required:null,
                onSaved: (v)=>village=v!.trim(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: Text(AppLocalizations.of(context)!.register),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    await auth.signup(email,password);
                    Navigator.pushReplacementNamed(context, '/home');
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
