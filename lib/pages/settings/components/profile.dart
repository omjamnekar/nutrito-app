import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrito/pages/settings/components/profile_first.dart';
import 'package:nutrito/pages/settings/components/profile_second.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Gap(20),
        SectionFirst(),
        Gap(20),
        SecondSection(),
        Gap(20),
      ],
    );
  }
}
