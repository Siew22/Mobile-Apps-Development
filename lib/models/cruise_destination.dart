class CruiseDestination {
  final String name;
  final String location;
  final String landmarkLabel;
  final String description;
  final String imageUrl;
  int starCount;
  bool isFavorite;

  CruiseDestination({
    required this.name,
    required this.location,
    required this.landmarkLabel,
    required this.description,
    required this.imageUrl,
    required this.starCount,
    this.isFavorite = false,
  });
}