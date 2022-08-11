import 'package:flutter/material.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

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
              'Sign Up User',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        AppUsers.instance.signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    'User ${emailController.text} has succesfully register'),
                              );
                            });
                      } catch (e) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(e.toString()),
                              );
                            });
                      }
                    },
                    child: const Text('Sign Up'),
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
