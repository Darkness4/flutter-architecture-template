import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/blocs/main/bloc.dart';
import 'package:flutter_architecture_template/presentation/pages/github_releases_page.dart';
import 'package:flutter_architecture_template/presentation/pages/github_user_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  final PageController pageController = PageController();

  MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MainPageBloc>(),
      child: BlocListener<MainPageBloc, MainPageState>(
        listener: onNewState,
        child: BlocBuilder<MainPageBloc, MainPageState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('Github Search Engine'),
            ),
            body: buildBody(context),
            bottomNavigationBar: buildBottomNavBar(context),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const <Widget>[
        GithubReleasesPage(),
        GithubUserPage(),
      ],
    );
  }

  BottomNavigationBar buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int i) => onTabTapped(context, i),
      currentIndex: BlocProvider.of<MainPageBloc>(context).currentIndex,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text('Releases'),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm),
          title: Text('User'),
        ),
      ],
    );
  }

  void onNewState(BuildContext context, MainPageState state) {
    if (state is FirstPageState) {
      pageController.animateToPage(
        0,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
      );
    } else if (state is SecondPageState) {
      pageController.animateToPage(
        1,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void onTabTapped(BuildContext context, int newIndex) {
    if (newIndex != pageController.page.round()) {
      switch (newIndex) {
        case 0:
          print("Goto 1");
          BlocProvider.of<MainPageBloc>(context)
              .add(const GoToFirstPageEvent());
          break;
        case 1:
          print("Goto 2");
          BlocProvider.of<MainPageBloc>(context)
              .add(const GoToSecondPageEvent());
          break;
        default:
      }
    }
  }
}
