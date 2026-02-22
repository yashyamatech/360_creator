import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/supabase_config.dart';
import 'config/service_locator.dart';
import 'shared/theme/app_theme.dart';
import 'router/app_router.dart';
import 'features/home/store/home_store.dart';
import 'features/inquiry/store/inquiry_store.dart';
import 'features/booking/store/booking_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise backend
  await SupabaseConfig.initialize();

  // Register all services, repositories, and stores with get_it
  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Expose MobX stores via Provider so Observer widgets can react to changes.
    // Instances are sourced from the get_it locator — single source of truth.
    return MultiProvider(
      providers: [
        Provider<HomeStore>.value(value: locator<HomeStore>()),
        Provider<InquiryStore>.value(value: locator<InquiryStore>()),
        Provider<BookingStore>.value(value: locator<BookingStore>()),
      ],
      child: MaterialApp.router(
        title: '360 Creator',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
