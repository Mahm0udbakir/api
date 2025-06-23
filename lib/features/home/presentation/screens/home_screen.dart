import 'package:api/features/home/data/models/restaurant_model.dart';
import 'package:api/features/home/presentation/widgets/app_drawer.dart';
import 'package:api/features/home/presentation/widgets/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data based on your user stories
    final List<Restaurant> restaurants = [
      Restaurant(
          name: 'The Green Leaf',
          distance: '0.5 mi',
          price: '\$5.99',
          pickupTime: '4:00 PM - 6:00 PM',
          imageUrl: 'assets/images/restaurant1.jpg'),
      Restaurant(
          name: 'Urban Bites',
          distance: '1.2 mi',
          price: '\$7.50',
          pickupTime: '5:00 PM - 7:00 PM',
          imageUrl: 'assets/images/restaurant2.jpg'),
      Restaurant(
          name: 'Pasta Paradise',
          distance: '2.0 mi',
          price: '\$8.00',
          pickupTime: '6:00 PM - 8:00 PM',
          imageUrl: 'assets/images/restaurant3.jpg'),
    ];

    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Nearby Deals'),
            floating: true,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // TODO: Navigate to Filter/Sort screen
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(150.h),
              child:
                  const Placeholder(), // Placeholder for the map view
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return RestaurantCard(restaurant: restaurants[index]);
              },
              childCount: restaurants.length,
            ),
          ),
        ],
      ),
    );
  }
} 