import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:save_stone/feature/authentication/widget_components/validator_components.dart';
import 'package:save_stone/feature/homePage/home_page.dart';
import 'package:save_stone/helper/components/custom_components.dart';
import 'package:save_stone/helper/cubit/home_cubit.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? _currentAddress = '';
  Position? _currentPosition;

  var textController = TextEditingController();

  var locationController = TextEditingController();

  var now = DateTime.now();

  var formKey = GlobalKey<FormState>();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}, ${place.subLocality},';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        locationController.text = _currentAddress!;
        var cubit = HomeCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (cubit.postImage == null) {
                    HomeCubit.get(context).getPosts();
                    cubit.createPost(
                      text: textController.text,
                      dataTime: now.toString(),
                      location: locationController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Post Added'),
                      ),
                    );
                  } else if (cubit.postImage != null) {
                    HomeCubit.get(context).getPosts();
                    cubit.uploadPostImage(
                      location: locationController.text,
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  }
                }
              },
              child: const Icon(
                Icons.upload_outlined,
                color: Colors.black,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is CreatePostLoadingHomePageStates)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      cursorHeight: 16,
                      validator: validator,
                      maxLines: 3,
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'What is on your Mind.....?',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (cubit.postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image(
                            image: FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              cubit.removePostImage();
                            },
                            icon: const Icon(
                              Icons.delete_rounded,
                            ))
                      ],
                    ),
                  if (cubit.postImage == null)
                    InkWell(
                      onTap: () {
                        cubit.getPostImage();
                      },
                      child: const Card(
                        elevation: 7,
                        child: Image(
                          image: CachedNetworkImageProvider(
                              'https://img.freepik.com/free-vector/images-concept-illustration_114360-298.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=ais'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: _getCurrentPosition,
                            icon: Icon(IconlyLight.location)),
                        Expanded(
                          child: TextFormField(
                            // validator: validator,
                            enabled: false,
                            controller: locationController,
                            decoration: InputDecoration(
                              hintText: 'Enter Location',
                              border: InputBorder.none,
                            ),
                          ),
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
    );
  }
}
