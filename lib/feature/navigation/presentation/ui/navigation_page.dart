import 'package:flutter/material.dart';
import 'package:kyz_jubek/feature/add_note/add_note_main_screen.dart';
import 'package:kyz_jubek/feature/calendar/presentation/calendar_screen.dart';
import 'package:kyz_jubek/feature/home/presentation/ui/home_page.dart';
import 'package:kyz_jubek/feature/personal_grow/presentation/ui/personal_grow_page.dart';
import 'package:kyz_jubek/feature/profile/presentation/ui/profile_page.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';

class BottomNavigatorPage extends StatefulWidget {
  const BottomNavigatorPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorPage> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigatorPage> {
  int index = 0;

  List<Widget> pages = [
    const HomePage(),
    const CalendarScreen(),
    const PersonalGrowPage(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: pages[index],
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.color38B6FFBLue,
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 10,
            selectedFontSize: 10,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.white.withOpacity(0.5),
            currentIndex: index,
            onTap: (indexFrom) async {
              setState(() {
                index = indexFrom;
              });
            },
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Меню',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.calendar_month_rounded),
                icon: Icon(Icons.calendar_today_rounded),
                label: 'Календарь',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.person_2),
                icon: Icon(Icons.person_2_outlined),
                label: 'Личностный рост',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.settings_applications_outlined),
                icon: Icon(Icons.settings),
                label: "Мой профиль",
              ),
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNoteMainScreen(),
                ),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: AppDecorations.defaultDeco(
                radius: 100,
                color: Colors.amber,
              ),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
