class ProductModel {
  String productId, productName, categoryId, categoryName;
  String productPrice, productImage, productDes, pDeliveryTime;
  String createAt, updateOn, pQuantity;
  bool isSale, isFavorite;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.categoryId,
    required this.categoryName,
    required this.productPrice,
    required this.productImage,
    required this.productDes,
    required this.pDeliveryTime,
    required this.createAt,
    required this.updateOn,
    required this.pQuantity,
    required this.isSale,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'productName': this.productName,
      'categoryId': this.categoryId,
      'categoryName': this.categoryName,
      'productPrice': this.productPrice,
      'productImage': this.productImage,
      'productDes': this.productDes,
      'pDeliveryTime': this.pDeliveryTime,
      'createAt': this.createAt,
      'updateOn': this.updateOn,
      'pQuantity': this.pQuantity,
      'isSale': this.isSale,
      'isFavorite': this.isFavorite,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      productPrice: map['productPrice'] as String,
      productImage: map['productImage'] as String,
      productDes: map['productDes'] as String,
      pDeliveryTime: map['pDeliveryTime'] as String,
      createAt: map['createAt'] as String,
      updateOn: map['updateOn'] as String,
      pQuantity: map['pQuantity'] as String,
      isSale: map['isSale'] as bool,
      isFavorite: map['isFavorite'] as bool,
    );
  }
}
