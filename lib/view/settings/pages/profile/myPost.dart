import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostSettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(postSettingsProvider);
    final notifier = ref.read(postSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("My Post Settings")),
      body: ListView(
        children: [
          _buildDropdown(
              "Post Visibility",
              settings.visibility,
              ["Public", "Connections Only"],
              (value) => notifier.updateSetting("visibility", value)),
          _buildDropdown(
              "Comment Control",
              settings.comments,
              ["Everyone", "Connections", "Disabled"],
              (value) => notifier.updateSetting("comments", value)),
          _buildDropdown(
              "Tagging & Mentions",
              settings.tagging,
              ["Allow", "Approve", "Disable"],
              (value) => notifier.updateSetting("tagging", value)),
          _buildSwitch("Archive Old Posts", settings.archiveOldPosts,
              (value) => notifier.updateSetting("archiveOldPosts", value)),
          _buildSwitch("Auto-Delete Posts", settings.autoDelete,
              (value) => notifier.updateSetting("autoDelete", value)),
          _buildDropdown(
              "Reactions & Likes",
              settings.reactions,
              ["Everyone", "Connections", "Hide Count"],
              (value) => notifier.updateSetting("reactions", value)),
          _buildDropdown(
              "Post Sharing",
              settings.sharing,
              ["Everyone", "Connections", "Disable"],
              (value) => notifier.updateSetting("sharing", value)),
          _buildSwitch("Filter Offensive Content", settings.filterContent,
              (value) => notifier.updateSetting("filterContent", value)),
          _buildDropdown(
              "Language Preferences",
              settings.language,
              ["English", "Hindi", "Marathi"],
              (value) => notifier.updateSetting("language", value)),
          _buildSwitch("AI Content Moderation", settings.aiModeration,
              (value) => notifier.updateSetting("aiModeration", value)),
        ],
      ),
    );
  }

  Widget _buildDropdown(String title, String currentValue, List<String> options,
      Function(String) onChanged) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton(
        value: currentValue,
        items: options
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) => onChanged(value!),
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}

final postSettingsProvider =
    StateNotifierProvider<PostSettingsNotifier, PostSettings>((ref) {
  return PostSettingsNotifier();
});

class PostSettings {
  final String visibility;
  final String comments;
  final String tagging;
  final bool archiveOldPosts;
  final bool autoDelete;
  final String reactions;
  final String sharing;
  final bool filterContent;
  final String language;
  final bool aiModeration;

  PostSettings({
    required this.visibility,
    required this.comments,
    required this.tagging,
    required this.archiveOldPosts,
    required this.autoDelete,
    required this.reactions,
    required this.sharing,
    required this.filterContent,
    required this.language,
    required this.aiModeration,
  });

  PostSettings copyWith({
    String? visibility,
    String? comments,
    String? tagging,
    bool? archiveOldPosts,
    bool? autoDelete,
    String? reactions,
    String? sharing,
    bool? filterContent,
    String? language,
    bool? aiModeration,
  }) {
    return PostSettings(
      visibility: visibility ?? this.visibility,
      comments: comments ?? this.comments,
      tagging: tagging ?? this.tagging,
      archiveOldPosts: archiveOldPosts ?? this.archiveOldPosts,
      autoDelete: autoDelete ?? this.autoDelete,
      reactions: reactions ?? this.reactions,
      sharing: sharing ?? this.sharing,
      filterContent: filterContent ?? this.filterContent,
      language: language ?? this.language,
      aiModeration: aiModeration ?? this.aiModeration,
    );
  }
}

class PostSettingsNotifier extends StateNotifier<PostSettings> {
  PostSettingsNotifier()
      : super(PostSettings(
          visibility: "Public",
          comments: "Everyone",
          tagging: "Allow",
          archiveOldPosts: false,
          autoDelete: false,
          reactions: "Everyone",
          sharing: "Everyone",
          filterContent: false,
          language: "English",
          aiModeration: false,
        )) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = PostSettings(
      visibility: prefs.getString("visibility") ?? "Public",
      comments: prefs.getString("comments") ?? "Everyone",
      tagging: prefs.getString("tagging") ?? "Allow",
      archiveOldPosts: prefs.getBool("archiveOldPosts") ?? false,
      autoDelete: prefs.getBool("autoDelete") ?? false,
      reactions: prefs.getString("reactions") ?? "Everyone",
      sharing: prefs.getString("sharing") ?? "Everyone",
      filterContent: prefs.getBool("filterContent") ?? false,
      language: prefs.getString("language") ?? "English",
      aiModeration: prefs.getBool("aiModeration") ?? false,
    );
  }

  Future<void> updateSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    }
    state = state.copyWith(
      visibility: key == "visibility" ? value : state.visibility,
      comments: key == "comments" ? value : state.comments,
      tagging: key == "tagging" ? value : state.tagging,
      archiveOldPosts: key == "archiveOldPosts" ? value : state.archiveOldPosts,
      autoDelete: key == "autoDelete" ? value : state.autoDelete,
      reactions: key == "reactions" ? value : state.reactions,
      sharing: key == "sharing" ? value : state.sharing,
      filterContent: key == "filterContent" ? value : state.filterContent,
      language: key == "language" ? value : state.language,
      aiModeration: key == "aiModeration" ? value : state.aiModeration,
    );
  }
}
