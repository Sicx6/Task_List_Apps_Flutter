import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/screens/register_screen.dart';
import 'package:note_demo/widgets/custom_circular_progress_bar.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final form = FormGroup({
    'email': FormControl(validators: [Validators.required, Validators.email]),
    'password':
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
              'Sign In User',
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
                    formControlName: 'email',
                    decoration: const InputDecoration(
                      labelText: 'email',
                      suffixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => RegisterScreen())));
                          },
                          child: const Text('Sign Up')),
                    ],
                  ),
                  ReactiveFormConsumer(builder: ((context, form, child) {
                    print(form.value);
                    return Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: form.valid
                            ? () async {
                                try {
                                  LoadingIndicator.showLoadingDialog(context);
                                  await AppUsers.instance.signIn(
                                    email: form.control('email').value,
                                    password: form.control('password').value,
                                  );
                                  Navigator.pop(context);
                                } catch (e) {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(e.toString()),
                                      );
                                    },
                                  );
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) {
                                  //     return const Center(
                                  //         child: CircularProgressIndicator());
                                  //   },
                                  // );

                                }
                              }
                            : null,
                        child: const Text('Sign In'),
                      ),
                    );
                  })),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
