import 'package:DooBee/features/login/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/onboarding_screen_widget.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'Onboarding Screen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9E7BE8),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: const [
                OnboardingScreenWidget(
                  imagePath: 'assets/images/onboarding_1.png',
                  title: 'Achieve Your Goals',
                  description:
                  'Easily define your objectives and work towards them with DoBee.',
                ),
                OnboardingScreenWidget(
                  imagePath: 'assets/images/onboarding_2.png',
                  title: 'Track Your Progress',
                  description:
                  'Monitor your progress and stay motivated by visualizing completed tasks.',
                ),
                OnboardingScreenWidget(
                  imagePath: 'assets/images/onboarding_3.png',
                  title: 'Get Notified Instantly',
                  description:
                  'DoBee ensures you get alerted about upcoming tasks and deadlines right when you need them.',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8.h,
                    dotWidth: 12.w,
                    activeDotColor: Colors.white,
                    dotColor: Colors.white54,
                    expansionFactor: 2,
                    spacing: 8.0,
                  ),
                ),
             /*   Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Center(
                        child: Container(
                          width: 24.0, // Width of the active dot
                          height: 8.0, // Height of the active dot
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD9B8FF), Color(0xFFAB62FF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      );
                    },
                  ),
                ),*/
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: ElevatedButton(
              onPressed: () {
                int nextPage = _controller.page!.toInt() + 1;
                if (nextPage < 3) {
                  _controller.animateToPage(
                    nextPage,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  Navigator.pushReplacementNamed(
                    context,
                    LoginScreen.routeName,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                child: Text(
                  currentPage == 2 ? 'Get Started' : 'Next',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF9E7BE8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
