class Product {
  final String productId;
  final String productName;
  final int price;
  final int everStarCount;
  final int dailyStarCount;

  Product.fromJson(Map<String, dynamic> map)
      : this.productId = map['productId'],
        this.productName = map['productName'],
        this.price = map['price'],
        this.everStarCount = map['everStarCount'],
        this.dailyStarCount = map['dailyStarCount'];
  toMap() {
    return {
      'productId': this.productId,
      'productName': this.productName,
      'price': this.price,
      'everStarCount': this.everStarCount,
      'dailyStarCount': this.dailyStarCount,
    };
  }
}
