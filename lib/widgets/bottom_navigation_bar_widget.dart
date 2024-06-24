import 'package:flutter/material.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/providers/bottom_navigation_bar_provider.dart';
import 'package:perfect_body_form/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<BottomNavigationBarProvider, UserProvider>(
      builder: (context, bottomNavigationBarProvider, userProvider, child) {
        return Scaffold(
          backgroundColor: white,
          body: bottomNavigationBarProvider.body(),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(defaultBorderRadius),
            ),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  primaryShadow,
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: white,
                selectedItemColor: primaryColor,
                unselectedItemColor: grey400,
                currentIndex: bottomNavigationBarProvider.currentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  bottomNavigationBarProvider.setCurrentIndex(value);
                },
                items: [
                  BottomNavigationBarItem(
                    label: "Beranda",
                    icon: bottomNavigationBarProvider.currentIndex == 0
                        ? const Icon(Icons.home_rounded)
                        : const Icon(
                            Icons.home_outlined,
                          ),
                  ),
                  BottomNavigationBarItem(
                    label: "Latihan",
                    icon: bottomNavigationBarProvider.currentIndex == 1
                        ? const Icon(Icons.run_circle_rounded)
                        : const Icon(
                            Icons.run_circle_outlined,
                          ),
                  ),
                  BottomNavigationBarItem(
                    label: "Profil",
                    icon: Container(
                      decoration: BoxDecoration(
                        color: white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: bottomNavigationBarProvider.currentIndex == 2
                              ? primaryColor
                              : grey400,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                          "${userProvider.userModel?.profilePhotoURL}&size=128",
                        ),
                        onBackgroundImageError: (exception, stackTrace) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
