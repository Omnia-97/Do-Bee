import 'package:flutter/material.dart';
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
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    dotColor: Colors.white54,
                    activeDotColor: Colors.transparent,
                  ),
                ),
                Positioned.fill(
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
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the next screen or move to the next page
                int nextPage = _controller.page!.toInt() + 1;
                if (nextPage < 3) {
                  _controller.animateToPage(
                    nextPage,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  // Navigate to the next screen in your app
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18, color:Color(0xFF9E7BE8),),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
