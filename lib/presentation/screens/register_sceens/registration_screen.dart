import 'package:flutter/material.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/logic/registration/registration_bloc.dart';
import 'package:luma_2/presentation/screens/register_sceens/registration_pages/registration_first_screen.dart';
import 'package:luma_2/presentation/screens/register_sceens/registration_pages/registration_second_screen.dart';
import 'package:luma_2/presentation/screens/register_sceens/registration_pages/registration_third_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationBloc()..add(StartRegistration()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Регистрация"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: RegistrationScreenProgressIndicator(
              currentPage: _currentPage,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: const [
                  RegistrationFirstScreen(),
                  RegistrationSecondScreen(),
                  RegistrationThirdScreen(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _prevPage,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: const Text("Назад"),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: Text(_currentPage == 2 ? "Завершить" : "Далее"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationScreenProgressIndicator extends StatelessWidget {
  const RegistrationScreenProgressIndicator({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildCircle(0),
          _buildLine(0),
          _buildCircle(1),
          _buildLine(1),
          _buildCircle(2),
        ],
      ),
    );
  }

  Widget _buildCircle(int index) {
    final isActive = index == currentPage;
    final isCompleted = index < currentPage;

    return CircleAvatar(
      radius: 16,
      backgroundColor: isActive || isCompleted
          ? AppColors.primary
          : AppColors.secondary,
      child: Text(
        "${index + 1}",
        style: TextStyle(
          color: isActive || isCompleted ? Colors.white : Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLine(int index) {
    final isCompleted = index < currentPage;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 2,
        color: isCompleted ? AppColors.primary : AppColors.secondary,
      ),
    );
  }
}
