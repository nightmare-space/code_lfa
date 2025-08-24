// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
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
  String get localeName => 'zh_CN';

  static String m0(param) => "拷贝 code-server${param} 到数据目录";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "copy_code_server": m0,
    "copy_proot_distro": MessageLookupByLibrary.simpleMessage(
      "拷贝 proot-distro 到数据目录",
    ),
    "copy_ubuntu": MessageLookupByLibrary.simpleMessage("拷贝 ubuntu 到数据目录"),
    "create_busybox_symlink": MessageLookupByLibrary.simpleMessage(
      "创建 Busybox 符号链接",
    ),
    "create_terminal_obj": MessageLookupByLibrary.simpleMessage("创建 PTY 终端实例"),
    "current_code_version": MessageLookupByLibrary.simpleMessage(
      "当前 VS Code Server 版本",
    ),
    "define_functions": MessageLookupByLibrary.simpleMessage("定义需要使用的函数"),
    "gen_script": MessageLookupByLibrary.simpleMessage("生成硬链接修复脚本"),
    "installed": MessageLookupByLibrary.simpleMessage("已安装"),
    "installing": MessageLookupByLibrary.simpleMessage("安装中"),
    "listen_vscode_start": MessageLookupByLibrary.simpleMessage(
      "监听VS Code启动状态以跳转Web View",
    ),
    "ubuntu_not_installed": MessageLookupByLibrary.simpleMessage(
      "Ubuntu 未安装, 安装中",
    ),
    "uninstalled": MessageLookupByLibrary.simpleMessage("未安装"),
  };
}
