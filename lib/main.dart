import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:luma_2/core/objects_to_add.dart';

import 'package:luma_2/core/router/app_router.dart';
import 'package:luma_2/core/theme/app_theme.dart';
import 'package:luma_2/data/repositories/orders_repository.dart';

import 'package:luma_2/data/repositories/products_repository.dart';
import 'package:luma_2/data/repositories/store_repository.dart';
import 'package:luma_2/data/repositories/user_repository.dart';
import 'package:luma_2/data/repositories/auth_repository.dart';
import 'package:luma_2/data/repositories/notifications_repository.dart';
import 'package:luma_2/data/repositories/chat_repository.dart';

import 'package:luma_2/firebase_options.dart';
import 'package:luma_2/logic/analytics/analytics_bloc.dart';
import 'package:luma_2/logic/chat/chat_bloc.dart';
import 'package:luma_2/logic/multi_store_orders/multi_store_orders_bloc.dart';
import 'package:luma_2/logic/orders_bloc/orders_bloc.dart';
import 'package:luma_2/logic/product_analytics/product_analytics_bloc.dart';

import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/logic/seller_add_product/seller_add_product_bloc.dart';
import 'package:luma_2/logic/seller_stores/seller_stores_bloc.dart';
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
    final chatRepository = ChatRepository();
    final ordersRepository = OrdersRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authCubit),
        BlocProvider(create: (_) => ProductsCubit(productsRepository)),
        BlocProvider(create: (_) => StoresCubit(storesRepository)),
        BlocProvider(create: (_) => UserBloc(userRepository)),
        BlocProvider(create: (_) => NotificationsBloc(notificationsRepository)),
        BlocProvider(create: (_) => ChatBloc(chatRepository)),
        BlocProvider(create: (_) => SellerStoresBloc(storesRepository)),
        BlocProvider(create: (_) => OrdersBloc(repository: ordersRepository)),
        BlocProvider(
          create: (_) => MultiStoreOrdersBloc(repository: ordersRepository),
        ),
        BlocProvider(create: (_) => SellerAddProductBloc(productsRepository)),
        BlocProvider(
          create: (_) => AnalyticsBloc(ordersRepository: ordersRepository),
        ),
        BlocProvider(
          create: (_) =>
              ProductAnalyticsBloc(ordersRepository: ordersRepository),
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          final userBloc = context.read<UserBloc>();
          final notificationsBloc = context.read<NotificationsBloc>();
          final chatBloc = context.read<ChatBloc>();
          final userStoresBloc = context.read<SellerStoresBloc>();
          final ordersBloc = context.read<OrdersBloc>();
          final multiStoreOrdersBloc = context.read<MultiStoreOrdersBloc>();

          if (state is Authenticated) {
            final userId = state.user.uid;

            // Загружаем данные пользователя и связанные сущности
            userBloc.add(LoadUser(userId));
            notificationsBloc.add(LoadNotifications(userId));
            chatBloc.add(LoadUserChats(userId));
            userStoresBloc.add(LoadSellerStores(userId));
            ordersBloc.add(LoadOrders(userId));

            // Подписка на изменения магазинов пользователя
            userStoresBloc.stream.listen((storesState) {
              if (storesState is SellerStoresLoaded) {
                final storeIds = storesState.stores.map((s) => s.id).toList();

                for (final storeId in storeIds) {
                  // Подгружаем заказы для MultiStoreOrdersBloc
                  multiStoreOrdersBloc.add(LoadStoreOrders(storeId));
                }
              }
            });
          } else if (state is AuthenticatedProfile) {
            final userId = state.profile.id;

            userBloc.add(SetUserProfile(state.profile));
            notificationsBloc.add(LoadNotifications(userId));
            chatBloc.add(LoadUserChats(userId));
            userStoresBloc.add(LoadSellerStores(userId));
            ordersBloc.add(LoadOrders(userId));

            userStoresBloc.stream.listen((storesState) {
              if (storesState is SellerStoresLoaded) {
                final storeIds = storesState.stores.map((s) => s.id).toList();

                for (final storeId in storeIds) {
                  multiStoreOrdersBloc.add(LoadStoreOrders(storeId));
                }
              }
            });
          } else if (state is GuestAuthenticated || state is Unauthenticated) {
            // Очищаем данные при выходе или гостевом входе
            userBloc.add(ClearUser());
            notificationsBloc.add(ClearNotifications());
            chatBloc.add(ClearUserChats());
            userStoresBloc.add(ClearSellerStores());
            ordersBloc.add(ClearOrders());
            multiStoreOrdersBloc.add(MultiStoreClearOrders());
          }
        },
        child: MaterialApp.router(
          title: 'Marketplace Demo',
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.build(authCubit),
        ),
      ),
    );
  }
}
