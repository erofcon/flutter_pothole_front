// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Road monitoring system`
  String get app_title {
    return Intl.message(
      'Road monitoring system',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `info`
  String get sidebar_list_info {
    return Intl.message(
      'info',
      name: 'sidebar_list_info',
      desc: '',
      args: [],
    );
  }

  /// `Detection`
  String get sidebar_list_create {
    return Intl.message(
      'Detection',
      name: 'sidebar_list_create',
      desc: '',
      args: [],
    );
  }

  /// `Create task`
  String get sidebar_list_create_single_task {
    return Intl.message(
      'Create task',
      name: 'sidebar_list_create_single_task',
      desc: '',
      args: [],
    );
  }

  /// `Result of detection`
  String get sidebar_list_result_detection {
    return Intl.message(
      'Result of detection',
      name: 'sidebar_list_result_detection',
      desc: '',
      args: [],
    );
  }

  /// `Task list`
  String get sidebar_list_task_list {
    return Intl.message(
      'Task list',
      name: 'sidebar_list_task_list',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get sidebar_menu_tasks {
    return Intl.message(
      'Tasks',
      name: 'sidebar_menu_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get sidebar_menu_map {
    return Intl.message(
      'Map',
      name: 'sidebar_menu_map',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get sidebar_menu_report {
    return Intl.message(
      'Report',
      name: 'sidebar_menu_report',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get sidebar_menu_log_out {
    return Intl.message(
      'Logout',
      name: 'sidebar_menu_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Add task`
  String get button_add {
    return Intl.message(
      'Add task',
      name: 'button_add',
      desc: '',
      args: [],
    );
  }

  /// `view more`
  String get home_task_card_button {
    return Intl.message(
      'view more',
      name: 'home_task_card_button',
      desc: '',
      args: [],
    );
  }

  /// `Current tasks`
  String get home_task_card_1 {
    return Intl.message(
      'Current tasks',
      name: 'home_task_card_1',
      desc: '',
      args: [],
    );
  }

  /// `Completed tasks`
  String get home_task_card_2 {
    return Intl.message(
      'Completed tasks',
      name: 'home_task_card_2',
      desc: '',
      args: [],
    );
  }

  /// `Overdue tasks`
  String get home_task_card_3 {
    return Intl.message(
      'Overdue tasks',
      name: 'home_task_card_3',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get home_statistic_card_title {
    return Intl.message(
      'Statistics',
      name: 'home_statistic_card_title',
      desc: '',
      args: [],
    );
  }

  /// `Last files`
  String get home_last_file_grid_title {
    return Intl.message(
      'Last files',
      name: 'home_last_file_grid_title',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get task_grid_data {
    return Intl.message(
      'Date',
      name: 'task_grid_data',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get task_grid_category {
    return Intl.message(
      'Category',
      name: 'task_grid_category',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get task_grid_description {
    return Intl.message(
      'Description',
      name: 'task_grid_description',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get task_grid_state {
    return Intl.message(
      'State',
      name: 'task_grid_state',
      desc: '',
      args: [],
    );
  }

  /// `Curator`
  String get task_grid_curator {
    return Intl.message(
      'Curator',
      name: 'task_grid_curator',
      desc: '',
      args: [],
    );
  }

  /// `Executor`
  String get task_grid_executor {
    return Intl.message(
      'Executor',
      name: 'task_grid_executor',
      desc: '',
      args: [],
    );
  }

  /// `administrator`
  String get user_is_admin {
    return Intl.message(
      'administrator',
      name: 'user_is_admin',
      desc: '',
      args: [],
    );
  }

  /// `curator`
  String get user_is_curator {
    return Intl.message(
      'curator',
      name: 'user_is_curator',
      desc: '',
      args: [],
    );
  }

  /// `executor`
  String get user_is_executor {
    return Intl.message(
      'executor',
      name: 'user_is_executor',
      desc: '',
      args: [],
    );
  }

  /// `data load error`
  String get data_load_error {
    return Intl.message(
      'data load error',
      name: 'data_load_error',
      desc: '',
      args: [],
    );
  }

  /// `выберите категорию`
  String get select_category_dropdown {
    return Intl.message(
      'выберите категорию',
      name: 'select_category_dropdown',
      desc: '',
      args: [],
    );
  }

  /// `choose executor`
  String get select_related_user {
    return Intl.message(
      'choose executor',
      name: 'select_related_user',
      desc: '',
      args: [],
    );
  }

  /// `Run detection`
  String get run_detection {
    return Intl.message(
      'Run detection',
      name: 'run_detection',
      desc: '',
      args: [],
    );
  }

  /// `DateTime`
  String get dateTime {
    return Intl.message(
      'DateTime',
      name: 'dateTime',
      desc: '',
      args: [],
    );
  }

  /// `Attach video`
  String get attach_video {
    return Intl.message(
      'Attach video',
      name: 'attach_video',
      desc: '',
      args: [],
    );
  }

  /// `Select DateTime`
  String get select_date_time {
    return Intl.message(
      'Select DateTime',
      name: 'select_date_time',
      desc: '',
      args: [],
    );
  }

  /// `Select video`
  String get select_video {
    return Intl.message(
      'Select video',
      name: 'select_video',
      desc: '',
      args: [],
    );
  }

  /// `Accepted File Types: .mp4,  .MJPEG`
  String get accepted_video_types {
    return Intl.message(
      'Accepted File Types: .mp4,  .MJPEG',
      name: 'accepted_video_types',
      desc: '',
      args: [],
    );
  }

  /// `upload`
  String get upload {
    return Intl.message(
      'upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
