import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_stone/feature/authentication/login_cubit/login_cubit.dart';
import 'package:save_stone/feature/authentication/login_cubit/login_states.dart';
import 'package:save_stone/feature/authentication/widget_components/validator_components.dart';
import 'package:save_stone/feature/homePage/home_page.dart';
import 'package:save_stone/helper/components/custom_components.dart';
import 'package:save_stone/helper/components/shared_preferences.dart';
import 'package:save_stone/helper/cubit/home_cubit.dart';

class RegisterWidget extends StatefulWidget {
  RegisterWidget({
    Key? key,
    required this.isSwitch,
    required this.passwordController,
    required this.isPass,
    required this.emailController,
    required this.phoneController,
    required this.nameController,
  }) : super(key: key);
  bool isPass;
  bool isSwitch;

  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignStates>(
      listener: (context, state) {
     if (state is RegisterErrorState) {
          defaultToast(
              context: context,
              message: 'Enter valid Data',
              iconColor: Colors.red,
              icon: Icons.dangerous);
        }
      },
      builder: (context, state) {
        var cubit = SignUpCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: widget.nameController,
                validator: validator,
                decoration: InputDecoration(
                    label: const Text('Your Name'),
                    prefixIcon: const Icon(
                      Icons.person,
                      size: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(strokeAlign: 1))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: widget.phoneController,
                keyboardType: TextInputType.number,
                validator: validator,
                decoration: InputDecoration(
                    label: const Text('Phone'),
                    prefixIcon: const Icon(
                      Icons.call_outlined,
                      size: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(strokeAlign: 1))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: widget.emailController,
                validator: validator,
                decoration: InputDecoration(
                    label: const Text('Email'),
                    prefixIcon: const Icon(
                      Icons.alternate_email,
                      size: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(strokeAlign: 1))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: widget.passwordController,
                obscureText: widget.isPass,
                validator: validator,
                decoration: InputDecoration(
                    label: const Text('Password'),
                    prefixIcon: const Icon(
                      Icons.password,
                      size: 18,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.isPass = !widget.isPass;
                        });
                      },
                      icon: widget.isPass
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(strokeAlign: 1))),
              ),
              const SizedBox(
                height: 16,
              ),
              ConditionalBuilder(
                condition: state is! RegisterLoadingState,
                builder: (context) => MaterialButton(
                  color: Color.fromRGBO(173, 231, 146, 1),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.transparent)),
                  minWidth: double.infinity,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.userRegister(
                        username: widget.nameController.text,
                        phone: widget.phoneController.text,
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.eduNswActFoundation(
                        color: Colors.black, fontSize: 16),
                  ),
                ),
                fallback: (context) => const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 1,
                    color: Colors.black,
                    width: 100,
                  ),
                  const Text('Or'),
                  Container(
                    height: 1,
                    color: Colors.black,
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }
}
