import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //varible utilizada para guardar el token de manera local
  final log = GetStorage();

  @override
  void onInit() {
    super.onInit();
    //verifico antes de iniciar la app si existe un token
    if (log.read('token') != null) Get.offNamed('/home');
  }

//varibles necesarias para guardar datos e instanciar las clases de Google
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

//Método para realizar el login con una cuenta Google
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    await log.write('token', credential.idToken);
    update();
  }
}
