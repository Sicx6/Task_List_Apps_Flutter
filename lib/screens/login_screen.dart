import 'package:flutter/material.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, right: 25, left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.note,
              size: 90,
            ),
            const Text(
              'Sign In User',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'email',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'password',
                  ),
                  obscureText: true,
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
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await AppUsers.instance.signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(e.toString()),
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
