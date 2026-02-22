import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/home/pages/home_screen.dart';
import '../features/video_detail/pages/video_detail_screen.dart';
import '../features/inquiry/pages/inquiry_form_screen.dart';
import '../features/booking/pages/booking_screen.dart';
import '../features/about/pages/about_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('Page not found'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/video/:id',
        builder: (context, state) => VideoDetailScreen(
          videoId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/inquiry',
        builder: (context, state) => const InquiryFormScreen(),
      ),
      GoRoute(
        path: '/booking/:videoId',
        builder: (context, state) => BookingScreen(
          videoId: state.pathParameters['videoId'],
        ),
      ),
      GoRoute(
        path: '/booking',
        builder: (context, state) => const BookingScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutScreen(),
      ),
    ],
  );
}
