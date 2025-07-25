import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 8.h),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: user.status == 'active' ? Colors.green : Colors.grey,
          child: Text(
            user.name.substring(0, 1).toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ),
        title: Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email, style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 4.h),
            Row(
              children: [
                _buildChip(
                  user.gender.toUpperCase(),
                  user.gender == 'male' ? Colors.blue : Colors.pink,
                ),
                SizedBox(width: 8.w),
                _buildChip(
                  user.status.toUpperCase(),
                  user.status == 'active' ? Colors.green : Colors.grey,
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
