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
import 'package:luma_2/data/repositories/auth_repository.dart';
import 'package:luma_2/data/repositories/notifications_repository.dart';
import 'package:luma_2/data/repositories/chat_repository.dart';

import 'package:luma_2/firebase_options.dart';
import 'package:luma_2/logic/bloc/chat_bloc.dart';

import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:luma_2/logic/auth/auth_cubit.dart';
import 'package:luma_2/logic/notifications/notifications_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  await initializeDateFormatting('ru', null);

  // TestSeeder().seedTestData();

  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository.instance;
    final authCubit = AuthCubit(authRepository);

    final productsRepository = ProductsRepository();
    final storesRepository = StoresRepository();
    final userRepository = UserRepository();
    final notificationsRepository = NotificationsRepository();
    final chatRepository = ChatRepository(); // 👈 добавили

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authCubit),
        BlocProvider(create: (_) => ProductsCubit(productsRepository)),
        BlocProvider(create: (_) => StoresCubit(storesRepository)),
        BlocProvider(create: (_) => UserBloc(userRepository)),
        BlocProvider(create: (_) => NotificationsBloc(notificationsRepository)),
        BlocProvider(
          create: (_) => ChatBloc(chatRepository),
        ), // 👈 блок сообщений
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          final userBloc = context.read<UserBloc>();
          final notificationsBloc = context.read<NotificationsBloc>();
          final chatBloc = context.read<ChatBloc>(); // 👈 блок сообщений

          if (state is Authenticated) {
            final userId = state.user.uid;
            userBloc.add(LoadUser(userId));
            notificationsBloc.add(LoadNotifications(userId));
            chatBloc.add(LoadUserChats(userId)); // загружаем чаты
          } else if (state is AuthenticatedProfile) {
            final userId = state.profile.id;
            userBloc.add(SetUserProfile(state.profile));
            notificationsBloc.add(LoadNotifications(userId));
            chatBloc.add(LoadUserChats(userId));
          } else if (state is GuestAuthenticated) {
            userBloc.add(ClearUser());
            notificationsBloc.add(ClearNotifications());
            chatBloc.add(ClearUserChats()); // гость → чаты пустые
          } else if (state is Unauthenticated) {
            userBloc.add(ClearUser());
            notificationsBloc.add(ClearNotifications());
            chatBloc.add(ClearUserChats()); // тоже пусто
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
