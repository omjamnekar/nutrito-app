import 'package:nutrito/data/model/sections/settings.dart';

class PrimarySetupManager {
  PrimarySetupManager(
      {required this.id,
      required this.homeSetupManager,
      required this.settingSetupManager,
      required this.socialSetupManager,
      required this.searchSetupManager});

  String? id;

  HomeSetupManager? homeSetupManager;
  SettingSetupManager? settingSetupManager;
  SocialSetupManager? socialSetupManager;
  SearchSetupManager? searchSetupManager;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'homeSetupManager': homeSetupManager?.toMap(),
      'settingSetupManager': settingSetupManager?.toMap(),
      'socialSetupManager': socialSetupManager?.toMap(),
      'searchSetupManager': searchSetupManager?.toMap(),
    };
  }

  factory PrimarySetupManager.fromMap(Map<String, dynamic> map) {
    return PrimarySetupManager(
      id: map['id'],
      homeSetupManager: map['homeSetupManager'] != null
          ? HomeSetupManager.fromMap(map['homeSetupManager'])
          : null,
      settingSetupManager: map['settingSetupManager'] != null
          ? SettingSetupManager.fromMap(map['settingSetupManager'])
          : null,
      socialSetupManager: map['socialSetupManager'] != null
          ? SocialSetupManager.fromMap(map['socialSetupManager'])
          : null,
      searchSetupManager: map['searchSetupManager'] != null
          ? SearchSetupManager.fromMap(map['searchSetupManager'])
          : null,
    );
  }
}

class HomeSetupManager {
  Map<String, dynamic> data;
  HomeSetupManager({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory HomeSetupManager.fromMap(Map<String, dynamic> map) {
    return HomeSetupManager(
      data: Map<String, dynamic>.from(map['data']),
    );
  }
}

class SocialSetupManager {
  Map<String, dynamic> data;
  SocialSetupManager({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory SocialSetupManager.fromMap(Map<String, dynamic> map) {
    return SocialSetupManager(
      data: Map<String, dynamic>.from(map['data']),
    );
  }
}

class SearchSetupManager {
  Map<String, dynamic> data;
  SearchSetupManager({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory SearchSetupManager.fromMap(Map<String, dynamic> map) {
    return SearchSetupManager(
      data: Map<String, dynamic>.from(map['data']),
    );
  }
}
