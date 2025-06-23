import 'package:api/features/home/data/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Using a placeholder for the image since the actual images were deleted.
            // In a real app, this would be a network image.
            Image.asset(restaurant.imageUrl,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 150.h,
                color: Colors.grey[200],
                child: const Center(child: Text('Image not found')),
              );
            }),
            SizedBox(height: 10.h),
            Text(restaurant.name,
                style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price: ${restaurant.price}'),
                Text(restaurant.distance),
              ],
            ),
            SizedBox(height: 5.h),
            Text('Pickup: ${restaurant.pickupTime}'),
          ],
        ),
      ),
    );
  }
} 