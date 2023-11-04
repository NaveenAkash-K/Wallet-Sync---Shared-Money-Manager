import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icons_flutter/icons_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var isAuthenticating = false;
  var isLogin = true;
  final _formKey = GlobalKey<FormState>();
  late String _enteredEmail;
  late String _enteredPassword;
  String? _enteredUsername;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() {
          isAuthenticating = true;
        });

        if (isLogin) {
          // ignore: unused_local_variable
          final userCredentials = await firebaseAuth.signInWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);
        } else {
          final userCredentials =
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: _enteredEmail, password: _enteredPassword);
          fireStore.collection('users').doc(userCredentials.user!.uid).set(
            {
              'uid': userCredentials.user!.uid,
              'email': _enteredEmail,
              'username': _enteredUsername,
            },
          );
        }
        setState(() {
          isAuthenticating = false;
        });
      } on FirebaseAuthException catch (error) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.code.toString()[0].toUpperCase() +
                  error.code.toString().substring(1).replaceAll('-', ' '),
            ),
          ),
        );
        setState(() {
          isAuthenticating = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              isLogin ? 'Login' : 'Signup',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null ||
                    !value.contains('@') ||
                    value.trim().isEmpty) {
                  return 'Enter a valid email';
                }
                return null;
              },
              onSaved: (newValue) {
                _enteredEmail = newValue!;
              },
            ),
            if (!isLogin)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                controller: _usernameController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return 'Username must be greater than 2 characters';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredUsername = newValue!;
                },
              ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              controller: _passwordController,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().length < 6) {
                  return 'Password must be atleast 6 characters';
                }
                return null;
              },
              onSaved: (newValue) {
                _enteredPassword = newValue!;
              },
            ),
            if (!isLogin)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                obscureText: true,
                validator: (value) {
                  if (value == null ||
                      value.trim().length < 6 ||
                      _passwordController.text != value) {
                    return 'Passwords does not match';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredPassword = newValue!;
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary),
              child: isAuthenticating
                  ? SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(isLogin ? 'Login' : 'Signup'),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {
                setState(() {
                  _usernameController.clear();
                  _passwordController.clear();
                  isLogin = !isLogin;
                });
                if (isLogin) {
                  _enteredUsername = null;
                }
              },
              child: Text(
                  isLogin ? 'Create an account' : 'Already a user? Login!'),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Icon(
              MaterialCommunityIcons.wallet,
              size: 200,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            Text(
              'Wallet Sync',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 30),
            content,
          ],
        ),
      ),
    );
  }
}
