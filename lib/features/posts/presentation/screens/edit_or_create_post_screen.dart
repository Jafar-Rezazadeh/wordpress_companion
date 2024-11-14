import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:gap/gap.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class EditOrCreatePostScreen extends StatefulWidget {
  final PostEntity? post;

  const EditOrCreatePostScreen({super.key, this.post});

  @override
  State<EditOrCreatePostScreen> createState() => _EditOrCreatePostScreenState();
}

class _EditOrCreatePostScreenState extends State<EditOrCreatePostScreen> {
  late final QuillController contentController;

  final inputHtmlStringSample = '<p><em>awdawdawdawdawd</em></p>';

  @override
  void initState() {
    super.initState();
    contentController = QuillController.basic();
    contentController.document =
        Document.fromDelta(HtmlToDelta().convert(inputHtmlStringSample));
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
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
          onPressed: () {
            final delta = contentController.document.toDelta();
            final htmlText =
                QuillDeltaToHtmlConverter(delta.toJson()).convert();
            print(htmlText);
          },
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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: edgeToEdgePaddingHorizontal,
        ),
        child: Form(
          child: Column(
            children: [
              _title(),
              _slug(),

              _contentHtmlEditor(),
              _excerpt(),
              // TODO: category input
              const TagInputWidget(),
              const FeaturedImageInput(),
            ].withGapInBetween(40),
          ),
        ),
      ),
    );
  }

  CustomFormInputField _title() {
    return CustomFormInputField(
      initialValue: widget.post?.title,
      label: "عنوان",
    );
  }

  CustomFormInputField _slug() {
    return CustomFormInputField(
      initialValue: widget.post?.slug,
      label: "نامک",
    );
  }

  Widget _contentHtmlEditor() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorPallet.border),
        borderRadius: BorderRadius.circular(smallCornerRadius),
      ),
      padding: const EdgeInsets.all(10),
      height: 500,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: QuillSimpleToolbar(
              controller: contentController,
              configurations: const QuillSimpleToolbarConfigurations(
                axis: Axis.horizontal,
              ),
            ),
          ),
          Divider(color: ColorPallet.border, thickness: 1),
          Expanded(
            child: QuillEditor.basic(
              controller: contentController,
              configurations:
                  const QuillEditorConfigurations(padding: EdgeInsets.all(10)),
            ),
          )
        ],
      ),
    );
  }

  Widget _excerpt() {
    return const CustomFormInputField(
      label: "چکیده",
      maxLines: 4,
    );
  }
}
