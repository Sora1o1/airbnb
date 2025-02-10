import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/property.dart';

class DetailScreen extends StatefulWidget {
  final Property property;

  const DetailScreen({
    super.key,
    required this.property,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;
  @override
  void initState() {
    super.initState();
    _isFavorite = widget
        .property.isFavorite; // Initialize with property's favorite status
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  int _currentImageIndex = 0;

  void _showPriceDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                 Text(
                  'Price details',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600,

                  ),
                ),
                const SizedBox(height: 32),

                // Price breakdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${widget.property.price} × 5 nights',
                      style:  GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline
                      ),
                    ),
                    Text(
                      '\$${(widget.property.price * 5).toStringAsFixed(0)}',
                      style:GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Airbnb service fee',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline
                      ),
                    ),
                    Text('\$204', style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,

                    ),),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),

                // Total
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total before taxes',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,

                      ),
                    ),
                    Text(
                      '\$1,649',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Dates section
                 Text(
                  'Dates',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,

                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Feb 4 - 9',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Free cancellation before Jan 5',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child:  Text(
                        'Change',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          decoration: TextDecoration.underline
                        )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Reserve button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:  Text(
                      'Reserve',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content
          CustomScrollView(
            slivers: [
              // Image and App Bar
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                backgroundColor: Colors.black,
                pinned: true,
                leading: _buildCircularButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
                actions: [
                  _buildCircularButton(
                    icon: Icons.ios_share_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _buildCircularButton(
                    icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                    onTap: _toggleFavorite,
                    iconColor: _isFavorite
                        ? Colors.red
                        : Colors.black87, // Change color based on state
                  ),
                  const SizedBox(width: 16),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: double.infinity,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                        ),
                        items: widget.property.images.map((imageUrl) {
                          return Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      ),
                      // Image Counter
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_currentImageIndex + 1}/${widget.property.images.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Property Details
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.property.title,
                        style:  GoogleFonts.poppins(
                          fontSize: 26,
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.5
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Location
                      Text(
                        widget.property.location,
                        style:  GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                      const SizedBox(height: 4),

                      // Capacity
                      Text(
                        '${widget.property.guests} guests · ${widget.property.bedrooms} bedrooms · ${widget.property.beds} beds · ${widget.property.baths} baths',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w300,

                        ),
                      ),
                      const SizedBox(height: 24),

                      // Ratings and Reviews
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildRatingItem(
                              title: widget.property.rating.toString(),
                              subtitle: 'Rating',
                              icon: Icons.star,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.grey.shade200,
                            ),
                            _buildRatingItem(
                              title: 'Guest',
                              subtitle: 'favorite',
                              icon: Icons.favorite,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.grey.shade200,
                            ),
                            _buildRatingItem(
                              title: widget.property.reviews.toString(),
                              subtitle: 'Reviews',
                              icon: Icons.rate_review_outlined,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Rare Find Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.pink.shade50,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.diamond_outlined,
                              color: Colors.pink.shade400,
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    'This is a rare find',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.w600,

                                    ),
                                  ),
                                  Text(
                                    "${widget.property.hostName}'s place is usually fully booked",
                                    style: GoogleFonts.poppins(

                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -0.5

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Host Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.shade200,
                              child: const Icon(
                                Icons.person,
                                size: 32,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hosted by ${widget.property.hostName}',
                                    style:  GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.w600,

                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Superhost · ${widget.property.hostingYears} years hosting',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -0.5

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 100), // Bottom padding for reserve button
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Reserve Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$${widget.property.price}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.w600,

                        ),
                      ),
                       Text(
                        'night',
                        style:GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _showPriceDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:  Text(
                      'Reserve',
                      style: GoogleFonts.poppins(
                        fontSize: 16,

                        fontWeight: FontWeight.w400,

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.black87, // Add default color parameter
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onTap,
        color: iconColor, // Use the passed color
      ),
    );
  }

  Widget _buildRatingItem({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(
              title,
              style:  GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade900,
                fontWeight: FontWeight.w600,

              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style:  GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w300,

          ),
        ),
      ],
    );
  }
}
