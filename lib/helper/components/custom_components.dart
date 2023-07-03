import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:save_stone/helper/components/theme.dart';

AppBar buildCustomAppBar({
  required String text,
  Function()? function,
  IconData? icon ,
  bool centerTitle = true,
  Color backgroundColor = Colors.white,
  Color foregroundColor = Colors.black,
  List<Widget>? action,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    elevation: 0,
    centerTitle: centerTitle,
    title: Text(
      text,
      style: textTheme(fontSize: 22, color: foregroundColor),
    ),
    actions: action,
  );
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndRemove(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void defaultToast({
  required BuildContext context,
  required String message,
  required Color iconColor,
  required IconData icon,
}) {
  MotionToast(
    description: Text(
      message,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    ),
    primaryColor: const Color(0x00012ccf),
    animationDuration: const Duration(
      milliseconds: 500,
    ),
    toastDuration: const Duration(seconds: 5),
    displaySideBar: false,
    icon: icon,
    animationCurve: Curves.fastLinearToSlowEaseIn,
    secondaryColor: iconColor,
    enableAnimation: false,
    constraints: const BoxConstraints(),
    padding: const EdgeInsets.all(20.0),
  ).show(context);
}

class Buttonhelper extends StatelessWidget {
  Buttonhelper({this.onchange, this.title});
  String? title;
  VoidCallback? onchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.circular(60)),
      child: MaterialButton(
          onPressed: onchange,
          child: Center(
            child: Text(title!,
                style: GoogleFonts.arya(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20)),
          )),
    );
  }
}
