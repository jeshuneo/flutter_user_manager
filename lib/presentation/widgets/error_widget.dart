import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryText;
  final IconData? icon;
  final String? title;

  const ErrorDisplayWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.retryText,
    this.icon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 80.w,
              color: Colors.red[300],
            ),
            SizedBox(height: 16.h),
            Text(
              title ?? 'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryText ?? 'Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
