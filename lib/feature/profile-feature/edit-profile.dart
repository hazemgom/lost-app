import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';


import 'package:save_stone/helper/components/custom_components.dart';
import 'package:save_stone/helper/cubit/home_cubit.dart';

class UpdateProfile extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  GlobalKey Formkey = GlobalKey<FormState>();

  UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is UpdateSuccessUserDataState) {
            HomeCubit.get(context).getUserData();
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if (state is GetSuccessUserDataState) {
            phoneController.text = cubit.userModel.phone;
            userNameController.text = cubit.userModel.name;
          }

          return (state is GetLoadingUserDataState)
              ? Scaffold(
                  appBar: buildCustomAppBar(text: 'Update Profile'),
                  body: const Center(child: CircularProgressIndicator()),
                )
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: buildCustomAppBar(
                    text: 'Update Profile',
                    action: [
                      Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(
                            onPressed: () {
                              cubit.updateUserData(
                                phone: phoneController.text,
                                name: userNameController.text,
                              );
                            },
                            icon: Icon(IconlyBroken.upload),
                          ))
                    ],
                    backgroundColor: Colors.transparent,
                  ),
                  body: Form(
                    key: Formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (state is UpdateLoadingUserDataState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 300,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      Container(
                                        height: 250,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: cubit.coverImage == null
                                                ? NetworkImage(
                                              '${cubit.userModel.cover}',
                                            ) as ImageProvider
                                                : FileImage(cubit.coverImage!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: CircleAvatar(
                                          backgroundColor: ThemeData.light()
                                              .scaffoldBackgroundColor,
                                          radius: 20.0,
                                          child: const Icon(
                                            IconlyBroken.camera,
                                            size: 16.0,
                                          ),
                                        ),
                                        onPressed: () {
                                          cubit.getCoverImage();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    CircleAvatar(
                                      radius: 64.0,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: CircleAvatar(
                                        radius: 60.0,
                                        backgroundImage: cubit.profileImage ==
                                                null
                                            ? NetworkImage(
                                                '${cubit.userModel.image}',
                                              ) as ImageProvider
                                            : FileImage(cubit.profileImage!),
                                      ),
                                    ),
                                    IconButton(
                                      icon: CircleAvatar(
                                        backgroundColor: ThemeData.light()
                                            .scaffoldBackgroundColor,
                                        radius: 20.0,
                                        child: const Icon(
                                          IconlyBroken.camera,
                                          size: 16.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        cubit.getProfileImage();
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                if (cubit.profileImage != null ||
                                    cubit.coverImage != null)
                                  Row(
                                    children: [
                                      if (cubit.coverImage != null)
                                        Expanded(
                                          child: Buttonhelper(
                                            title: 'Update Cover',
                                            onchange: () {
                                              cubit.updateProfile();
                                            },
                                          ),
                                        ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      if (cubit.profileImage != null)
                                        Expanded(
                                          child: Buttonhelper(
                                            title: 'Updata Profile',
                                            onchange: () {
                                              cubit.updateProfile();
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 60,
                                ),
                                TextFormField(
                                  controller: userNameController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field is requird';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: const Text('update Name'),
                                      prefixIcon: const Icon(Icons
                                          .supervised_user_circle_outlined),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field is requird';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: const Text('update phone'),
                                      prefixIcon: const Icon(Icons.phone),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
