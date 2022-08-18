import 'package:flutter/material.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/screens/login_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // final emailController = TextEditingController();
  final form = FormGroup({
    'email': FormControl(validators: [Validators.required, Validators.email]),
    'password':
        FormControl(validators: [Validators.required, Validators.minLength(6)]),
    'name':
        FormControl(validators: [Validators.required, Validators.minLength(1)]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, right: 25, left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
            ),
            const Text(
              'Sign Up User',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ReactiveForm(
                formGroup: form,
                child: Column(
                  children: [
                    ReactiveTextField(
                      formControlName: 'name',
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        suffixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validationMessages: {
                        ValidationMessage.required: (error) =>
                            'Please input your name'
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReactiveTextField(
                      formControlName: 'email',
                      decoration: const InputDecoration(
                        labelText: 'email',
                        suffixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validationMessages: {
                        ValidationMessage.required: (error) =>
                            'Email format is invalid'
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReactiveTextField(
                      formControlName: 'password',
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'password',
                        suffixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validationMessages: {
                        ValidationMessage.minLength: (error) =>
                            'Password must contain 6 characters or above'
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => LoginScreen())));
                            },
                            child: const Text('Already sign up? Sign In')),
                      ],
                    ),
                    ReactiveFormConsumer(builder: ((context, formGroup, child) {
                      print(form);
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: form.valid
                              ? () async {
                                  try {
                                    AppUsers.instance.signUp(
                                      email: form.control('email').value,
                                      password: form.control('password').value,
                                      name: form.control('email').value,
                                    );
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                'User ${form.control('email').value} has succesfully register'),
                                          );
                                        });
                                  } catch (e) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(e.toString()),
                                          );
                                        });
                                  }
                                }
                              : null,
                          child: const Text('Sign Up'),
                        ),
                      );
                    }))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
