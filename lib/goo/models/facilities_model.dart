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
