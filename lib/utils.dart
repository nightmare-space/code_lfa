import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:global_repository/global_repository.dart';
import 'package:tar/tar.dart';
import 'package:xterm/xterm.dart';

/// 收集 .tar.gz 中的硬链接映射
/// key 为链接文件在归档中的路径（entry.name）
/// value 为链接所指向的目标路径（header.linkName）
/// Collect hard link mappings in .tar.gz
/// key is the path of the link file in the archive (entry.name)
/// value is the target path of the link (header.linkName)
Future<Map<String, String>> getHardLinkMap(String tarGzPath) async {
  final result = <String, String>{};
  final stream = File(tarGzPath).openRead().transform(gzip.decoder);
  final reader = TarReader(stream);

  while (await reader.moveNext()) {
    final entry = reader.current;
    if (entry.type == TypeFlag.link) {
      final name = entry.header.name;
      final target = entry.header.linkName ?? '';
      if (name.isNotEmpty && target.isNotEmpty) {
        result[name] = target;
      }
    }
  }
  return result;
}

/// 使用 archive_io + TarFile 收集 .tar.gz 中的硬链接映射
/// key 为链接文件在归档中的路径（tf.filename）
/// value 为链接所指向的目标路径（tf.nameOfLinkedFile）
/// Collect hard link mappings in .tar.gz
/// key is the path of the link file in the archive (tf.filename)
/// value is the target path of the link (tf.nameOfLinkedFile)
Future<Map<String, String>> getHardLinkMapByArchive(String tarGzPath) async {
  final result = <String, String>{};
  final input = InputFileStream(tarGzPath);
  try {
    // 解压至内存
    final memOut = OutputMemoryStream();
    GZipDecoder().decodeStream(input, memOut);
    final tarBytes = memOut.getBytes();

    // 逐条读取 TarFile，保留 typeFlag/linkName 等信息
    final mem = InputMemoryStream(tarBytes);
    while (!mem.isEOS) {
      final tf = TarFile.read(mem);
      if (tf.filename.isEmpty) {
        // 安全退出：遇到结尾填充块
        break;
      }

      // typeFlag: '1' 为硬链接，'2' 为符号链接
      if (tf.typeFlag == '1') {
        final name = tf.filename;
        final target = tf.nameOfLinkedFile;
        if (name.isNotEmpty && target != null && target.isNotEmpty) {
          result[name] = target;
        }
      }
    }
  } finally {
    input.close();
  }
  return result;
}

MethodChannel _channel = const MethodChannel('vscode_channel');

/// 打开 WebView
/// Opens the WebView
void openWebView() {
  _channel.invokeMethod('open_webview');
}

/// 获取 Apk So 库路径
/// Gets the path of the Apk So library
Future<String> getLibPath() async {
  return await _channel.invokeMethod('lib_path');
}

Pty createPTY({
  String? shell,
}) {
  Map<String, String> envir = Map.from(Platform.environment);
  envir['HOME'] = RuntimeEnvir.homePath;
  // proot-distro install need
  envir['TERMUX_PREFIX'] = RuntimeEnvir.usrPath;
  envir['TERM'] = 'xterm-256color';
  envir['PATH'] = RuntimeEnvir.path;
  // proot deps
  envir['PROOT_LOADER'] = '${RuntimeEnvir.binPath}/loader';
  envir['LD_LIBRARY_PATH'] = RuntimeEnvir.binPath;

  return Pty.start(
    '/system/bin/sh',
    arguments: [],
    environment: envir,
    workingDirectory: RuntimeEnvir.homePath,
  );
}

extension TerminalExt on Terminal {
  void writeProgress(String data) {
    write('\x1b[31m- $data\x1b[0m\n\r');
  }
}

extension PTYExt on Pty {
  void writeString(String data) {
    write(Uint8List.fromList(utf8.encode(data)));
  }

  Future<void> defineFunction(String function) async {
    Log.i('define function start');
    Completer defineFunctionLock = Completer();
    Directory tmpDir = Directory(RuntimeEnvir.tmpPath);
    await tmpDir.create(recursive: true);
    String shortHash = hashCode.toRadixString(16).substring(0, 4);
    File shellFile = File('${tmpDir.path}/shell$shortHash');
    String patchFunction = '$function\n'
        r'''
    #printf "\033[A"
    #printf "\033[2K"
    #printf "\033[A"
    #printf "\033[2K"''';
    await shellFile.writeAsString(patchFunction);
    shellFile.watch(events: FileSystemEvent.delete).listen((event) {
      defineFunctionLock.complete();
    });
    File('${tmpDir.path}/shell${shortHash}backup').writeAsStringSync(function);
    // writeString('printf "\\033[?1049h"\n');
    writeString('source ${shellFile.path} &&');
    writeString('rm -rf ${shellFile.path} \n');
    //terminal?.buffer.eraseLine();
    // await Future.delayed(const Duration(milliseconds: 100));
    // writeString('printf "\\033[?1049l"\n');

    // bool fileExists = await shellFile.exists();
    // while (fileExists) {
    //   Log.v('File exists.');
    //   await Future.delayed(const Duration(milliseconds: 100)); // 每秒检查一次
    //   fileExists = await shellFile.exists();
    // }

    // 用 file watch 代替上面功能
    await defineFunctionLock.future;
    Log.i('define function -> done');
  }
}
