class Course {
  String? _id;
  String? _name;
  String? _categoryId;
  String? _description;
  String? _imageUrl;
  int? _amount;
  double? _percentOfLike;
  double? _price;

  Course(
    this._id,
    this._name,
    this._categoryId,
    this._description,
    this._imageUrl,
    this._amount,
    this._percentOfLike,
    this._price,
  );

  Course.fromJson(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _categoryId = map['categoryId'];
    _description = map['description'];
    _amount = map['amount'];
    _percentOfLike = map['percentOfLike'];
    _price = map['price'];
    _imageUrl = map['imageUrl'];
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'categoryId': _categoryId,
        'description': _description,
        'amount': _amount,
        'percentOfLike': _percentOfLike,
        'price': _price,
        'imageUrl': _imageUrl,
      };

  double get price => _price!;

  double get percentOfLike => _percentOfLike!;

  int get amount => _amount!;

  String get imageUrl => _imageUrl!;

  String get description => _description!;

  String get categoryId => _categoryId!;

  String get name => _name!;

  String get id => _id!;
}
