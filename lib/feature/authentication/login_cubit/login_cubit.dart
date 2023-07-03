import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_stone/feature/authentication/login_cubit/login_states.dart';
import 'package:save_stone/model/login_model.dart';

class SignUpCubit extends Cubit<SignStates> {
  SignUpCubit() : super(LoginInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((onError) {
      print('${onError}dsfffffffffffffffffffffffffffffffff');
      emit(LoginErrorState());
    });
  }



  late UserDataModel registerModel;

  Future<void> userRegister({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    emit(RegisterLoadingState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        email: email,
        uid: value.user!.uid,
        username: username,
        phone: phone,
        password: password,
      );
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((onError) {
      emit(RegisterErrorState());
      print(onError.toString());
    });
  }

  Future<void> userCreate({
    required String email,
    required String uid,
    required String username,
    required String phone,
    required String password,
  }) async {
    UserDataModel model = UserDataModel(
      email: email,
      phone: phone,
      uId: uid,
      name: username,
      image: 'https://img.freepik.com/free-photo/blue-user-icon-symbol-website-admin-social-login-element-concept-white-background-3d-rendering_56104-1217.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph',
      cover: 'https://img.freepik.com/free-photo/abstract-uv-ultraviolet-light-composition_23-2149243965.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296'
    );
    print('user done');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap());
    emit(CreateUserSuccessState(model.uId));
    print('donnnne');
  }

  bool isObscure = true;
  IconData passwordSuffixIcon = Icons.visibility_outlined;

  void changeVisibilityMode() {
    isObscure = !isObscure;
    passwordSuffixIcon =
        isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeVisibilityState());
  }
}
