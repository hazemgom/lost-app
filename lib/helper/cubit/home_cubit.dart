import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:save_stone/feature/homePage/home_page.dart';
import 'package:save_stone/feature/news/add_post.dart';
import 'package:save_stone/feature/news/feeds_screen.dart';

import 'package:save_stone/feature/profile-feature/profile-screen.dart';
import 'package:save_stone/helper/components/shared_preferences.dart';
import 'package:save_stone/main.dart';
import 'package:save_stone/model/login_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:save_stone/model/post_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> title = [
    'Home',
    'Add Post',
    'Setting',
  ];
  //delet post
  Future<void> DeletePost(String? postId) async {
    emit(deletepostlo());
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      getPosts();
      print('delllllllllllllet');
      emit(deletepost());
    });
    emit(deletepost());
  }

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyBroken.home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyBroken.upload,
      ),
      label: 'Add Post',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyBroken.setting,
      ),
      label: 'Setting',
    ),
  ];

  List<Widget> screens = [
    FeedScreen(),
    AddPostScreen(),
    const ProfileScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  late UserDataModel userModel;
  //get user data
  Future<void> getUserData() async {
    emit(GetLoadingUserDataState());
    print('datalaaaaaaaaaaaaaaaaaaaaaaaaaaad');
    final result = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      userModel = UserDataModel.fromJson(event.data()!);
      emit(GetSuccessUserDataState());
    }).onError((handleError) {
      print('Exception details:\n $handleError');
      emit(GetErrorUserDataState());
    });
    print(FirebaseAuth.instance.currentUser!.uid);
    print(uId);
  }

  File? profileImage;
  var picker = ImagePicker();
  //profile image
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ImagePostSuccess());
    } else {
      emit(ImagePostError());

      print('No image selected.');
    }
  }

  File? coverImage;
  //cover image
  var pickerCover = ImagePicker();
  Future<void> getCoverImage() async {
    final pickerCover = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickerCover != null) {
      coverImage = File(pickerCover.path);
      emit(ImagePostSuccess());
    } else {
      print('No image selected.');
      emit(ImagePostError());
    }
  }

  void updateUserData({
    required String phone,
    required String name,
    String? image,
    String? cover,
  }) {
    emit(UpdateLoadingUserDataState());
    UserDataModel model = UserDataModel(
      uId: userModel.uId,
      name: name,
      phone: phone,
      email: userModel.email,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(UpdateSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateErrorUserDataState());
    });
  }

  //Update Method
  Future<void> updateProfile() async {
    if (profileImage != null) {
      emit(UpdateLoadingUserDataState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateUserData(
              name: userModel.name,
              phone: userModel.phone,
              image: value,
              cover: userModel.cover);
          emit(UpdateSuccessUserDataState());
        }).catchError((onError) {
          print(onError.toString());
          emit(UpdateErrorUserDataState());
        });
      });
    }
    if (coverImage != null) {
      emit(UpdateLoadingUserDataState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
          .putFile(coverImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateUserData(
              name: userModel.name,
              phone: userModel.phone,
              image: userModel.image,
              cover: value);
          emit(UpdateSuccessUserDataState());
        }).catchError((onError) {
          print(onError.toString());
          emit(UpdateErrorUserDataState());
        });
      });
    }
  }

  List<PostModel> posts = [];
  List<PostModel> getLike = [];
  List<String> postId = [];
  List<int> likes = [];
  List<dynamic> comment = [];
  File? hotVideo;

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(ImagePostSuccess());
    } else {
      print('No image selected.');
      emit(ImagePostError());
    }
  }

  Future<void> getPosts() async {
    emit(GetPostsLoadingHomePageStates());
    FirebaseFirestore.instance.collection('posts').snapshots().listen((value) {
      emit(GetPostsSuccessHomePageStates());
      print(value.toString());
      posts = [];
      for (var element in value.docs) {
        element.reference.collection('comment').get().then((value) {
          comment.add(value.docs.length);
        }).catchError((onError) {});
      }

      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postId.add(element.id);
        }).catchError((onError) {});
      }
    }).onError((onError) {
      emit(GetPostsErrorHomePageStates());
    });
  }

  void removePostImage() {
    postImage = null;

    emit(RemoveImageFile());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
    required String location,
  }) {
    emit(CreatePostLoadingHomePageStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dataTime: dateTime,
          postImage: value,
          location: location,
        );
      }).catchError((error) {
        emit(CreatePostErrorHomePageStates());
      });
    }).catchError((error) {
      emit(CreatePostErrorHomePageStates());
    });
  }

  //Post Method
  Future<void> createPost({
    String? postImage,
    String? videoPost,
    required String text,
    required String dataTime,
    required String location,
  }) async {
    emit(CreatePostLoadingHomePageStates());
    PostModel model = PostModel(
        name: userModel.name,
        text: text,
        dateTime: dataTime,
        image: userModel.image,
        uId: uId,
        postImage: postImage ?? '',
        location: location,
        email: userModel.email,
        phone: userModel.phone);
    await FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessHomePageStates());
    }).catchError((error) {
      emit(CreatePostErrorHomePageStates());
    });
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        FirebaseAuth.instance.signOut(),
        CacheHelper.removeData(key: 'uId'),
      ]);
    } catch (error) {
      throw Exception();
    }
  }
}
