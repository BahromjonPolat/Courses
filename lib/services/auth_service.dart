import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> createUserWithEmailAndPassword(String email, String password);

  Future<String> currentUser();

  Future<void> signOut();
}

class AuthMethods extends AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential _credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = _credential.user!;
    return user;
  }

  @override
  Future<User> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    UserCredential _credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = _credential.user!;
    return user;
  }

  @override
  Future<String> currentUser() async {
    User user = auth.currentUser!;

    return user.uid;
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
