import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/storage/user_Data.dart';

class AuthService {
  Future<UserCredential> signWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gauth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    UserStore userStore = UserStore();

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final userModel = UserModel(
        email: userCredential.user?.email ?? "",
        name: userCredential.user?.displayName ?? "",
        password: "",
        id: userCredential.user?.uid ?? "",
        phone: userCredential.user?.phoneNumber ?? "",
        image: userCredential.user?.photoURL ?? "");

    await userStore.updateData(userModel);
    return userCredential;
  }
}
