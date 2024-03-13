class CartModel {
  String productId, categoryId, productN, categoryN, productPr;
  String productImage, deliveryTime, createdAt, updateOn;
  int productQ; double productTotalPrice;

//<editor-fold desc="Data Methods">
  CartModel({
    required this.productId,
    required this.categoryId,
    required this.productN,
    required this.categoryN,
    required this.productPr,
    required this.productImage,
    required this.deliveryTime,
    required this.createdAt,
    required this.updateOn,
    required this.productQ,
    required this.productTotalPrice,
  });


  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'categoryId': this.categoryId,
      'productN': this.productN,
      'categoryN': this.categoryN,
      'productPr': this.productPr,
      'productImage': this.productImage,
      'deliveryTime': this.deliveryTime,
      'createdAt': this.createdAt,
      'updateOn': this.updateOn,
      'productQ': this.productQ,
      'productTotalPrice': this.productTotalPrice,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'] as String,
      categoryId: map['categoryId'] as String,
      productN: map['productN'] as String,
      categoryN: map['categoryN'] as String,
      productPr: map['productPr'] as String,
      productImage: map['productImage'] as String,
      deliveryTime: map['deliveryTime'] as String,
      createdAt: map['createdAt'] as String,
      updateOn: map['updateOn'] as String,
      productQ: map['productQ'] as int,
      productTotalPrice: map['productTotalPrice'] as double,
    );
  }

//</editor-fold>
}
