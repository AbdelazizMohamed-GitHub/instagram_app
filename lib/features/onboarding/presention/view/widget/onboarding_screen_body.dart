
import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/app_colors.dart';
import 'package:instagram_app/core/utils/app_images.dart';
import 'package:instagram_app/core/utils/routs.dart';
import 'package:instagram_app/core/utils/spaces.dart';
import 'package:instagram_app/features/onboarding/presention/view/widget/custom_dotindicator.dart';
import 'package:instagram_app/features/onboarding/presention/view/widget/page_view_item.dart';

class OnboardingScreenBody extends StatefulWidget {
  const OnboardingScreenBody({super.key});

  @override
  State<OnboardingScreenBody> createState() => _OnboardingScreenBodyState();
}

class _OnboardingScreenBodyState extends State<OnboardingScreenBody> {
  int postion = 0;
  PageController pageC = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: getHeigt(context) * 0.6,
          child: PageView(
            controller: pageC,
            onPageChanged: (value) {
              setState(() {
                postion = value;
              });
            },
            children: const [
              PageViewItem(
                image: AppImages.onboardingImage1,
                text:
                    "Give people the power to build community and bring the world closer together.",
              ),
              PageViewItem(
                image: AppImages.onboardingImage2,
                text:
                    "You can share your Photos, Chat with your Friends & can Likes, Comments & go to Live.",
              ),
              PageViewItem(
                image: AppImages.onboardingImage3,
                text:
                    "Create, watch, and share short, entertaining videos called",
              ),
            ],
          ),
        ),
        CustomDotindicator(
          postion: postion,
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              TextButton(
                  onPressed: () {
                    if (postion > 0) {
                      setState(() {
                        postion--;
                        pageC.animateToPage(postion,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      });
                    }
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(fontSize: 20),
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (postion < 2) {
                    setState(() {
                      postion++;
                      pageC.animateToPage(postion,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    });
                  } else {
                    Navigator.pushNamed(context, AppRouter.loginScreenRoute);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
