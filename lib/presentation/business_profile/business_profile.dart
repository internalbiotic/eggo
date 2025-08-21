import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/business_header_widget.dart';
import './widgets/business_info_widget.dart';
import './widgets/location_map_widget.dart';
import './widgets/operating_hours_widget.dart';
import './widgets/photo_gallery_widget.dart';
import './widgets/reviews_section_widget.dart';

class BusinessProfile extends StatefulWidget {
  const BusinessProfile({Key? key}) : super(key: key);

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  late ScrollController _scrollController;
  bool _isOfflineMode = false;

  // Mock business data
  final Map<String, dynamic> _businessData = {
    "id": 1,
    "name": "Koshary Abou Tarek",
    "nameArabic": "كشري أبو طارق",
    "category": "Egyptian Restaurant",
    "categoryArabic": "مطعم مصري",
    "headerImage":
        "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "rating": 4.5,
    "reviewCount": 1247,
    "priceRange": "\$\$ - \$\$\$",
    "distance": 1.2,
    "isVerified": true,
    "phone": "+20 2 2575 1962",
    "address": "16 Champollion St, Downtown Cairo, Cairo Governorate, Egypt",
    "latitude": 30.0444,
    "longitude": 31.2357,
    "description":
        """Experience authentic Egyptian cuisine at Koshary Abou Tarek, Cairo's most famous koshary restaurant since 1950. Located in the heart of Downtown Cairo, we serve traditional Egyptian comfort food made with the finest ingredients and time-honored recipes passed down through generations.

Our signature koshary combines rice, lentils, chickpeas, and pasta topped with crispy fried onions and our secret spicy tomato sauce. Every bowl is prepared fresh daily using locally sourced ingredients from Egyptian farms.

Visit us to taste the flavors that have made us a Cairo institution for over 70 years. Our warm hospitality and authentic atmosphere will transport you to the heart of Egyptian culinary tradition.""",
    "menuItems": [
      {
        "name": "Traditional Koshary",
        "description":
            "Rice, lentils, chickpeas, pasta with spicy tomato sauce and crispy onions",
        "price": "EGP 25"
      },
      {
        "name": "Koshary Supreme",
        "description":
            "Our signature koshary with extra toppings and premium ingredients",
        "price": "EGP 35"
      },
      {
        "name": "Fattah with Meat",
        "description":
            "Traditional Egyptian dish with rice, bread, and tender meat",
        "price": "EGP 45"
      },
      {
        "name": "Molokhia",
        "description":
            "Traditional green soup served with rice and your choice of meat",
        "price": "EGP 40"
      }
    ],
    "amenities": [
      "Free WiFi",
      "Air Conditioning",
      "Takeaway",
      "Family Friendly",
      "Cash Only",
      "Local Ingredients"
    ],
    "operatingHours": {
      "Monday": {"open": "11:00 AM", "close": "11:00 PM"},
      "Tuesday": {"open": "11:00 AM", "close": "11:00 PM"},
      "Wednesday": {"open": "11:00 AM", "close": "11:00 PM"},
      "Thursday": {"open": "11:00 AM", "close": "11:00 PM"},
      "Friday": {"open": "11:00 AM", "close": "12:00 AM"},
      "Saturday": {"open": "11:00 AM", "close": "12:00 AM"},
      "Sunday": {"open": "12:00 PM", "close": "10:00 PM"}
    },
    "photos": [
      "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/1640772/pexels-photo-1640772.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/1640773/pexels-photo-1640773.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    ],
    "reviews": [
      {
        "id": 1,
        "userName": "Ahmed Hassan",
        "userAvatar":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
        "rating": 5,
        "date": "2 days ago",
        "comment":
            "Absolutely amazing! The best koshary in Cairo. The flavors are incredible and the service is excellent. This place truly represents authentic Egyptian cuisine at its finest.",
        "photos": [
          "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        ]
      },
      {
        "id": 2,
        "userName": "Sarah Mohamed",
        "userAvatar":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
        "rating": 4,
        "date": "1 week ago",
        "comment":
            "Great traditional food and very authentic atmosphere. The koshary was delicious and the portions are generous. Definitely coming back!",
        "photos": []
      },
      {
        "id": 3,
        "userName": "Mark Johnson",
        "userAvatar":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
        "rating": 5,
        "date": "2 weeks ago",
        "comment":
            "As a tourist, this was exactly what I was looking for - authentic Egyptian food in a local setting. The staff was friendly and helped me understand the menu. Highly recommended!",
        "photos": [
          "https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        ]
      }
    ],
    "lastUpdated": "2025-08-19 22:30:00"
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _checkConnectivity();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _checkConnectivity() {
    // Simulate connectivity check
    setState(() {
      _isOfflineMode = false; // Set to true to test offline mode
    });
  }

  void _onBackPressed() {
    HapticFeedback.lightImpact();
    Navigator.pop(context);
  }

  void _onSharePressed() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share functionality would open here'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onWriteReview() {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/write-review');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          BusinessHeaderWidget(
            businessData: _businessData,
            onBackPressed: _onBackPressed,
            onSharePressed: _onSharePressed,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionButtonsWidget(businessData: _businessData),
                SizedBox(height: 2.h),
                PhotoGalleryWidget(
                  photos:
                      (_businessData['photos'] as List<dynamic>).cast<String>(),
                ),
                SizedBox(height: 2.h),
                BusinessInfoWidget(businessData: _businessData),
                SizedBox(height: 2.h),
                OperatingHoursWidget(businessData: _businessData),
                SizedBox(height: 2.h),
                LocationMapWidget(businessData: _businessData),
                SizedBox(height: 2.h),
                ReviewsSectionWidget(
                  businessData: _businessData,
                  onWriteReview: _onWriteReview,
                ),
                if (_isOfflineMode) ...[
                  Container(
                    margin: EdgeInsets.all(4.w),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'wifi_off',
                          color: Colors.orange,
                          size: 5.w,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Offline Mode',
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(
                                  color: Colors.orange.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Last updated: ${_businessData['lastUpdated']}',
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: Colors.orange.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onWriteReview,
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        child: CustomIconWidget(
          iconName: 'rate_review',
          color: Colors.white,
          size: 6.w,
        ),
      ),
    );
  }
}
