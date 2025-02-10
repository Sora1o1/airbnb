import 'package:airbnb/widgets/filter_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/property.dart';

class PropertyProvider with ChangeNotifier {
  final List<Property> _allProperties = [
    Property(
      id: '1',
      title: 'A-Frame Cabin',
      location: 'Berkeley Springs, West Virginia',
      price: 299.2,
      images: ['assets/images/cabin.jpg'],
      rating: 4.29,
      distance: 56,
      category: 'Tiny homes',
    ),
    Property(
        id: '2',
        title: 'A-beautiful Cabin',
        location: 'Great Cacapon, West Virginia',
        price: 142.2,
        images: ['assets/images/beutiy.jpg'],
        rating: 4.89,
        distance: 56,
        category: 'Icons'),
    Property(
        id: '3',
        title: 'A-beautiful Apartment',
        location: 'Great Cacapon, West Virginia',
        price: 432.2,
        images: ['assets/images/cabin2.jpg'],
        rating: 4.69,
        distance: 56,
        category: 'Lakefront'),
    // Property(
    //     id: '4',
    //     title: 'A-beautiful Cabin',
    //     location: 'Great Cacapon, West Virginia',
    //     price: 331.2,
    //     images: ['assets/images/cabin1.jpg'],
    //     rating: 4.99,
    //     distance: 56,
    //     category: 'Lakefront'),
    // Property(
    //     id: '5',
    //     title: 'A-beautiful Cabin',
    //     location: 'Great Cacapon, West Virginia',
    //     price: 331.2,
    //     images: ['assets/images/treehouses.jpg'],
    //     rating: 4.99,
    //     distance: 56,
    //     category: 'Treehouses'),
    // Add more properties here
  ];
  List<Property> _properties = [];
  String _searchQuery = '';
  String _selectedCategory = '';
  bool _isLoading = false;

  PropertyProvider() {
    _properties = [..._allProperties];
  }

  List<Property> get properties => _properties;
  bool get isLoading => _isLoading;

  void searchProperties(String query) {
    _searchQuery = query.toLowerCase();
    _filterProperties();
  }

  Future<void> selectCategory(String category) async {
    _selectedCategory = category == _selectedCategory ? '' : category;
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    _filterProperties();
    _isLoading = false;
    notifyListeners();
  }

  void _filterProperties() {
    _properties = _allProperties.where((property) {
      bool matchesSearch = _searchQuery.isEmpty ||
          property.title.toLowerCase().contains(_searchQuery) ||
          property.location.toLowerCase().contains(_searchQuery);

      bool matchesCategory =
          _selectedCategory.isEmpty || property.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    notifyListeners();
  }

  void showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }
}
