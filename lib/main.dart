import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:luma_2/core/objects_to_add.dart';
import 'package:luma_2/core/router/app_router.dart';
import 'package:luma_2/core/theme/app_theme.dart';
import 'package:luma_2/data/repositories/products_repository.dart';
import 'package:luma_2/data/repositories/store_repository.dart';
import 'package:luma_2/data/repositories/user_repository.dart';
import 'package:luma_2/firebase_options.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:luma_2/data/repositories/auth_repository.dart';
import 'package:luma_2/logic/auth/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  // Инициализация локали для intl
  await initializeDateFormatting('ru', null);

  final uri = Uri.base;
  if (uri.queryParameters['finishSignIn'] == 'true') {
    // здесь можно завершить sign-in через email link
  }

  // Вызвать сидер только один раз
  // await TestSeeder().seedTestData();

  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository.instance; // singleton
    final authCubit = AuthCubit(authRepository);

    final productsRepository = ProductsRepository();
    final storesRepository = StoresRepository();
    final userRepository = UserRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authCubit),
        BlocProvider(create: (_) => ProductsCubit(productsRepository)),
        BlocProvider(create: (_) => StoresCubit(storesRepository)),
        BlocProvider(create: (_) => UserBloc(userRepository)),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          final userBloc = context.read<UserBloc>();

          if (state is Authenticated) {
            userBloc.add(LoadUser(state.user.uid));
          } else if (state is AuthenticatedProfile) {
            userBloc.add(SetUserProfile(state.profile));
          } else if (state is Unauthenticated) {
            userBloc.add(ClearUser());
          }
        },
        child: MaterialApp.router(
          title: 'Marketplace Demo',
          theme: AppTheme.light,
          routerConfig: AppRouter.build(authCubit),
        ),
      ),
    );
  }
}
