import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final Set<String> _selectedAmenities = {};
  final Set<String> _selectedBookingOptions = {};

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),

              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    // Amenities Section
                    Text(
                      'Amenities',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildFilterChip(
                          label: 'Washer',
                          icon: Icons.local_laundry_service,
                          isAmenity: true,
                        ),
                        _buildFilterChip(
                          label: 'Wifi',
                          icon: Icons.wifi,
                          isAmenity: true,
                        ),
                        _buildFilterChip(
                          label: 'Air conditioning',
                          icon: Icons.ac_unit,
                          isAmenity: true,
                        ),
                        _buildFilterChip(
                          label: 'Dryer',
                          icon: Icons.dry_cleaning,
                          isAmenity: true,
                        ),
                        _buildFilterChip(
                          label: 'Hot tub',
                          icon: Icons.hot_tub,
                          isAmenity: true,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Show more',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Divider(height: 32),

                    // Booking Options Section
                    Text(
                      'Booking options',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildFilterChip(
                          label: 'Instant Book',
                          icon: Icons.bolt,
                          isAmenity: false,
                        ),
                        _buildFilterChip(
                          label: 'Self check-in',
                          icon: Icons.key,
                          isAmenity: false,
                        ),
                        _buildFilterChip(
                          label: 'Free cancellation',
                          icon: Icons.calendar_today,
                          isAmenity: false,
                        ),
                        _buildFilterChip(
                          label: 'Allows pets',
                          icon: Icons.pets,
                          isAmenity: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Standout Stays Section
                    Text(
                      'Standout stays',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStandoutStayTile(
                      'Guest favorite',
                      'Homes that guests love for their location, cleanliness, and more',
                    ),
                  ],
                ),
              ),

              // Bottom Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedAmenities.clear();
                          _selectedBookingOptions.clear();
                        });
                      },
                      child: Text(
                        'Clear all',
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Implement filter logic
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Show 37 homes',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, letterSpacing: -0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required bool isAmenity,
  }) {
    final isSelected = isAmenity
        ? _selectedAmenities.contains(label)
        : _selectedBookingOptions.contains(label);

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: isSelected ? Colors.white : Colors.grey.shade900,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (isAmenity) {
            if (selected) {
              _selectedAmenities.add(label);
            } else {
              _selectedAmenities.remove(label);
            }
          } else {
            if (selected) {
              _selectedBookingOptions.add(label);
            } else {
              _selectedBookingOptions.remove(label);
            }
          }
        });
      },
      backgroundColor: Colors.white,
      selectedColor: Colors.black,
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(
          color: isSelected ? Colors.black : Colors.grey[300]!,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildStandoutStayTile(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.star, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
