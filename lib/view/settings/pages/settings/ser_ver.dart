import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final appVersionProvider = FutureProvider<PackageInfo>((ref) async {
  return await PackageInfo.fromPlatform();
});

class AppVersionPage extends ConsumerStatefulWidget {
  const AppVersionPage({Key? key}) : super(key: key);

  @override
  _AppVersionPageState createState() => _AppVersionPageState();
}

class _AppVersionPageState extends ConsumerState<AppVersionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Version"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nutrito",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Health Assist app",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ref.watch(appVersionProvider).when(
                  data: (info) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Version: ${info.version} (Build: ${info.buildNumber})",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      const Text("Last Updated: 2025-03-01",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Text("Error loading version: $error"),
                ),
          ],
        ),
      ),
    );
  }
}
