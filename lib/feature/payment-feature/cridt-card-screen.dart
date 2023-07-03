import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_stone/feature/profile-feature/user-data-screen.dart';
import 'package:save_stone/helper/components/custom_components.dart';
import 'package:save_stone/model/post_model.dart';


class CridtCardScreen extends StatelessWidget {
  CridtCardScreen({required this.postModel});
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController Datacontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController cvvcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        text: 'Payment',
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 400,
                    child: Image(
                      image: CachedNetworkImageProvider(
                        'https://img.freepik.com/premium-vector/businessman-hand-holds-credit-card-vector-illustration_175838-2033.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 14) {
                        return 'Please enter vaild number';
                      }
                      return null;
                    },
                    controller: numbercontroller,
                    decoration: InputDecoration(
                        label: const Text('Number'),
                        hintText: 'Please enter 14 number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Vaild data';
                            }
                            return null;
                          },
                          controller: Datacontroller,
                          decoration: InputDecoration(
                            label: const Text('Expired Data'),
                            hintText: 'Please enter Expire Data',

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 4) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: cvvcontroller,
                          decoration: InputDecoration(
                              label: const Text('CVV'),
                              hintText: 'Please enter 4 num',

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: namecontroller,
                    decoration: InputDecoration(
                        label: const Text('Name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Success  ')));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserDataScreen(
                              postModel: postModel!,
                            );
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Enter Valid Information')));
                        }
                      },
                      child: Text(
                        'Validation',
                        style: GoogleFonts.arya(
                            fontSize: 25, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
