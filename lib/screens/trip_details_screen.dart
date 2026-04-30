import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/trip_bloc.dart';
import '../bloc/trip_event.dart';
import '../bloc/trip_state.dart';
import '../models/trip.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../widgets/trip_status_chip.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 360;
    final isWide = screenWidth >= 700;
    final useStackedHeader = screenWidth < 480;
    final horizontalPadding = isWide ? 28.0 : isCompact ? 16.0 : 20.0;
    final contentMaxWidth = isWide ? 760.0 : screenWidth;
    final cardRadius = isCompact ? 20.0 : 24.0;
    final cardPadding = isWide ? 32.0 : isCompact ? 18.0 : 24.0;
    final appBarFontSize = isWide ? 30.0 : isCompact ? 22.0 : 24.0;
    final tripTitleFontSize = isWide ? 26.0 : isCompact ? 20.0 : 22.0;
    final circleSize = isWide ? 220.0 : isCompact ? 120.0 : 180.0;

    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        final currentTrip = _findTrip(state);
        final canChangeStatus = currentTrip.status == TripStatus.booked;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              'Trip Details',
              style: AppStyles.heading.copyWith(fontSize: appBarFontSize),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.primaryText,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(gradient: AppColors.mainBackground),
            child: Stack(
              children: [
                Positioned(
                  top: isCompact ? 110 : 150,
                  left: isCompact ? -25 : -40,
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentCircle1,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: isCompact ? 35 : 50,
                        sigmaY: isCompact ? 35 : 50,
                      ),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentMaxWidth),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: isCompact ? 8 : 10,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(cardRadius),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(cardPadding),
                                  decoration: AppStyles.glassDecoration.copyWith(
                                    borderRadius: BorderRadius.circular(
                                      cardRadius,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (useStackedHeader) ...[
                                        Text(
                                          currentTrip.title,
                                          style: AppStyles.heading.copyWith(
                                            fontSize: tripTitleFontSize,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: TripStatusChip(
                                            status: currentTrip.status,
                                          ),
                                        ),
                                      ] else
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                currentTrip.title,
                                                style:
                                                    AppStyles.heading.copyWith(
                                                  fontSize: tripTitleFontSize,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            TripStatusChip(
                                              status: currentTrip.status,
                                            ),
                                          ],
                                        ),
                                      SizedBox(height: isCompact ? 18 : 24),
                                      _buildDetailItem(
                                        context,
                                        label: 'Trip ID',
                                        value: currentTrip.id.toString(),
                                      ),
                                      _buildDetailItem(
                                        context,
                                        label: 'Title',
                                        value: currentTrip.title,
                                      ),
                                      _buildDetailItem(
                                        context,
                                        label: 'Date',
                                        value: currentTrip.date,
                                      ),
                                      _buildDetailItem(
                                        context,
                                        label: 'Pickup',
                                        value: currentTrip.pickup,
                                      ),
                                      _buildDetailItem(
                                        context,
                                        label: 'Drop',
                                        value: currentTrip.drop,
                                      ),
                                      _buildDetailItem(
                                        context,
                                        label: 'Status',
                                        value: currentTrip.status,
                                        showDivider: false,
                                      ),
                                      SizedBox(height: isCompact ? 20 : 24),
                                      Text(
                                        'Change Status',
                                        style: AppStyles.label.copyWith(
                                          fontSize:
                                              isWide ? 17.0 : isCompact
                                                  ? 15.0
                                                  : 16.0,
                                        ),
                                      ),
                                      SizedBox(height: isCompact ? 10 : 12),
                                      if (canChangeStatus)
                                        _buildStatusDropdown(
                                          context,
                                          currentTrip,
                                        )
                                      else
                                        _buildStatusInfo(context),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: isCompact ? 28 : 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Trip _findTrip(TripState state) {
    for (final item in state.trips) {
      if (item.id == trip.id) {
        return item;
      }
    }

    return trip;
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required String label,
    required String value,
    bool showDivider = true,
  }) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 360;
    final isWide = screenWidth >= 700;

    return Padding(
      padding: EdgeInsets.only(bottom: isCompact ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.subHeading.copyWith(
              fontSize: isWide ? 13.0 : isCompact ? 11.0 : 12.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppStyles.label.copyWith(
              fontSize: isWide ? 17.0 : isCompact ? 15.0 : 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (showDivider) ...[
            SizedBox(height: isCompact ? 12 : 16),
            const Divider(color: AppColors.glassBorder, height: 1),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusDropdown(BuildContext context, Trip currentTrip) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 360;
    final isWide = screenWidth >= 700;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isCompact ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: BorderRadius.circular(isCompact ? 10 : 12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          initialValue: null,
          isExpanded: true,
          dropdownColor: const Color(0xFF012622),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.secondaryText,
            size: isCompact ? 20.0 : 24.0,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: isCompact ? 2 : 4,
            ),
          ),
          hint: Text(
            'Select new status',
            style: AppStyles.subHeading.copyWith(
              fontSize: isWide ? 16.0 : isCompact ? 14.0 : 15.0,
            ),
          ),
          style: AppStyles.label.copyWith(
            fontSize: isWide ? 16.0 : isCompact ? 14.0 : 15.0,
          ),
          items: const [
            DropdownMenuItem(
              value: TripStatus.completed,
              child: Text(TripStatus.completed),
            ),
            DropdownMenuItem(
              value: TripStatus.cancelled,
              child: Text(TripStatus.cancelled),
            ),
          ],
          onChanged: (value) {
            if (value == null) {
              return;
            }

            context.read<TripBloc>().add(
                  UpdateTripStatus(
                    tripId: currentTrip.id,
                    status: value,
                  ),
                );
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _buildStatusInfo(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 360;
    final isWide = screenWidth >= 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isCompact ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: BorderRadius.circular(isCompact ? 10 : 12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.secondaryText,
            size: isCompact ? 18.0 : 20.0,
          ),
          SizedBox(width: isCompact ? 10 : 12),
          Expanded(
            child: Text(
              'Only booked trips can be changed to Completed or Cancelled.',
              style: AppStyles.subHeading.copyWith(
                fontSize: isWide ? 16.0 : isCompact ? 13.0 : 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
