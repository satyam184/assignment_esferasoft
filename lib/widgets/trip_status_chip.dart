import 'package:flutter/material.dart';

import '../models/trip.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class TripStatusChip extends StatelessWidget {
  const TripStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 360;
    final isWide = screenWidth >= 700;
    final statusColor = _getStatusColor(status);
    final horizontalPadding = isWide ? 14.0 : isCompact ? 10.0 : 12.0;
    final verticalPadding = isWide ? 7.0 : isCompact ? 5.0 : 6.0;
    final fontSize = isWide ? 11.0 : isCompact ? 9.0 : 10.0;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(isWide ? 22.0 : 20.0),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppStyles.label.copyWith(
          color: statusColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Color _getStatusColor(String value) {
    switch (value) {
      case TripStatus.completed:
        return AppColors.completed;
      case TripStatus.cancelled:
        return AppColors.cancelled;
      case TripStatus.booked:
      default:
        return AppColors.booked;
    }
  }
}
