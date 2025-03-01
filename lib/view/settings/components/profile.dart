import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrito/view/settings/components/profile_first.dart';
import 'package:nutrito/view/settings/components/profile_second.dart';

class ProfileSection extends ConsumerWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
