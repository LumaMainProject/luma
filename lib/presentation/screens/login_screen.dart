import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/auth/auth_cubit.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  Future<void> _handleAction(Future<void> Function() action) async {
    if (!mounted) return;
    setState(() => isLoading = true);

    try {
      await action();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated || state is GuestAuthenticated) {
            _navigateToHome();
          } else if (state is LinkSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Check your email: ${state.email}")),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // Send Link Button
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          // _handleAction(
                          //   () => context.read<AuthCubit>().sendSignInLink(
                          //     emailController.text,
                          //   ),
                          // );
                        },
                        child: const Text("Send Sign-In Link"),
                      ),

                // Test Login Button
                ElevatedButton(
                  onPressed: () {
                    // _handleAction(
                    //   () => context.read<AuthCubit>().signInTestUser(
                    //     emailController.text,
                    //   ),
                    // );
                  },
                  child: const Text("Test Login"),
                ),

                const SizedBox(height: 10),

                // Guest Login Button
                ElevatedButton(
                  onPressed: () {
                    _handleAction(
                      () => context.read<AuthCubit>().signInAsGuest(),
                    );
                  },
                  child: const Text("Continue as Guest"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
