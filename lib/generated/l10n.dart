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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Create PTY Terminal Instance`
  String get create_terminal_obj {
    return Intl.message(
      'Create PTY Terminal Instance',
      name: 'create_terminal_obj',
      desc: '',
      args: [],
    );
  }

  /// `Current VS Code Server Version`
  String get current_code_version {
    return Intl.message(
      'Current VS Code Server Version',
      name: 'current_code_version',
      desc: '',
      args: [],
    );
  }

  /// `Copy proot-distro to data directory`
  String get copy_proot_distro {
    return Intl.message(
      'Copy proot-distro to data directory',
      name: 'copy_proot_distro',
      desc: '',
      args: [],
    );
  }

  /// `Copy ubuntu to data directory`
  String get copy_ubuntu {
    return Intl.message(
      'Copy ubuntu to data directory',
      name: 'copy_ubuntu',
      desc: '',
      args: [],
    );
  }

  /// `Create Busybox symlink`
  String get create_busybox_symlink {
    return Intl.message(
      'Create Busybox symlink',
      name: 'create_busybox_symlink',
      desc: '',
      args: [],
    );
  }

  /// `Copy code-server to data directory`
  String get copy_code_server {
    return Intl.message(
      'Copy code-server to data directory',
      name: 'copy_code_server',
      desc: '',
      args: [],
    );
  }

  /// `Define functions to be used`
  String get define_functions {
    return Intl.message(
      'Define functions to be used',
      name: 'define_functions',
      desc: '',
      args: [],
    );
  }

  /// `Ubuntu not installed, installing`
  String get ubuntu_not_installed {
    return Intl.message(
      'Ubuntu not installed, installing',
      name: 'ubuntu_not_installed',
      desc: '',
      args: [],
    );
  }

  /// `Listen for VS Code start status to jump to Web View`
  String get listen_vscode_start {
    return Intl.message(
      'Listen for VS Code start status to jump to Web View',
      name: 'listen_vscode_start',
      desc: '',
      args: [],
    );
  }

  /// `Installed`
  String get installed {
    return Intl.message('Installed', name: 'installed', desc: '', args: []);
  }

  /// `Installing`
  String get installing {
    return Intl.message('Installing', name: 'installing', desc: '', args: []);
  }

  /// `Uninstalled`
  String get uninstalled {
    return Intl.message('Uninstalled', name: 'uninstalled', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
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
