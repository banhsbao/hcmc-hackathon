import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:badges/badges.dart' as badges;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gap/gap.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

import 'searchbar_container.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? searchBackgroundColor;
  final Color? titleColor;
  final Function()? onAddNew;
  final Function()? onFiltering;
  final Function()? onSearch;
  final Icon? leadingIcon;
  final List<Widget>? actions;
  final String? searchLabel;
  final String? title;
  final SystemUiOverlayStyle? customSystemOverlayUI;
  final TextEditingController? searchController;
  final Widget? bottomTabBar;
  final bool? backToFirst;
  final bool? isFiltering;
  final bool? showAddNew;
  final bool? showBtmShadow;
  final bool? showFiltering;
  final bool? showLeadingBtn;
  final bool? showSearchBar;
  final bool? showSystemOverlay;
  final bool? showTitle;
  final bool? showTitleCenter;
  final double? preferSize;

  const CustomAppBar({
    super.key,
    this.actions,
    this.backToFirst = false,
    this.backgroundColor,
    this.bottomTabBar,
    this.customSystemOverlayUI,
    this.iconColor,
    this.isFiltering = false,
    this.leadingIcon,
    this.onAddNew,
    this.onFiltering,
    this.onSearch,
    this.preferSize = kToolbarHeight,
    this.searchBackgroundColor,
    this.searchController,
    this.searchLabel,
    this.showAddNew = false,
    this.showBtmShadow = false,
    this.showFiltering = false,
    this.showLeadingBtn = false,
    this.showSearchBar = false,
    this.showSystemOverlay = false,
    this.showTitle = true,
    this.showTitleCenter = false,
    this.title,
    this.titleColor,
  });

  @override
  Size get preferredSize {
    const searchBarHeight = kToolbarHeight;
    var height = showTitle == false ? 16.0 : preferSize!;

    if (showSearchBar!) {
      height += searchBarHeight;
    }

    if (bottomTabBar != null) {
      height += 56;
    }

    return Size.fromHeight(height);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: showBtmShadow == true
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: $r.theme.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 12,
                ),
              ],
            )
          : const BoxDecoration(),
      child: AppBar(
        //* Options
        systemOverlayStyle: showSystemOverlay == true
            ? SystemUiOverlayStyle(
                statusBarColor: Theme.of(context).colorScheme.primary,
                systemNavigationBarColor:
                    Theme.of(context).colorScheme.onInverseSurface,
              )
            : customSystemOverlayUI,
        automaticallyImplyLeading: showLeadingBtn!,
        leadingWidth: width / 11,
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        shadowColor: $r.theme.grey,
        elevation: 0,
        centerTitle: showTitleCenter,

        //* Content
        leading: showLeadingBtn == false
            ? null
            : CupertinoButton(
                padding: EdgeInsets.only(left: width / 40),
                onPressed: () => backToFirst == false
                    ? Navigator.pop(context)
                    : Future.delayed(
                        Duration.zero,
                        () => Navigator.of(context)
                            .popUntil((route) => route.isFirst),
                      ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8),
                  child: leadingIcon ??
                      Icon(
                        FluentIcons.ios_arrow_ltr_24_regular,
                        size: 18,
                        color:
                            iconColor ?? Theme.of(context).colorScheme.surface,
                      ),
                ),
              ),
        title: showTitle == false
            ? null
            : Text(
                title!,
                style: $r.styles.pSemiBold.copyWith(
                  color: titleColor ?? Theme.of(context).colorScheme.onPrimary,
                  fontSize: 18,
                ),
              ),
        actions: actions ?? [],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Column(
            children: [
              if (showSearchBar == false)
                const SizedBox.shrink()
              else
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 4,
                    bottom: 4,
                    start: 24,
                    end: 24,
                  ),
                  // color: Colors.red,
                  child: showFiltering == true || showAddNew == true
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 7,
                              child: SearchBarContainer(
                                controller: searchController,
                                onSearch: onSearch,
                                fillColor: searchBackgroundColor,
                                searchLabel: searchLabel,
                              ),
                            ),
                            if (showFiltering == true) ...[
                              const Gap(16),
                              Expanded(
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  borderRadius: BorderRadius.circular(14),
                                  onPressed: onFiltering,
                                  child: badges.Badge(
                                    showBadge: isFiltering!,
                                    position: badges.BadgePosition.topEnd(),
                                    badgeStyle: badges.BadgeStyle(
                                      badgeColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Icon(
                                      FluentIcons.filter_28_filled,
                                      color: isFiltering == true
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : $r.theme.grey1,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            if (showAddNew == true) ...[
                              const Gap(16),
                              Expanded(
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  borderRadius: BorderRadius.circular(14),
                                  onPressed: onAddNew,
                                  child: Icon(
                                    FluentIcons.add_square_28_regular,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        )
                      : SearchBarContainer(
                          controller: searchController,
                          onSearch: onSearch,
                          fillColor: searchBackgroundColor,
                          searchLabel: searchLabel,
                        ),
                ),
              bottomTabBar ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
