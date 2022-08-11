import 'package:flutter/material.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/screens/register_screen.dart';
import 'package:note_demo/widgets/custom_circular_progress_bar.dart';

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
                        LoadingIndicator.showLoadingDialog(context);
                        await AppUsers.instance.signIn(
                          email: emailController.text,
                          password: passwordController.text,
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
