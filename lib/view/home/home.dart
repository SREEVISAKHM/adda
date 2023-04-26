import 'package:adda/providers/home_view_model_provider.dart';
import 'package:adda/view/common/c_appbar.dart';
import 'package:adda/view/home/widgets/facility_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    final homeViewModel = ref.read(homeViewModelProvider);
    homeViewModel.getFacility();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'ADDA',
        backButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            height(30),
            Lottie.asset(
              'assets/lottie/animation.json',
              height: 200,
              controller: _controller,
              repeat: true,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..repeat();
              },
            ),
            height(20),
            Row(
              children: [
                const SizedBox(
                  height: 60,
                  child: VerticalDivider(
                    color: Colors.red,
                    thickness: 3,
                  ),
                ),
                width(10),
                const Text(
                  'Book Your\nFacility',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            height(40),
            SizedBox(
              height: 130,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ref.read(homeViewModelProvider).facilities.length,
                  itemBuilder: (_, index) {
                    var facilities = ref.read(homeViewModelProvider).facilities;
                    return FacilityCard(
                      facilities: facilities,
                      index: index,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  SizedBox width(double width) => SizedBox(
        width: width,
      );

  SizedBox height(double height) => SizedBox(
        height: height,
      );
}
