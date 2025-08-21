import 'package:flutter/material.dart';
import '../presentation/discovery_dashboard/discovery_dashboard.dart';
import '../presentation/search_and_filter/search_and_filter.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/business_profile/business_profile.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/write_review/write_review.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String discoveryDashboard = '/discovery-dashboard';
  static const String searchAndFilter = '/search-and-filter';
  static const String login = '/login-screen';
  static const String businessProfile = '/business-profile';
  static const String registration = '/registration-screen';
  static const String writeReview = '/write-review';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    discoveryDashboard: (context) => const DiscoveryDashboard(),
    searchAndFilter: (context) => const SearchAndFilter(),
    login: (context) => const LoginScreen(),
    businessProfile: (context) => const BusinessProfile(),
    registration: (context) => const RegistrationScreen(),
    writeReview: (context) => const WriteReview(),
    // TODO: Add your other routes here
  };
}
