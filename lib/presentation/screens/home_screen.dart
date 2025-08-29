import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/router/app_routes.dart';
import '../../logic/auth/auth_cubit.dart';
import 'products_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToLogin(BuildContext context) {
    context.go(AppRoute.auth.path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          _navigateToLogin(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Marketplace"),
          actions: [
            IconButton(
              onPressed: () {
                _navigateToLogin(context);
                context.read<AuthCubit>().signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const ProductsScreen(),
      ),
    );
  }
}
