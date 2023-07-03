import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_stone/feature/onboarding/onboarding_cubit/cubit.dart';
import 'package:save_stone/feature/onboarding/onboarding_cubit/states.dart';
import 'package:save_stone/feature/onboarding/widget_components/onboarding_model.dart';
import 'package:save_stone/helper/components/custom_components.dart';
import 'package:save_stone/helper/components/shared_preferences.dart';
import 'package:save_stone/helper/components/theme.dart';
import 'package:save_stone/helper/cubit/home_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../authentication/sign_screen.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                //page view
                Expanded(
                  flex: 4,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (context, index) =>
                        onboardBuildPage(onBoardInfo[index]),
                    itemCount: onBoardInfo.length,
                    onPageChanged: (index) {
                      if (index == onBoardInfo.length - 1) {
                        OnBoardingCubit.get(context).listenPageLastIndex(true);
                      } else {
                        OnBoardingCubit.get(context).listenPageLastIndex(false);
                      }
                    },
                  ),
                ),

                //indicator, buttons
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //Indicator
                        const Spacer(),
                        Row(
                          children: [
                            //Skip
                            SmoothPageIndicator(
                              controller: pageController,
                              count: onBoardInfo.length,
                              effect: const ExpandingDotsEffect(
                                dotColor: Colors.grey,
                                activeDotColor: Color(0xFF0C9869),
                                dotHeight: 10.0,
                                dotWidth: 10.0,
                              ),
                            ),
                            const Spacer(),
                            MaterialButton(
                              padding: const EdgeInsets.all(10.0),
                              onPressed: () {
                                if (OnBoardingCubit.get(context).isLastPage) {
                                  CacheHelper.saveData(
                                      key: 'onboardingIsSeen', value: true);
                                  navigateAndRemove(
                                      context, const SignUpScreen());
                                } else {
                                  pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                                }
                              },
                              color: Colors.teal,
                              shape: OnBoardingCubit.get(context).isLastPage
                                  ? RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0))
                                  : const CircleBorder(),
                              child: OnBoardingCubit.get(context).isLastPage
                                  ? const Text(
                                      'Get Started',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget onboardBuildPage(OnboardingModel pageInfo) => Column(
        // alignment: Alignment.topCenter,
        children: [
          Expanded(
            child: Image(
              image: CachedNetworkImageProvider(
                pageInfo.imagePath,
              ),
              fit: BoxFit.fill,
            ),
          ),
          //upper texts
          Container(height: 1,width: double.infinity,color: Colors.black,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pageInfo.title,
                  style: textTheme(
                    color: const Color(0xFF0C9869),
                    fontSize: 28.0,
                  ),
                ),
                Text(
                  pageInfo.describtion,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
