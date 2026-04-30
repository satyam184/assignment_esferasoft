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
import 'trip_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 360;
    final isWide = screenWidth >= 700;
    final horizontalPadding = isWide ? 28.0 : isCompact ? 16.0 : 20.0;
    final contentMaxWidth = isWide ? 900.0 : screenWidth;
    final titleFontSize = isWide ? 30.0 : isCompact ? 22.0 : 24.0;
    final welcomeFontSize = isWide ? 18.0 : isCompact ? 14.0 : 16.0;
    final searchRadius = isWide ? 18.0 : isCompact ? 12.0 : 15.0;
    final topCircleSize = isWide ? 220.0 : isCompact ? 110.0 : 150.0;
    final bottomCircleSize = isWide ? 260.0 : isCompact ? 150.0 : 200.0;
    final listSpacing = isCompact ? 12.0 : 16.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'My Trips',
          style: AppStyles.heading.copyWith(fontSize: titleFontSize),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.mainBackground),
        child: Stack(
          children: [
            Positioned(
              top: isCompact ? 80 : 100,
              right: isCompact ? -20 : -30,
              child: Container(
                width: topCircleSize,
                height: topCircleSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentCircle1,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
            Positioned(
              bottom: isCompact ? 70 : 100,
              left: isCompact ? -30 : -50,
              child: Container(
                width: bottomCircleSize,
                height: bottomCircleSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentCircle2,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentMaxWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: isCompact ? 8 : 10),
                        Text(
                          'Welcome back, Explorer!',
                          style: AppStyles.subHeading.copyWith(
                            fontSize: welcomeFontSize,
                          ),
                        ),
                        SizedBox(height: isCompact ? 16 : 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(searchRadius),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: TextField(
                              onChanged: (value) {
                                context.read<TripBloc>().add(SearchTrips(value));
                              },
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: isCompact ? 14.0 : 16.0,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search your trips...',
                                hintStyle: TextStyle(
                                  color: AppColors.primaryText.withOpacity(0.4),
                                  fontSize: isCompact ? 14.0 : 16.0,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.secondaryText,
                                  size: isCompact ? 20.0 : 22.0,
                                ),
                                filled: true,
                                fillColor: AppColors.glassFill,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: isCompact ? 14 : 18,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    searchRadius,
                                  ),
                                  borderSide: BorderSide(
                                    color: AppColors.glassBorder,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    searchRadius,
                                  ),
                                  borderSide: BorderSide(
                                    color: AppColors.glassBorder,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    searchRadius,
                                  ),
                                  borderSide: const BorderSide(
                                    color: AppColors.completed,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: isCompact ? 20 : 24),
                        Expanded(
                          child: BlocBuilder<TripBloc, TripState>(
                            builder: (context, state) {
                              if (state.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.completed,
                                  ),
                                );
                              }

                              if (state.filteredTrips.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No trips found',
                                    style: AppStyles.subHeading.copyWith(
                                      fontSize: welcomeFontSize,
                                    ),
                                  ),
                                );
                              }

                              return ListView.separated(
                                padding: EdgeInsets.only(
                                  bottom: isCompact ? 24 : 40,
                                ),
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.filteredTrips.length,
                                separatorBuilder: (_, _) =>
                                    SizedBox(height: listSpacing),
                                itemBuilder: (context, index) {
                                  final trip = state.filteredTrips[index];
                                  return _TripCard(trip: trip);
                                },
                              );
                            },
                          ),
                        ),
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
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 360;
    final isWide = screenWidth >= 700;
    final cardRadius = isWide ? 24.0 : isCompact ? 16.0 : 20.0;
    final titleFontSize = isWide ? 20.0 : isCompact ? 16.0 : 18.0;
    final subtitleFontSize = isWide ? 14.0 : isCompact ? 12.0 : 13.0;
    final horizontalPadding = isWide ? 24.0 : isCompact ? 14.0 : 20.0;
    final verticalPadding = isWide ? 16.0 : isCompact ? 10.0 : 12.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(cardRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: AppStyles.glassDecoration.copyWith(
            borderRadius: BorderRadius.circular(cardRadius),
          ),
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              dense: isCompact,
              contentPadding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              title: Text(
                trip.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.label.copyWith(fontSize: titleFontSize),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: isCompact ? 12.0 : 14.0,
                      color: AppColors.secondaryText,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        trip.date,
                        style: AppStyles.subHeading.copyWith(
                          fontSize: subtitleFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: TripStatusChip(status: trip.status),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TripDetailsScreen(trip: trip),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
