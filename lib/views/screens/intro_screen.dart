import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            body: "Screen 1",
            title: "Welcome to My App",
            image: Image.network(
                "https://static.vecteezy.com/system/resources/previews/001/879/618/original/brainstorming-to-solve-problem-startup-office-with-swing-modern-workplace-or-coworking-space-play-and-work-flat-illustration-for-landing-page-web-website-banner-mobile-flyer-poster-free-vector.jpg"),
          ),
          PageViewModel(
            body: "Screen 2",
            title: "Second Page My App",
            image: Image.network(
                "https://teambuildinghub.com/wp-content/uploads/2022/05/balance-life-and-home-work-vector-1024x538.webp"),
          ),
          PageViewModel(
            body: "Screen 3",
            title: "Third Page My App",
            image: Image.network(
                "https://cdn11.bigcommerce.com/s-dnybxc6/product_images/uploaded_images/worklife-balance-statistics.jpg"),
          ),
          PageViewModel(
            body: "Screen 4",
            title: "Fourth Page My App",
            image: Image.network(
                "https://img.freepik.com/premium-vector/successful-time-management-entrepreneur-organizing-activity-manager-planning-work-tasks-schedule-productive-office-vector-illustration-business-entrepreneur-management-professional_53562-13366.jpg?w=2000"),
          ),
          PageViewModel(
            body: "Screen 5",
            title: "Fifth Page My App",
            image: Image.network(
                "https://img.freepik.com/premium-vector/enjoy-coffee-cafe-flat-design-bundle-illustration_176417-3492.jpg?w=2000"),
          ),
          PageViewModel(
            body: "Screen 6",
            title: "Sixth Page My App",
            image: Image.network(
                "https://img.freepik.com/free-vector/colleagues-working-together-pack_52683-24738.jpg?w=2000"),
          ),
        ],
        done: Text("Next"),
        showNextButton: false,
        onDone: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool("isIntrovisited", true);
          Navigator.of(context).pushNamed('home_page');
        },
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }
}
