import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/blocs/main/main_page_bloc.dart';
import 'package:flutter_architecture_template/presentation/pages/firebase_page.dart';
import 'package:flutter_architecture_template/presentation/pages/github_releases_page.dart';
import 'package:flutter_architecture_template/presentation/pages/github_user_page.dart';
import 'package:flutter_architecture_template/presentation/pages/gitlab_user_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  final PageController pageController = PageController();

  MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainPageBloc>(
      create: (_) => sl<MainPageBloc>(),
      child: BlocConsumer<MainPageBloc, MainPageState>(
        listener: onNewState,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Github Search Engine'),
          ),
          body: buildBody(context),
          bottomNavigationBar: buildBottomNavBar(context, state),
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
        GitlabUserPage(),
        FirebasePage(),
      ],
    );
  }

  BottomNavigationBar buildBottomNavBar(
      BuildContext context, MainPageState state) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (int i) => onTabTapped(context, i),
      currentIndex: state.currentIndex,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text('Releases'),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm),
          title: Text('Github User'),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.vpn_key),
          title: Text('Gitlab User'),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm),
          title: Text('Login'),
        ),
      ],
    );
  }

  void onNewState(BuildContext context, MainPageState state) {
    pageController.animateToPage(
      state.currentIndex,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void onTabTapped(BuildContext context, int newIndex) {
    if (newIndex != pageController.page.round()) {
      print("Goto ${newIndex}");
      context.bloc<MainPageBloc>().add(GoToPageEvent(newIndex));
    }
  }
}
