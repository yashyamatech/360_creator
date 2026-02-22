import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/models/video_post_model.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/video_detail/presentation/pages/video_detail_screen.dart';
import '../features/inquiry/presentation/pages/inquiry_form_screen.dart';
import '../features/booking/presentation/pages/booking_screen.dart';
import '../features/about/presentation/pages/about_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      // Home Feed
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      // Video Detail
      GoRoute(
        path: '/video/:id',
        name: 'video-detail',
        builder: (context, state) {
          final videoId = state.pathParameters['id']!;
          final post = state.extra as VideoPost?;
          return VideoDetailScreen(videoId: videoId, initialPost: post);
        },
      ),
      // Inquiry Form
      GoRoute(
        path: '/inquiry',
        name: 'inquiry',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          return InquiryFormScreen(
            referenceVideoId: extras?['videoId'] as String?,
            referenceVideoTitle: extras?['videoTitle'] as String?,
          );
        },
      ),
      // Booking
      GoRoute(
        path: '/booking',
        name: 'booking',
        builder: (context, state) {
          final referenceVideo = state.extra as VideoPost?;
          return BookingScreen(referenceVideo: referenceVideo);
        },
      ),
      // About
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
