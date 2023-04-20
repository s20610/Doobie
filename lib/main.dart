import 'package:doobie/constants/route_strings.dart';
import 'package:doobie/views/login_view.dart';
import 'package:doobie/views/my_account_view.dart';
import 'package:doobie/views/news_view.dart';
import 'package:doobie/views/promotions_view.dart';
import 'package:doobie/views/register_view.dart';
import 'package:doobie/views/strains_view.dart';
import 'package:doobie/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:global_bottom_navigation_bar/widgets/bottom_navigation_item.dart';
import 'package:global_bottom_navigation_bar/widgets/scaffold_bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doobie',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        focusColor: Colors.deepPurple,
        secondaryHeaderColor: Colors.blueGrey,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        strains: (context) => const StrainsView(),
        promotions: (context) => const PromotionsView(),
        news: (context) => const NewsView(),
        myAccount: (context) => const MyAccountview(),
        verifyEmailRoute: (context) => const VerifyEmailView()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGlobalBottomNavigation(
      listOfChild: const [
        StrainsView(),
        NewsView(),
        PromotionsView(),
        MyAccountview(),
      ],
      listOfBottomNavigationItem: buildBottomNavigationItemList(),
    );
  }

  List<BottomNavigationItem> buildBottomNavigationItemList() => [
        BottomNavigationItem(
          activeIcon: const Icon(
            Icons.energy_savings_leaf,
            color: Colors.deepPurple,
            size: 18,
          ),
          inActiveIcon: const Icon(
            Icons.energy_savings_leaf,
            color: Colors.white,
            size: 21,
          ),
          title: 'Strains',
          color: Colors.green,
          vSync: this,
        ),
        BottomNavigationItem(
          activeIcon: const Icon(
            Icons.newspaper,
            color: Colors.deepPurple,
            size: 18,
          ),
          inActiveIcon: const Icon(
            Icons.newspaper,
            color: Colors.white,
            size: 21,
          ),
          title: 'News',
          color: Colors.green,
          vSync: this,
        ),
        BottomNavigationItem(
          activeIcon: const Icon(
            Icons.savings,
            color: Colors.deepPurple,
            size: 18,
          ),
          inActiveIcon: const Icon(
            Icons.savings,
            color: Colors.white,
            size: 21,
          ),
          title: 'Promo',
          color: Colors.green,
          vSync: this,
        ),
        BottomNavigationItem(
          activeIcon: const Icon(
            Icons.person,
            color: Colors.deepPurple,
            size: 18,
          ),
          inActiveIcon: const Icon(
            Icons.person,
            color: Colors.white,
            size: 21,
          ),
          title: 'MyAccount',
          color: Colors.green,
          vSync: this,
        ),
      ];
}
