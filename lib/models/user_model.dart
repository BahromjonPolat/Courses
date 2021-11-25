class UserModel {
  String? _id;
  String? _fullName;
  String? _email;
  String? _password;
  String? _imageUrl;
  String? _role;
  bool? _isOnline;
  DateTime? _firstTime;
  DateTime? _lastSeen;

  UserModel(
    this._id,
    this._fullName,
    this._email,
    this._password,
    this._imageUrl,
    this._role,
    this._isOnline,
    this._firstTime,
    this._lastSeen,
  );

  UserModel.fromJson(Map<String, dynamic> map) {
    _id = map['id'];
    _fullName = map['fullName'];
    _email = map['email'];
    _password = map['password'];
    _role = map['role'];
    _imageUrl = map['imageUrl'];
    _isOnline = map['isOnline'];
    _firstTime = map['firstTime'];
    _lastSeen = map['lastSeen'];
  }

  Map<String, dynamic> toMap() => {
    'id': _id,
    'fullName': _fullName,
    'email': _email,
    'password': _password,
    'imageUrl': _imageUrl,
    'isOnline': _isOnline,
    'firstTime': _firstTime,
    'lastSeen': _lastSeen,
    'role': _role,

  };

  DateTime get lastSeen => _lastSeen!;

  DateTime get firstTime => _firstTime!;

  bool get isOnline => _isOnline!;

  String get role => _role!;

  String get imageUrl => _imageUrl!;

  String get password => _password!;

  String get email => _email!;

  String get fullName => _fullName!;

  String get id => _id!;
}
