import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/supabase_config.dart';
import 'shared/theme/app_theme.dart';
import 'router/app_router.dart';
import 'data/repositories/video_repository.dart';
import 'data/repositories/inquiry_repository.dart';
import 'data/repositories/booking_repository.dart';
import 'shared/utils/email_service.dart';
import 'features/home/store/home_store.dart';
import 'features/inquiry/store/inquiry_store.dart';
import 'features/booking/store/booking_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<VideoRepository>(create: (_) => VideoRepository()),
        Provider<InquiryRepository>(create: (_) => InquiryRepository()),
        Provider<BookingRepository>(create: (_) => BookingRepository()),
        Provider<EmailService>(create: (_) => EmailService()),
        Provider<HomeStore>(
          create: (context) => HomeStore(context.read<VideoRepository>()),
          dispose: (_, store) => store.dispose(),
        ),
        Provider<InquiryStore>(
          create: (context) => InquiryStore(
            context.read<InquiryRepository>(),
            context.read<EmailService>(),
          ),
        ),
        Provider<BookingStore>(
          create: (context) => BookingStore(
            context.read<BookingRepository>(),
            context.read<EmailService>(),
          ),
        ),
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
