import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/property_provider.dart';
import '../widgets/category_item.dart';
import '../widgets/property_card.dart';
import '../widgets/filter_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Modern Search Bar
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.white,
              elevation: 0,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(Icons.search, color: Colors.pink),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              context
                                  .read<PropertyProvider>()
                                  .searchProperties(value);
                            },
                            decoration: InputDecoration(
                              hintText: 'Where to?',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.tune),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => const FilterBottomSheet(),
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

            // Categories Section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16, bottom: 12),
                    child: Text(
                      'Explore nearby',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        CategoryItem(
                          icon: Icons.home,
                          label: 'Tiny homes',
                          color: Colors.pink,
                          isSelected: _selectedCategory == 'Tiny homes',
                          onTap: () => _selectCategory('Tiny homes'),
                        ),
                        CategoryItem(
                          icon: Icons.star,
                          label: 'Icons',
                          color: Colors.orange,
                          isSelected: _selectedCategory == 'Icons',
                          onTap: () => _selectCategory('Icons'),
                        ),
                        CategoryItem(
                          icon: Icons.house_siding,
                          label: 'Lakefront',
                          color: Colors.blue,
                          isSelected: _selectedCategory == 'Lakefront',
                          onTap: () => _selectCategory('Lakefront'),
                        ),
                        CategoryItem(
                          icon: Icons.park,
                          label: 'Treehouses',
                          color: Colors.green,
                          isSelected: _selectedCategory == 'Treehouses',
                          onTap: () => _selectCategory('Treehouses'),
                        ),
                        CategoryItem(
                          icon: Icons.location_city,
                          label: 'Top cities',
                          color: Colors.purple,
                          isSelected: _selectedCategory == 'Top cities',
                          onTap: () => _selectCategory('Top cities'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Properties List
            Consumer<PropertyProvider>(
              builder: (context, provider, child) {
                final properties = provider.properties;
                return properties.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No properties found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: PropertyCard(property: properties[index]),
                          ),
                          childCount: properties.length,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.search, size: 28),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite, size: 28),
              label: 'Wishlists',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airplanemode_active),
              activeIcon: Icon(Icons.airplanemode_active, size: 28),
              label: 'Trips',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              activeIcon: Icon(Icons.message, size: 28),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = _selectedCategory == category ? '' : category;
    });
    context.read<PropertyProvider>().selectCategory(category);
  }
}
