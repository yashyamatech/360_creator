import 'package:get_it/get_it.dart';
import '../data/repositories/video_repository.dart';
import '../data/repositories/inquiry_repository.dart';
import '../data/repositories/booking_repository.dart';
import '../shared/utils/email_service.dart';
import '../shared/utils/app_logger.dart';
import '../features/home/store/home_store.dart';
import '../features/inquiry/store/inquiry_store.dart';
import '../features/booking/store/booking_store.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ── Utilities ──────────────────────────────────────────────
  locator.registerLazySingleton<AppLogger>(() => AppLogger());
  locator.registerLazySingleton<EmailService>(() => EmailService());

  // ── Repositories ───────────────────────────────────────────
  locator.registerLazySingleton<VideoRepository>(() => VideoRepository());
  locator.registerLazySingleton<InquiryRepository>(() => InquiryRepository());
  locator.registerLazySingleton<BookingRepository>(() => BookingRepository());

  // ── Stores ─────────────────────────────────────────────────
  // Registered as factories so each screen gets a fresh store if needed,
  // but singletons work fine for this app's scope.
  locator.registerLazySingleton<HomeStore>(
    () => HomeStore(locator<VideoRepository>()),
  );
  locator.registerLazySingleton<InquiryStore>(
    () => InquiryStore(
      locator<InquiryRepository>(),
      locator<EmailService>(),
    ),
  );
  locator.registerLazySingleton<BookingStore>(
    () => BookingStore(
      locator<BookingRepository>(),
      locator<EmailService>(),
    ),
  );
}
