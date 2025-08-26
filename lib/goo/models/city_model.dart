class CityModel {
  final String name;
  final String description;
  final double rating;
  final int reviews;
  final String assetPath;
  final double price;
  final List<FacilitiesModel> facilites;

  CityModel(
      {required this.name,
      required this.description,
      required this.rating,
      required this.reviews,
      required this.assetPath,
      required this.price,
      required this.facilites});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
        name: json['name'],
        description: json['description'],
        rating: json['rating'],
        reviews: json['reviews'],
        assetPath: json['image'],
        price: json['price'],
        facilites: FacilitiesModel.fromJsonToList(json['facilities']));
  }

  static List<CityModel> fromJsonToList(List<dynamic> jsonList) {
    return jsonList.map((json) => CityModel.fromJson(json)).toList();
  }
}

class FacilitiesModel {
  final String name;
  final int? quantity;
  final String iconPath;

  FacilitiesModel(
      {required this.name, required this.quantity, required this.iconPath});

  factory FacilitiesModel.fromJson(Map<String, dynamic> json) {
    return FacilitiesModel(
        name: json['name'], quantity: json['quantity'], iconPath: json['icon']);
  }

  static List<FacilitiesModel> fromJsonToList(List<dynamic> jsonList) {
    return jsonList.map((json) => FacilitiesModel.fromJson(json)).toList();
  }
}
