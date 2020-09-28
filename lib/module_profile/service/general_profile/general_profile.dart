import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_profile/model/profile_model/profile_model.dart';
import 'package:swaptime_flutter/utils/logger/logger.dart';

@provide
class GeneralProfileService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<ProfileModel> getUserDetails(String userId) async {
    Logger().info('General Profile', 'Searching for $userId');
    var data = await _fireStore.collection('profiles').doc(userId).get();
    if (data.exists) {
      return ProfileModel.fromJson(data.data());
    }
    return null;
  }

  Future<void> setUserProfile(String userId, ProfileModel model) async {
    await _fireStore.collection('profiles').doc(userId).set(model.toJson());
  }
}
