import 'package:flutter/material.dart';

import '../../shared/utils/color.dart';
import '../../shared/utils/font.dart';
import '../auth/sc_auth.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);
  static const routeName = '/onboarding';

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _controller = PageController();

  final _dataList = [
    _PageData(
      title: 'Screen 1',
    ),
    _PageData(
      title: 'Screen 2',
    ),
    _PageData(
      title: 'Screen 3',
    ),
    _PageData(
      title: 'Screen 4',
    ),
  ];

  int _currentPage = 0;

  bool get isLastPage => _currentPage == _dataList.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: PageView.builder(
              controller: _controller,
              itemCount: _dataList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text(_dataList[index].title),
                );
              },
              onPageChanged: (value) => setState(() => _currentPage = value),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      AnimatedOpacity(
                        opacity: isLastPage ? 0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: GestureDetector(
                          onTap: isLastPage ? null : finishOnBoarding,
                          child: const Text(
                            'Skip',
                          ),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        // To balance extra 10 margin on right by last dot
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _dataList.length,
                          (int index) => _buildDots(index: index),
                        ),
                      ),
                      const Spacer(),
                      AnimatedOpacity(
                        opacity: isLastPage ? 0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: GestureDetector(
                          onTap: isLastPage
                              ? null
                              : () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                          child: const Text(
                            'Next',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  left: 0,
                  right: 0,
                  top: isLastPage
                      ? 0
                      : MediaQuery.of(context).size.height * 0.15,
                  child: Center(
                    child: FloatingActionButton.extended(
                      onPressed: finishOnBoarding,
                      backgroundColor: ColorUtils.primary,
                      label: Text(
                        "Awesome",
                        style: FontUtils.textStyle,
                      ),
                    ),
                  ),
                  duration: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer _buildDots({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: _currentPage == index
            ? [
                BoxShadow(
                  color: ColorUtils.primary.withOpacity(0.4),
                  spreadRadius: 2,
                ),
              ]
            : null,
        color: _currentPage == index ? Colors.red : ColorUtils.primary,
      ),
      margin: const EdgeInsets.only(right: 10),
      height: _currentPage == index ? 12 : 9,
      curve: Curves.easeIn,
      width: _currentPage == index ? 12 : 9,
    );
  }

  void finishOnBoarding() {
    Navigator.pushNamed(context, AuthView.routeName);
  }
}

class _PageData {
  final String title;

  _PageData({required this.title});
}
