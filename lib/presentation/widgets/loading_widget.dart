import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final double? size;
  final Color? color;

  const LoadingWidget({super.key, this.message, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size ?? 50.w,
            height: size ?? 50.w,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? Theme.of(context).primaryColor,
              ),
              strokeWidth: 3.w,
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 16.h),
            Text(
              message!,
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
