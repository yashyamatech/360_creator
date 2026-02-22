class AppConstants {
  // App Info
  static const String appName = '360 Creator';
  static const String appTagline = 'Your Story, Our Vision';

  // Agency Contact
  static const String agencyEmail = 'info@360creator.com';
  static const String agencyPhone = '+1 (555) 360-0001';

  // Pagination
  static const int postsPerPage = 12;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Supabase Table Names
  static const String videoPostsTable = 'videos_posts';
  static const String inquiriesTable = 'inquiries';
  static const String bookingsTable = 'bookings';
  static const String agencyInfoTable = 'agency_info';

  // Project Types
  static const List<String> projectTypes = [
    'Video Creation',
    'Video Editing',
    'Both',
  ];

  // Budget Ranges
  static const List<String> budgetRanges = [
    'Under \$500',
    '\$500 - \$1,000',
    '\$1,000 - \$5,000',
    '\$5,000 - \$10,000',
    '\$10,000+',
    'Custom',
  ];

  // Timeline Options
  static const List<String> timelineOptions = [
    'ASAP (1-2 weeks)',
    '1 Month',
    '2-3 Months',
    '3-6 Months',
    'Flexible',
  ];

  // Social Media URLs (replace with actual)
  static const String instagramUrl = 'https://instagram.com/360creator';
  static const String facebookUrl = 'https://facebook.com/360creator';
  static const String youtubeUrl = 'https://youtube.com/360creator';
  static const String linkedinUrl = 'https://linkedin.com/company/360creator';
}
