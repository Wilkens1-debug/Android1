import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulaire',
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _agreeTerms = false;

  List<String> _userEntries = ['', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire'),
        backgroundColor: Colors.orange, // Koulè jòn pou appBar
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.orange[200],
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    _userEntries[0] = value;
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.orange[200],
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Mot de passe',
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    _userEntries[1] = value;
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Checkbox(
                    value: _agreeTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeTerms = value!;
                      });
                    },
                  ),
                  Text('Accepte '),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_isValidEmail(_userEntries[0]) &&
                      _isStrongPassword(_userEntries[1]) &&
                      _agreeTerms) {
                    print('Utilisateur : $_userEntries');
                    _resetFields();
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Erreur de validation'),
                        content: Text(
                            'Entrer un email valid ou un mot de passe valide.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    return RegExp(emailRegex).hasMatch(email);
  }

  bool _isStrongPassword(String password) {
    return password.length >= 8;
  }

  void _resetFields() {
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _agreeTerms = false;
    });
    _userEntries = ['', ''];
  }
}
