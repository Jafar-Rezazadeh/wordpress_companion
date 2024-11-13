import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class EditOrCreatePostScreen extends StatefulWidget {
  final PostEntity? post;

  const EditOrCreatePostScreen({super.key, this.post});

  @override
  State<EditOrCreatePostScreen> createState() => _EditOrCreatePostScreenState();
}

class _EditOrCreatePostScreenState extends State<EditOrCreatePostScreen> {
  final contentHtmlEditorController = QuillEditorController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: _appBar(context),
        body: _body(),
      ),
    );
  }

  PushedScreenAppBar _appBar(BuildContext context) {
    return PushedScreenAppBar(
      context: context,
      title: widget.post != null ? "ویرایش پست" : "ایجاد پست",
      bottomLeadingWidgets: [
        SaveButton(
          key: const Key("submit_button"),
          onPressed: () {},
        ),
      ],
      bottomActionWidgets: [
        if (widget.post != null)
          IconButton(
            key: const Key("delete_button"),
            icon: const Icon(Icons.delete_outline),
            color: ColorPallet.crimson,
            iconSize: 30,
            onPressed: () {},
          ),
        if (widget.post != null) const Gap(10),
        CustomDropDownButton<PostStatus>(
          initialValue: widget.post?.status ?? PostStatus.publish,
          items: PostStatus.values
              .map((status) => DropdownMenuItem<PostStatus>(
                    value: status,
                    child: Text(status.translate()),
                  ))
              .toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: edgeToEdgePaddingHorizontal,
      ),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              CustomFormInputField(
                initialValue: widget.post?.title,
                label: "عنوان",
              ),
              CustomFormInputField(
                initialValue: widget.post?.slug,
                label: "نامک",
              ),
              _contentHtmlEditor(),
            ].withGapInBetween(30),
          ),
        ),
      ),
    );
  }

  Widget _contentHtmlEditor() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorPallet.border),
        borderRadius: BorderRadius.circular(smallCornerRadius),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ToolBar.scroll(
            controller: contentHtmlEditorController,
            textDirection: TextDirection.rtl,
          ),
          Divider(color: ColorPallet.border, height: 10),
          QuillHtmlEditor(
            controller: contentHtmlEditorController,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            autoFocus: true,
            minHeight: 300,
            onTextChanged: (p0) async {},
          ),
        ],
      ),
    );
  }
}
