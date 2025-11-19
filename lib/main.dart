import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/core/api_environment.dart';
import 'package:inovola/core/app_routes.dart';
import 'package:inovola/core/models/purchased_item_database.dart';
import 'package:inovola/core/models/sample_data_generator.dart';
import 'package:inovola/features/home/bloc/home_bloc.dart';
import 'package:inovola/features/home/bloc/home_event.dart';
import 'package:inovola/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = PurchasedItemDatabase.instance;
  final existingItems = await db.getAllItems();

  if (existingItems.isEmpty) {
    final sampleItems = SampleDataGenerator.generateSampleItems();
    await db.insertItems(sampleItems);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()..add(LoadHomeData()),
        ),
      ],
      child: MaterialApp.router(
        title: ApiEnvironment.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        routerDelegate: AppRoutes.router.routerDelegate,
        routeInformationProvider: AppRoutes.router.routeInformationProvider,
        routeInformationParser: AppRoutes.router.routeInformationParser,
      ),
    );
  }
}
