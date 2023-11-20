import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/tweet/views/create_tweet_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => HomeView(),
      );

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final appBar = UIConstants.appBar();
  int _pageIndex = 0;

  void onPageIndexChange(int value) {
    setState(() {
      _pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _pageIndex,
        children: UIConstants.bottomTabBarPages,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _pageIndex,
        onTap: onPageIndexChange,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _pageIndex == 0
                  ? AssetsConstants.homeFilledIcon
                  : AssetsConstants.homeOutlinedIcon,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _pageIndex == 2
                  ? AssetsConstants.notifFilledIcon
                  : AssetsConstants.notifOutlinedIcon,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(CreateTweetView.route());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
