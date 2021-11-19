class Course {
  String? _id;
  String? _name;
  String? _categoryId;
  String? _description;
  int? _amount;
  double? _percentOfLike;
  double? _price;

  Course(
    this._id,
    this._name,
    this._categoryId,
    this._description,
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
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'categoryId': _categoryId,
        'description': _description,
        'amount': _amount,
        'percentOfLike': _percentOfLike,
        'price': _price,
      };
}
