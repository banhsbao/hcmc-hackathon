import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

class SearchBarContainer extends StatefulWidget {
  final Color? fillColor;
  final Function()? onSearch;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final bool hasShadow;
  final String? searchLabel;

  const SearchBarContainer({
    super.key,
    this.controller,
    this.onSearch,
    this.fillColor,
    this.contentPadding,
    this.hasShadow = false,
    this.searchLabel,
  });

  @override
  State<SearchBarContainer> createState() => _SearchBarContainerState();
}

class _SearchBarContainerState extends State<SearchBarContainer> {
  bool isEditing = false;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() => isEditing = false);
      } else {
        if (widget.controller?.text.isNotEmpty ?? false) {
          setState(() => isEditing = true);
        }
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: widget.hasShadow
            ? [
                BoxShadow(
                  color: $r.theme.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(2, 0),
                ),
              ]
            : null,
      ),
      child: TextFormField(
        controller: widget.controller,
        onChanged: (value) => setState(() {
          widget.controller?.text = value;
          widget.controller?.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller!.text.length),
          );
          widget.onSearch?.call();
          setState(() => isEditing = true);
        }),
        style: $r.styles.pRegular.copyWith(fontSize: 14),
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: widget.fillColor ?? Theme.of(context).colorScheme.surface,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                vertical: 12,
              ),
          hintText: widget.searchLabel ?? localeLang.search,
          hintStyle: $r.styles.pMedium.copyWith(
            color: $r.theme.grey,
            fontSize: 14,
          ),
          labelStyle: $r.styles.pMedium.copyWith(
            color: $r.theme.grey,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            FluentIcons.search_24_regular,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          suffixIcon: Visibility(
            visible: isEditing,
            child: IconButton(
              tooltip: localeLang.clearForm,
              icon: const Icon(
                Icons.close,
                color: Colors.red,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  widget.controller?.clear();
                  widget.onSearch?.call();
                });
              },
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: $r.theme.grey4),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: $r.theme.grey3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
    );
  }
}
