class Property {
  final String id;
  final String title;
  final String location;
  final double price;
  final List<String> images;
  final double rating;
  final double distance;
  final bool isFavorite;
  final int guests;
  final int bedrooms;
  final int beds;
  final int baths;
  final int reviews;
  final String hostName;
  final int hostingYears;
  final bool isSuperhost;
  final String category;
  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.images,
    required this.rating,
    required this.distance,
    this.isFavorite = false,
    this.guests = 4,
    this.bedrooms = 2,
    this.beds = 2,
    this.baths = 2,
    this.reviews = 239,
    this.hostName = 'Ozlem',
    this.hostingYears = 3,
    this.isSuperhost = true,
    required this.category,
  });

  Property copyWith({
    String? id,
    String? title,
    String? location,
    double? price,
    List<String>? images,
    double? rating,
    double? distance,
    bool? isFavorite,
    int? guests,
    int? bedrooms,
    int? beds,
    int? baths,
    int? reviews,
    String? hostName,
    int? hostingYears,
    bool? isSuperhost,
    String? category,
  }) {
    return Property(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      price: price ?? this.price,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      distance: distance ?? this.distance,
      isFavorite: isFavorite ?? this.isFavorite,
      guests: guests ?? this.guests,
      bedrooms: bedrooms ?? this.bedrooms,
      beds: beds ?? this.beds,
      baths: baths ?? this.baths,
      reviews: reviews ?? this.reviews,
      hostName: hostName ?? this.hostName,
      hostingYears: hostingYears ?? this.hostingYears,
      isSuperhost: isSuperhost ?? this.isSuperhost,
      category: category ?? this.category,
    );
  }
}
