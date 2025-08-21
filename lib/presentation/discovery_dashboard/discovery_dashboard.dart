import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/bottom_navigation_widget.dart';
import './widgets/cuisine_filter_widget.dart';
import './widgets/location_header_widget.dart';
import './widgets/restaurant_card_widget.dart';
import './widgets/section_header_widget.dart';
import './widgets/tourism_card_widget.dart';
import './widgets/weekly_picks_card_widget.dart';

class DiscoveryDashboard extends StatefulWidget {
  const DiscoveryDashboard({Key? key}) : super(key: key);

  @override
  State<DiscoveryDashboard> createState() => _DiscoveryDashboardState();
}

class _DiscoveryDashboardState extends State<DiscoveryDashboard> {
  String _currentLanguage = 'en';
  String _currentLocation = 'Cairo, Egypt';
  int _currentBottomNavIndex = 0;
  bool _isRefreshing = false;
  String _selectedCuisineFilter = '';

  // Mock data for nearby restaurants
  final List<Map<String, dynamic>> _nearbyRestaurants = [
    {
      "id": 1,
      "name": "Abou El Sid",
      "nameAr": "أبو السيد",
      "image":
          "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "rating": 4.5,
      "priceRange": "EGP 200-400",
      "cuisine": "Traditional Egyptian",
      "distance": "0.8 km",
      "isFavorite": false,
    },
    {
      "id": 2,
      "name": "Sequoia",
      "nameAr": "سيكويا",
      "image":
          "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "rating": 4.2,
      "priceRange": "EGP 300-600",
      "cuisine": "Mediterranean",
      "distance": "1.2 km",
      "isFavorite": true,
    },
    {
      "id": 3,
      "name": "Zooba",
      "nameAr": "زوبا",
      "image":
          "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "rating": 4.7,
      "priceRange": "EGP 50-150",
      "cuisine": "Modern Egyptian Street Food",
      "distance": "0.5 km",
      "isFavorite": false,
    },
  ];

  // Mock data for top tourism spots
  final List<Map<String, dynamic>> _topTourismSpots = [
    {
      "id": 1,
      "name": "The Great Pyramid of Giza",
      "nameAr": "الهرم الأكبر بالجيزة",
      "image":
          "https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "rating": 4.8,
      "category": "Historical",
      "distance": "25 km",
      "duration": "3-4 hours",
      "isFavorite": true,
    },
    {
      "id": 2,
      "name": "Khan El Khalili Bazaar",
      "nameAr": "خان الخليلي",
      "image":
          "https://images.unsplash.com/photo-1578662996442-48f60103fc96?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "rating": 4.3,
      "category": "Shopping",
      "distance": "2.1 km",
      "duration": "2-3 hours",
      "isFavorite": false,
    },
    {
      "id": 3,
      "name": "Egyptian Museum",
      "nameAr": "المتحف المصري",
      "image":
          "https://images.unsplash.com/photo-1471919743851-c4df8b6ee133?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "rating": 4.6,
      "category": "Museum",
      "distance": "1.8 km",
      "duration": "2-4 hours",
      "isFavorite": false,
    },
  ];

  // Mock data for weekly picks
  final List<Map<String, dynamic>> _weeklyPicks = [
    {
      "id": 1,
      "name": "Nile Dinner Cruise",
      "nameAr": "رحلة عشاء نيلية",
      "image":
          "https://images.unsplash.com/photo-1544551763-46a013bb70d5?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "rating": 4.4,
      "badge": "Editor's Choice",
      "type": "Experience",
      "description":
          "Enjoy a magical evening cruise along the Nile with traditional Egyptian cuisine and entertainment.",
      "descriptionAr":
          "استمتع برحلة مسائية ساحرة على النيل مع المأكولات المصرية التقليدية والترفيه.",
    },
    {
      "id": 2,
      "name": "Felucca Sunset Ride",
      "nameAr": "رحلة فلوكة عند الغروب",
      "image":
          "https://images.unsplash.com/photo-1578662996442-48f60103fc96?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "rating": 4.7,
      "badge": "Most Popular",
      "type": "Activity",
      "description":
          "Experience the tranquil beauty of the Nile on a traditional felucca boat at sunset.",
      "descriptionAr":
          "اختبر الجمال الهادئ للنيل على متن قارب فلوكة تقليدي عند الغروب.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            LocationHeaderWidget(
              currentLocation: _currentLocation,
              currentLanguage: _currentLanguage,
              onLocationTap: _showLocationPicker,
              onLanguageToggle: _toggleLanguage,
            ),
            CuisineFilterWidget(
              currentLanguage: _currentLanguage,
              onCuisineSelected: _onCuisineFilterChanged,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                color: AppTheme.lightTheme.colorScheme.primary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      _buildNearbyRestaurantsSection(),
                      SizedBox(height: 4.h),
                      _buildTopTourismSpotsSection(),
                      SizedBox(height: 4.h),
                      _buildWeeklyPicksSection(),
                      SizedBox(height: 10.h), // Bottom padding for FAB
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentBottomNavIndex,
        currentLanguage: _currentLanguage,
        onTap: _onBottomNavTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showQuickFilters,
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        child: CustomIconWidget(
          iconName: 'tune',
          color: AppTheme.lightTheme.colorScheme.onPrimary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildNearbyRestaurantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: _currentLanguage == 'ar'
              ? 'المطاعم القريبة'
              : 'Nearby Restaurants',
          subtitle: _currentLanguage == 'ar'
              ? 'مرتبة حسب المسافة'
              : 'Sorted by distance',
          currentLanguage: _currentLanguage,
          onSeeAllTap: () => _navigateToSearchAndFilter('restaurants'),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 32.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 4.w),
            itemCount: _nearbyRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = _nearbyRestaurants[index];
              return RestaurantCardWidget(
                restaurant: restaurant,
                currentLanguage: _currentLanguage,
                onTap: () => _navigateToBusinessProfile(restaurant['id']),
                onFavorite: () =>
                    _toggleFavorite('restaurant', restaurant['id']),
                onShare: () => _sharePlace(restaurant),
                onDirections: () => _getDirections(restaurant),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopTourismSpotsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: _currentLanguage == 'ar'
              ? 'أفضل الأماكن السياحية'
              : 'Top Tourism Spots',
          subtitle: _currentLanguage == 'ar'
              ? 'مختارات منسقة'
              : 'Curated attractions',
          currentLanguage: _currentLanguage,
          onSeeAllTap: () => _navigateToSearchAndFilter('tourism'),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 35.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 4.w),
            itemCount: _topTourismSpots.length,
            itemBuilder: (context, index) {
              final attraction = _topTourismSpots[index];
              return TourismCardWidget(
                attraction: attraction,
                currentLanguage: _currentLanguage,
                onTap: () => _navigateToBusinessProfile(attraction['id']),
                onFavorite: () => _toggleFavorite('tourism', attraction['id']),
                onShare: () => _sharePlace(attraction),
                onDirections: () => _getDirections(attraction),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyPicksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: _currentLanguage == 'ar' ? 'اختيارات الأسبوع' : 'Weekly Picks',
          subtitle: _currentLanguage == 'ar'
              ? 'توصيات المحررين'
              : 'Editor recommendations',
          currentLanguage: _currentLanguage,
          onSeeAllTap: () => _navigateToSearchAndFilter('weekly'),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 42.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 4.w),
            itemCount: _weeklyPicks.length,
            itemBuilder: (context, index) {
              final pick = _weeklyPicks[index];
              return WeeklyPicksCardWidget(
                pick: pick,
                currentLanguage: _currentLanguage,
                onTap: () => _navigateToBusinessProfile(pick['id']),
              );
            },
          ),
        ),
      ],
    );
  }

  void _toggleLanguage() {
    setState(() {
      _currentLanguage = _currentLanguage == 'en' ? 'ar' : 'en';
      _currentLocation =
          _currentLanguage == 'ar' ? 'القاهرة، مصر' : 'Cairo, Egypt';
    });
    HapticFeedback.lightImpact();
  }

  void _showLocationPicker() {
    final List<Map<String, String>> locations = [
      {'en': 'Cairo, Egypt', 'ar': 'القاهرة، مصر'},
      {'en': 'Alexandria, Egypt', 'ar': 'الإسكندرية، مصر'},
      {'en': 'Giza, Egypt', 'ar': 'الجيزة، مصر'},
      {'en': 'Luxor, Egypt', 'ar': 'الأقصر، مصر'},
      {'en': 'Aswan, Egypt', 'ar': 'أسوان، مصر'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              _currentLanguage == 'ar' ? 'اختر الموقع' : 'Choose Location',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 2.h),
            ...locations.map((location) {
              final String displayName = location[_currentLanguage]!;
              return ListTile(
                leading: CustomIconWidget(
                  iconName: 'location_on',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 24,
                ),
                title: Text(
                  displayName,
                  style: AppTheme.lightTheme.textTheme.bodyLarge,
                ),
                onTap: () {
                  setState(() {
                    _currentLocation = displayName;
                  });
                  Navigator.pop(context);
                  HapticFeedback.selectionClick();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }).toList(),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    HapticFeedback.mediumImpact();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _onBottomNavTap(int index) {
    if (index == _currentBottomNavIndex) return;

    setState(() {
      _currentBottomNavIndex = index;
    });

    HapticFeedback.selectionClick();

    // Navigate to different screens based on index
    switch (index) {
      case 0:
        // Already on Discovery Dashboard
        break;
      case 1:
        Navigator.pushNamed(context, '/search-and-filter');
        break;
      case 2:
        // Navigate to favorites (not implemented in this screen)
        break;
      case 3:
        // Navigate to profile (not implemented in this screen)
        break;
    }
  }

  void _showQuickFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: 60.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              _currentLanguage == 'ar' ? 'فلاتر سريعة' : 'Quick Filters',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 3.h),
            _buildFilterSection(
              _currentLanguage == 'ar' ? 'نوع المطبخ' : 'Cuisine Type',
              ['Egyptian', 'Mediterranean', 'International', 'Street Food'],
            ),
            SizedBox(height: 3.h),
            _buildFilterSection(
              _currentLanguage == 'ar' ? 'نطاق السعر' : 'Price Range',
              ['EGP 0-100', 'EGP 100-300', 'EGP 300-500', 'EGP 500+'],
            ),
            SizedBox(height: 3.h),
            _buildFilterSection(
              _currentLanguage == 'ar' ? 'فئات الجذب' : 'Attraction Categories',
              ['Historical', 'Museums', 'Shopping', 'Entertainment'],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(_currentLanguage == 'ar' ? 'إلغاء' : 'Cancel'),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/search-and-filter');
                    },
                    child: Text(_currentLanguage == 'ar' ? 'تطبيق' : 'Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              onSelected: (selected) {},
              backgroundColor: AppTheme.lightTheme.colorScheme.surface,
              selectedColor: AppTheme.lightTheme.colorScheme.primaryContainer,
              side: BorderSide(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _navigateToSearchAndFilter(String category) {
    Navigator.pushNamed(context, '/search-and-filter');
  }

  void _navigateToBusinessProfile(int businessId) {
    Navigator.pushNamed(context, '/business-profile');
  }

  void _toggleFavorite(String type, int id) {
    setState(() {
      if (type == 'restaurant') {
        final restaurant = _nearbyRestaurants.firstWhere((r) => r['id'] == id);
        restaurant['isFavorite'] =
            !(restaurant['isFavorite'] as bool? ?? false);
      } else if (type == 'tourism') {
        final attraction = _topTourismSpots.firstWhere((a) => a['id'] == id);
        attraction['isFavorite'] =
            !(attraction['isFavorite'] as bool? ?? false);
      }
    });
    HapticFeedback.lightImpact();
  }

  void _sharePlace(Map<String, dynamic> place) {
    final String name = _currentLanguage == 'ar'
        ? (place['nameAr'] as String? ?? place['name'] as String)
        : (place['name'] as String);

    // Simulate sharing functionality
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _currentLanguage == 'ar' ? 'تم مشاركة $name' : 'Shared $name',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _getDirections(Map<String, dynamic> place) {
    final String name = _currentLanguage == 'ar'
        ? (place['nameAr'] as String? ?? place['name'] as String)
        : (place['name'] as String);

    // Simulate getting directions
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _currentLanguage == 'ar'
              ? 'فتح الاتجاهات إلى $name'
              : 'Opening directions to $name',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onCuisineFilterChanged(String cuisineFilter) {
    setState(() {
      _selectedCuisineFilter = cuisineFilter;
    });

    // Provide haptic feedback
    HapticFeedback.selectionClick();

    // Here you can add logic to filter the restaurants based on selected cuisine
    // For now, we'll just show a snackbar to indicate the filter is applied
    if (cuisineFilter.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _currentLanguage == 'ar'
                ? 'تم تطبيق فلتر: $cuisineFilter'
                : 'Filter applied: $cuisineFilter',
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: AppTheme.lightTheme.colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(4.w),
        ),
      );
    }
  }
}
