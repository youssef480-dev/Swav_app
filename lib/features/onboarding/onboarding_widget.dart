import 'package:flutter/material.dart';
import 'package:graduation_project/features/splash_screen.dart';
import 'package:graduation_project/features/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Connect",
      "desc": "Stay connected with your favorite brands easily.",
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Offer",
      "desc": "Discover exclusive deals tailored just for you.",
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Save",
      "desc": "Track your spending and save money smarter than ever before.",
    },
  ];

  void _nextPage() {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF5F5F5),
        child: SafeArea(
          child: Center(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: const Color(0xFFF4991A),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  SizedBox(height: height * 0.07),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: height * 0.07),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        "assets/images/Logo.png",
                        height: 80,
                        width: 80,
                      )),
                  SizedBox(height: height * 0.02),
                  const Text(
                    "swav",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: pages.length,
                      onPageChanged: (index) {
                        setState(() => currentIndex = index);
                      },
                      itemBuilder: (context, index) {
                        return _buildPage(
                          pages[index]["image"]!,
                          pages[index]["title"]!,
                          pages[index]["desc"]!,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(height * 0.03),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _nextPage,
                          child: const Text(
                            "Skip",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(
                            pages.length,
                            (index) => _dot(index == currentIndex),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _nextPage,
                          child: Text(
                            currentIndex == pages.length - 1 ? "Start" : "Next",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String image, String title, String desc) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(height * 0.02),
      padding: EdgeInsets.all(height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: height * 0.3, width: width * 0.5),
          SizedBox(height: height * 0.03),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 12 : 8,
      height: active ? 12 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.black : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
