# Code FA

Language: English | [中文简体](README-ZH.md)

![release](https://img.shields.io/github/v/release/nightmare-space/code_lfa) 
[![Last Commits](https://img.shields.io/github/last-commit/nightmare-space/code_lfa?logo=git&logoColor=white)](https://github.com/nightmare-space/code_lfa/commits/master)
[![Pull Requests](https://img.shields.io/github/issues-pr/nightmare-space/code_lfa?logo=github&logoColor=white)](https://github.com/nightmare-space/code_lfa/pulls)
[![Code size](https://img.shields.io/github/languages/code-size/nightmare-space/code_lfa?logo=github&logoColor=white)](https://github.com/nightmare-space/code_lfa)
[![License](https://img.shields.io/github/license/nightmare-space/code_lfa?logo=open-source-initiative&logoColor=green)](https://github.com/nightmare-space/code_lfa/blob/master/LICENSE)
 ![Platform](https://img.shields.io/badge/support%20platform-android%20-purple) ![download time](https://img.shields.io/github/downloads/nightmare-space/code_lfa/total) ![open issues](https://img.shields.io/github/issues/nightmare-space/code_lfa) ![fork](https://img.shields.io/github/forks/nightmare-space/code_lfa?style=social) ![code line](https://img.shields.io/tokei/lines/github/nightmare-space/code_lfa) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/f969750dc4aa424ead664219ddcf321d)](https://app.codacy.com/gh/nightmare-space/code_lfa?utm_source=github.com&utm_medium=referral&utm_content=nightmare-space/code_lfa&utm_campaign=Badge_Grade)

This is an Android version of VS Code implemented using code-server. Some have already implemented similar solutions, and this is one of them.

The package size is relatively large since the resources required are necessary for the initial run, so integrating them into the server and dynamically downloading them is not very meaningful.

Users should weigh this solution against others available from different developers.

The principle is to run code-server and then use a webview to load the view. There might be some bugs, but it performs reasonably well.

This project is open source, with the upper framework being Flutter. The loading of VS Code is implemented in Flutter, and VS Code runs in the Android WebView.

I'm quite busy, so responses to issues might be slow. Thank you for your understanding.

Cheers! 🍻

## Features

- Fully local operation of Code Server
- Supports the latest version 4.103.1
- Supports quick updates to Code-Server versions
- Supports custom Code-Server versions
- Can run without an internet connection

## Changing Code-Server Version

1. Create a file named `code_version` in /sdcard with the version number as its content, such as `4.103.1`, without any line breaks.

2. Download code-server such as [code-server-4.103.1-linux-arm64.tar.gz](https://github.com/coder/code-server/releases/download/v4.13.0/code-server-4.103.1-linux-arm64.tar.gz)

3. Place the downloaded file in /sdcard. Do not unzip or change its filename.

4. Download the corresponding version and place it in /sdcard. Do not unzip or change its filename.

5. Launch Code FA, and enjoy it!

## Note

Code Server runs in an Ubuntu environment, not in a Termux environment. Therefore, if you need to install any dependencies, simply look up how to install them on Ubuntu.

## Installing Internal Dependencies

This section shouldn't really be here because it's not a Code FA issue, but many people don't know how to install simple dependencies on Ubuntu, and all related questions end up being directed to Code FA.

Update package lists

```bash
apt update
```

Install any dependency
```bash
apt install python3
apt install clang
...
```

## Git History

[![Star History Chart](https://api.star-history.com/svg?repos=nightmare-space/vscode_for_android&type=Date)](https://star-history.com/#nightmare-space/vscode_for_android&Date)
