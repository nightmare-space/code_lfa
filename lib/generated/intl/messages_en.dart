// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "copy_code_server": MessageLookupByLibrary.simpleMessage(
      "Copy code-server to data directory",
    ),
    "copy_proot_distro": MessageLookupByLibrary.simpleMessage(
      "Copy proot-distro to data directory",
    ),
    "copy_ubuntu": MessageLookupByLibrary.simpleMessage(
      "Copy ubuntu to data directory",
    ),
    "create_busybox_symlink": MessageLookupByLibrary.simpleMessage(
      "Create Busybox symlink",
    ),
    "create_terminal_obj": MessageLookupByLibrary.simpleMessage(
      "Create PTY Terminal Instance",
    ),
    "current_code_version": MessageLookupByLibrary.simpleMessage(
      "Current VS Code Server Version",
    ),
    "define_functions": MessageLookupByLibrary.simpleMessage(
      "Define functions to be used",
    ),
    "gen_script": MessageLookupByLibrary.simpleMessage(
      "Generate Fix Hardlink Script",
    ),
    "installed": MessageLookupByLibrary.simpleMessage("Installed"),
    "installing": MessageLookupByLibrary.simpleMessage("Installing"),
    "listen_vscode_start": MessageLookupByLibrary.simpleMessage(
      "Listen for VS Code start status to jump to Web View",
    ),
    "ubuntu_not_installed": MessageLookupByLibrary.simpleMessage(
      "Ubuntu not installed, installing",
    ),
    "uninstalled": MessageLookupByLibrary.simpleMessage("Not Installed"),
  };
}
