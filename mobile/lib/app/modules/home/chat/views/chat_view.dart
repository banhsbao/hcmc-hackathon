import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/constants/resources/assets.gen.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/base/base_silver_view.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/custom_appbar.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/keyboard_dismisser.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/svg_asset.dart';

import '../controllers/chat_controller.dart';

class ChatView extends BaseSilverView<ChatController> {
  const ChatView({super.key});

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: KeyboardDismisser(
          child: Stack(
            children: [
              //* Background
              Container(
                width: width.w,
                height: height / 6,
                color: Theme.of(context).colorScheme.primary,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        SvgAsset(
                          height: height,
                          width: constraints.maxWidth,
                          Assets.svgs.vectorCurved1.path,
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: SvgAsset(
                            height: constraints.maxHeight + 10,
                            width: constraints.maxWidth,
                            Assets.svgs.backgroundPattern.path,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              //* Appbar
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: CustomAppBar(
                  title: 'Chat',
                  showLeadingBtn: true,
                  showTitleCenter: true,
                  backgroundColor: $r.theme.transparent,
                ),
              ),

              //* Body
              Column(
                children: [
                  Container(
                    height: height / 6,
                  ),

                  //* Chat List
                  Expanded(
                    child: Chat(
                      messages: controller.messages,
                      onAttachmentPressed: controller.handleAttachmentPressed,
                      onMessageTap: controller.handleMessageTap,
                      onPreviewDataFetched: controller.handlePreviewDataFetched,
                      onSendPressed: controller.handleSendPressed,
                      showUserAvatars: true,
                      showUserNames: true,
                      user: controller.user,
                      avatarBuilder: (user) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          backgroundColor: $r.theme.transparent,
                          radius: 19,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              Assets.svgs.chatbot.path,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                      ),
                      theme: DefaultChatTheme(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        primaryColor: Theme.of(context).colorScheme.secondary,
                        //
                        sendingIcon: Icon(
                          FluentIcons.send_20_regular,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        sendButtonIcon: Icon(
                          FluentIcons.send_20_regular,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        sentMessageBodyTextStyle: $r.styles.pMedium.copyWith(
                          color: $r.theme.white,
                          fontSize: 16,
                          height: 1.5,
                        ),
                        inputBackgroundColor:
                            Theme.of(context).colorScheme.surface,
                        inputContainerDecoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        inputTextStyle: $r.styles.pMedium.copyWith(
                          fontSize: 16,
                          height: 1.5,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        inputTextDecoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          isCollapsed: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        inputTextColor: Theme.of(context).colorScheme.onSurface,
                        receivedMessageBodyTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                        dateDividerTextStyle: $r.styles.pMedium.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 12,
                          height: 1.333,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
