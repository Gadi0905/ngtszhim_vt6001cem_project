import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/model_helper/user_model.dart';

class UserServices {
  UserServices._();

  static final instance = UserServices._();

  static Future<UserModel> getUser({required String uid}) async {
    try {
      final _firebaseStore = FirebaseFirestore.instance;
      final user = await _firebaseStore.collection('users').doc(uid).get();
      return UserModel.fromJson(user.data() ?? {}, documentId: user.id);
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
