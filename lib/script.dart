import 'package:global_repository/global_repository.dart';
import 'config.dart';
import 'generated/l10n.dart';

// proot distro，ubuntu path
String prootDistroPath = '${RuntimeEnvir.usrPath}/var/lib/proot-distro';
String ubuntuPath = '$prootDistroPath/installed-rootfs/ubuntu';
String ubuntuName = Config.ubuntuFileName.replaceAll(RegExp('-pd.*'), '');

String common = '''
export TMPDIR=${RuntimeEnvir.tmpPath}
export BIN=${RuntimeEnvir.binPath}
export UBUNTU_PATH=$ubuntuPath
export UBUNTU=${Config.ubuntuFileName}
export UBUNTU_NAME=$ubuntuName
export CSPORT=${Config.port}
export CSVERSION=${Config.codeServerVersion}
export L_NOT_INSTALLED=${S.current.uninstalled}
export L_INSTALLING=${S.current.installing}
export L_INSTALLED=${S.current.installed}
clear_lines(){
  printf "\\033[1A" # Move cursor up one line
  printf "\\033[K"  # Clear the line
  printf "\\033[1A" # Move cursor up one line
  printf "\\033[K"  # Clear the line
}
progress_echo(){
  echo -e "\\033[31m- \$@\\033[0m"
  echo "\$@" > "\$TMPDIR/progress_des"
}
bump_progress(){
  current=0
  if [ -f "\$TMPDIR/progress" ]; then
    current=\$(cat "\$TMPDIR/progress" 2>/dev/null || echo 0)
  fi
  next=\$((current + 1))
  printf "\$next" > "\$TMPDIR/progress"
}
''';

// 切换到清华源
// Switch to Tsinghua source
String changeUbuntuNobleSource = r'''
change_ubuntu_source(){
  cat <<EOF > $UBUNTU_PATH/etc/apt/sources.list
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
# Defaultly commented out source mirrors to speed up apt update, uncomment if needed
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-backports main restricted universe multiverse

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
# The following security update software sources include both official and mirror configurations, modify comments to switch if needed
# deb http://ports.ubuntu.com/ubuntu-ports/ noble-security main restricted universe multiverse
# deb-src http://ports.ubuntu.com/ubuntu-ports/ noble-security main restricted universe multiverse

# 预发布软件源，不建议启用
# The following pre-release software sources are not recommended to be enabled
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-proposed main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-proposed main restricted universe multiverse
EOF
}
''';

/// 安装ubuntu的shell
String genCodeConfig = r'''
gen_code_server_config(){
  mkdir -p $UBUNTU_PATH/root/.config/code-server 2>/dev/null
  echo "
  bind-addr: 0.0.0.0:$CSPORT
  auth: none
  password: none
  cert: false
  " > $UBUNTU_PATH/root/.config/code-server/config.yaml
}
''';

String installUbuntu = r'''
install_ubuntu(){
  mkdir -p $UBUNTU_PATH 2>/dev/null
  if [ -z "$(ls -A $UBUNTU_PATH)" ]; then
    progress_echo "Ubuntu $L_NOT_INSTALLED, $L_INSTALLING..."
    ls ~/$UBUNTU
    busybox tar xvf ~/$UBUNTU -C $UBUNTU_PATH/ | while read line; do
      # echo -ne "\033[2K\0337\r$line\0338"
      echo -ne "\033[2K\r$line"
    done
    echo
    mv $UBUNTU_PATH/$UBUNTU_NAME/* $UBUNTU_PATH/
    rm -rf $UBUNTU_PATH/$UBUNTU_NAME
    echo 'export PATH=/opt/code-server-$CSVERSION-linux-arm64/bin:$PATH' >> $UBUNTU_PATH/root/.bashrc
    echo 'export ANDROID_DATA=/home/' >> $UBUNTU_PATH/root/.bashrc
  else
    VERSION=`cat $UBUNTU_PATH/etc/issue.net 2>/dev/null`
    # VERSION=`cat $UBUNTU_PATH/etc/issue 2>/dev/null | sed 's/\\n//g' | sed 's/\\l//g'`
    progress_echo "Ubuntu $L_INSTALLED -> $VERSION"
  fi
  change_ubuntu_source
  echo 'nameserver 8.8.8.8' > $UBUNTU_PATH/etc/resolv.conf
}
''';

// 安装 proot-distro 的脚本
// install proot-distro script
String installProotDistro = r'''
install_proot_distro(){
  proot_distro_path=`which proot-distro`
  if [ -z "$proot_distro_path" ]; then
    progress_echo "proot-distro $L_NOT_INSTALLED, $L_INSTALLING..."
    cd ~
    busybox unzip proot-distro.zip -d proot-distro
    cd ~/proot-distro
    bash ./install.sh
  else
    progress_echo "proot-distro $L_INSTALLED"
  fi
}
''';

@Deprecated('Use genFixCodeServerHardLinkShell instead')
String fixCodeServerHardLink = r'''
fix_code_server_hard_link(){
  cd $UBUNTU_PATH/opt/code-server-$CSVERSION-linux-arm64/
  ls node_modules/argon2/build-tmp-napi-v3/Release
  cp node_modules/argon2/build-tmp-napi-v3/Release/argon2.node node_modules/argon2/build-tmp-napi-v3/Release/obj.target/argon2.node
  cp node_modules/argon2/build-tmp-napi-v3/Release/argon2.a node_modules/argon2/build-tmp-napi-v3/Release/obj.target/argon2.a
  cp node_modules/argon2/build-tmp-napi-v3/Release/argon2.node node_modules/argon2/lib/binding/napi-v3/argon2.node
  cp lib/vscode/node_modules/@parcel/watcher/build/Release/obj.target/watcher.node lib/vscode/node_modules/@parcel/watcher/build/Release/watcher.node
  cp lib/vscode/node_modules/@parcel/watcher/build/Release/nothing.a lib/vscode/node_modules/@parcel/watcher/build/node-addon-api/nothing.a
  cp lib/vscode/node_modules/kerberos/build/Release/kerberos.node lib/vscode/node_modules/kerberos/build/Release/obj.target/kerberos.node
  cp lib/vscode/node_modules/native-watchdog/build/Release/watchdog.node lib/vscode/node_modules/native-watchdog/build/Release/obj.target/watchdog.node
  cp lib/vscode/node_modules/@vscode/windows-registry/build/Release/obj.target/winregistry.node lib/vscode/node_modules/@vscode/windows-registry/build/Release/winregistry.node
  cp lib/vscode/node_modules/@vscode/windows-process-tree/build/Release/windows_process_tree.node lib/vscode/node_modules/@vscode/windows-process-tree/build/Release/obj.target/windows_process_tree.node
  cp lib/vscode/node_modules/@vscode/spdlog/build/Release/spdlog.node lib/vscode/node_modules/@vscode/spdlog/build/Release/obj.target/spdlog.node
  cp lib/vscode/node_modules/@vscode/deviceid/build/Release/windows.node lib/vscode/node_modules/@vscode/deviceid/build/Release/obj.target/windows.node
}
''';

String genFixCodeServerHardLinkShell(Map<String, String> map) {
  final buf = StringBuffer();
  buf.writeln(r'fix_code_server_hard_link(){');
  buf.writeln(r'  cd $UBUNTU_PATH/opt');
  map.forEach((key, value) {
    buf.writeln('  cp $value $key');
  });
  buf.writeln('}');
  return buf.toString();
}

// TODO(Lin): 用 ESC 7 8 来实现，不然在手机上仍然会打印出很多行
String installVSCodeServer = r'''
install_vs_code(){
  if [ ! -d "$UBUNTU_PATH/opt/code-server-$CSVERSION-linux-arm64" ];then
    tar zxfh $TMPDIR/code-server-$CSVERSION-linux-arm64.tar.gz -C $UBUNTU_PATH/opt | while read line; do
      echo -ne "\033[2K\r$line"
    done
    # progress_echo "pwd: `pwd`"
    fix_code_server_hard_link
    # progress_echo "pwd: `pwd`"
  else
    progress_echo "Code Server $L_INSTALLED"
  fi
}
''';

String loginUbuntu = r'''
login_ubuntu(){
  bash $BIN/proot-distro login --bind /storage/emulated/0:/sdcard/ ubuntu --isolated  -- /opt/code-server-$CSVERSION-linux-arm64/bin/code-server
}
''';

String commonScript = '''
$common
$changeUbuntuNobleSource
$installVSCodeServer
$genCodeConfig
$installUbuntu
$loginUbuntu
$installProotDistro
clear_lines
start_vs_code(){
  install_proot_distro
  # return
  sleep 1
  bump_progress
  install_ubuntu
  sleep 1
  bump_progress
  install_vs_code
  sleep 1
  bump_progress
  gen_code_server_config
  sleep 1
  bump_progress
  login_ubuntu
}
''';
