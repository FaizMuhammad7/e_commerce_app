class CateGoryModel {
  String categoryId, categoryN, createdAt, updatedOn, categoryImage;

  CateGoryModel({
    required this.categoryId,
    required this.categoryN,
    required this.createdAt,
    required this.updatedOn,
    required this.categoryImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': this.categoryId,
      'categoryN': this.categoryN,
      'createdAt': this.createdAt,
      'updatedOn': this.updatedOn,
      'categoryImage': this.categoryImage,
    };
  }

  factory CateGoryModel.fromMap(Map<String, dynamic> map) {
    return CateGoryModel(
      categoryId: map['categoryId'] as String,
      categoryN: map['categoryN'] as String,
      createdAt: map['createdAt'] as String,
      updatedOn: map['updatedOn'] as String,
      categoryImage: map['categoryImage'] as String,
    );
  }
}
