import 'package:code_lfa/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:xterm/xterm.dart';
import 'terminal_controller.dart';
import 'terminal_theme.dart';

class TerminalPage extends StatefulWidget {
  const TerminalPage({super.key});

  @override
  State<TerminalPage> createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  HomeController controller = Get.put(HomeController());
  ManjaroTerminalTheme terminalTheme = ManjaroTerminalTheme();
  bool visible = false || kDebugMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: visible ? terminalTheme.background : Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: PopScope(
          onPopInvokedWithResult: (didPop, result) {
            controller.pseudoTerminal!.writeString('\x03');
            Get.back();
          },
          canPop: true,
          child: GestureDetector(
            onTap: () {
              visible = !visible;
              setState(() {});
            },
            behavior: HitTestBehavior.translucent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Visibility(
                    visible: visible,
                    // IgnorePointer
                    child: AbsorbPointer(
                      absorbing: false,
                      child: TerminalView(
                        controller.terminal,
                        readOnly: false,
                        backgroundOpacity: 1,
                        theme: ManjaroTerminalTheme(),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Material(
                    borderRadius: BorderRadius.circular(12.w),
                    color: Theme.of(context).colorScheme.surface,
                    child: SizedBox(
                      width: 300.w,
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: RepaintBoundary(
                                child: LoadingProgress(
                                  minRadius: 6,
                                  strokeWidth: 3,
                                  increaseRadius: 3,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.w),
                            GetBuilder<HomeController>(builder: (controller) {
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 5.w,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primary.opacity02,
                                          borderRadius: BorderRadius.circular(3.w),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: 300.milliseconds,
                                        height: 5.w,
                                        width: 300.w * controller.progress,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primary,
                                          borderRadius: BorderRadius.circular(3.w),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.w),
                                  Text(
                                    controller.currentProgress.trim(),
                                    style: TextStyle(
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
