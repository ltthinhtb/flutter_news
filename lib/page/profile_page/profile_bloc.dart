import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_news/models/response/user.dart';
import 'package:flutter_news/service/auth_service.dart';
import 'package:flutter_news/service/database.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as Path;
import 'profile.dart';

class ProfileSettingBloc
    extends Bloc<ProfileSettingEvent, ProfileSettingState> {
  SharedPreferences prefs;
  bool isDark;
  User user;
  File file;
  AuthService authService = AuthService();
  bool isLogin;

  @override
  ProfileSettingState get initialState => InitProfileSettingState();

  @override
  Stream<ProfileSettingState> mapEventToState(
      ProfileSettingEvent event) async* {
    if (event is LoadProfileEvent) {
      yield LoadingDataState();
      isDark = await getOption();
      isLogin = await authService.checkLogin();
      if (isLogin) {
        user = await getUser();
      } else
        user = null;
      yield DataSuccessState(isDark, user);
    }

    if (event is LogOut) {
      yield LoadingDataState();
      await authService.signOut();
      add(LoadProfileEvent());
      yield DataSuccessState(isDark, null);
    }

    if (event is UpdateAvatarEvent) {
      yield InitProfileSettingState();
      // ignore: deprecated_member_use
      file = await ImagePicker.pickImage(
          source: event.isUploadFromCamera
              ? ImageSource.camera
              : ImageSource.gallery);
      await uploadFile(file);
      print(user.photoUrl);
      yield DataSuccessState(isDark, user);
    }
  }

  Future<bool> getOption() async {
    prefs = await SharedPreferences.getInstance();
    bool option = prefs.get('theme_option') ?? false;
    return option;
  }

  Future<User> getUser() async {
    prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('userId') ?? null;
    user = await DataBase(uid: userId).dataUser();
    return user;
  }

  Future uploadFile(File _file) async {
    String userId = prefs.get('userId') ?? null;
    StorageReference ref = FirebaseStorage.instance.ref().child('profilePhotoUrl/${Path.basename('profile + userId : $userId')}}');
    StorageUploadTask uploadTask = ref.putFile(_file);
    var storageTaskSnapshot = await uploadTask.onComplete;
    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    await DataBase(uid: userId).updateAvatar(downloadUrl);
     user = await getUser();
  }
}
