import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_stone/feature/homePage/home_page.dart';
import 'package:save_stone/helper/components/custom_components.dart';
import 'package:save_stone/helper/cubit/home_cubit.dart';
import 'package:save_stone/model/post_model.dart';

import 'edit-profile.dart';

class UserDataScreen extends StatelessWidget {
  UserDataScreen({required this.postModel});
  PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          print('dattttttttttttttttttttttttttttttttttttttttt user');
          print(postModel.name);
          print(postModel.phone);
          print(postModel.email);
          var cubit = HomeCubit.get(context);
          return (state is GetLoadingUserDataState)
              ? const CircularProgressIndicator()
              : Scaffold(
                  appBar: buildCustomAppBar(
                    text: 'User Info',
                    function: () {
                      navigateTo(context, const HomeLayout());
                    },
                  ),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 350,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: cubit.profileImage == null
                                                ? const NetworkImage(
                                                        'https://img.freepik.com/free-photo/solid-concrete-wall-textured-backdrop_53876-129493.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph')
                                                    as ImageProvider
                                                : FileImage(
                                                    postModel.image as File))),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.black87,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 75,
                                      backgroundImage:
                                          NetworkImage(postModel.image!)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            '${postModel.name}',
                            style: GoogleFonts.arbutusSlab(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.green.shade300,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'User Information',
                                    style: GoogleFonts.arbutusSlab(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    'Name:${postModel.name}',
                                    style: GoogleFonts.arbutusSlab(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    'Phone:${postModel.phone}',
                                    style: GoogleFonts.arbutusSlab(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    'Email:${postModel.email}',
                                    style: GoogleFonts.arbutusSlab(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 40,
                          // ),
                          // Container(
                          //   height: 40,
                          //   width: 400,
                          //   decoration: BoxDecoration(
                          //       color: Colors.green.shade300,
                          //       borderRadius: BorderRadius.circular(60)),
                          //   child: MaterialButton(
                          //       onPressed: () {
                          //         cubit.getuserdata();
                          //         Navigator.push(context,
                          //             MaterialPageRoute(builder: (context) {
                          //               return UpdataProfile();
                          //             }));
                          //       },
                          //       child: Center(
                          //         child: Text('Edit Profile',
                          //             style: GoogleFonts.arya(
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.black,
                          //                 fontSize: 20)),
                          //       )),
                          // ),
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
