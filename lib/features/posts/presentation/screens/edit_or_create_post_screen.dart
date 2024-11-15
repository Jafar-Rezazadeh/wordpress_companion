import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:gap/gap.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';
import 'package:wordpress_companion/features/posts/presentation/login_holders/utils/post_status_filter.dart';

class EditOrCreatePostScreen extends StatefulWidget {
  final PostEntity? post;
  final PostParamsBuilder? postParamsBuilderTest;

  const EditOrCreatePostScreen(
      {super.key, this.post, this.postParamsBuilderTest});

  @override
  State<EditOrCreatePostScreen> createState() => _EditOrCreatePostScreenState();
}

class _EditOrCreatePostScreenState extends State<EditOrCreatePostScreen> {
  late final QuillController contentController;
  late final PostParamsBuilder _postParamsBuilder;
  final List<PostStatusEnum> validPostStatusAsParams =
      PostStatusFilter.validPostStatusAsParam();

  @override
  void initState() {
    super.initState();
    _initializeQuillController();
    _initializeParamsBuilder();
  }

  void _initializeQuillController() {
    contentController = QuillController.basic();

    if (widget.post?.content.isNotEmpty == true) {
      contentController.document = Document.fromDelta(
        HtmlToDelta().convert(
          widget.post?.content ?? "",
        ),
      );
    }

    contentController.addListener(() {
      final delta = contentController.document.toDelta();
      final htmlText = QuillDeltaToHtmlConverter(delta.toJson()).convert();

      _postParamsBuilder.setContent(htmlText);
    });
  }

  void _initializeParamsBuilder() {
    _postParamsBuilder = widget.postParamsBuilderTest ?? PostParamsBuilder();
    if (widget.post != null) {
      _postParamsBuilder.setInitialValues(widget.post!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
      showLoading: _ifStateIsLoading(context),
      bottomLeadingWidgets: [_saveButton(context)],
      bottomActionWidgets: [
        if (widget.post != null) _deleteButton(),
        if (widget.post != null) const Gap(10),
        _statusInput(),
      ],
    );
  }

  bool? _ifStateIsLoading(BuildContext context) {
    return context
        .watch<PostsCubit>()
        .state
        .maybeWhen(loading: () => true, orElse: () => false);
  }

  SaveButton _saveButton(BuildContext context) {
    return SaveButton(
      key: const Key("submit_button"),
      onPressed: () => _createOrUpdatePost(),
    );
  }

  void _createOrUpdatePost() {
    if (widget.post != null) {
      context.read<PostsCubit>().updatePosts(_postParamsBuilder.build());
    } else {
      context.read<PostsCubit>().createPosts(_postParamsBuilder.build());
    }
  }

  IconButton _deleteButton() {
    return IconButton(
      key: const Key("delete_button"),
      icon: const Icon(Icons.delete_outline),
      color: ColorPallet.crimson,
      iconSize: 30,
      onPressed: () => _showAreYouSureDialog(),
    );
  }

  void _showAreYouSureDialog() {
    CustomDialogs.showAreYouSureDialog(
      context: context,
      title: "حذف برای همیشه!",
      content:
          "آیا مطمئن هستید که میخواهید (${widget.post?.title}) را برای همیشه حذف کنید ؟",
      onConfirm: () {
        if (widget.post != null) {
          context.read<PostsCubit>().deletePost(widget.post!.id);
          Navigator.of(context).pop();
        }
      },
    );
  }

  Widget _statusInput() {
    return CustomDropDownButton<PostStatusEnum>(
      initialValue: _validateStatusAsParams(),
      items: validPostStatusAsParams
          .map(
            (status) => DropdownMenuItem<PostStatusEnum>(
              value: status,
              child: Text(status.translate()),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          _postParamsBuilder.setStatus(value);
        }
      },
    );
  }

  PostStatusEnum? _validateStatusAsParams() {
    if (validPostStatusAsParams.contains(_postParamsBuilder.status)) {
      return _postParamsBuilder.status;
    }
    return null;
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
              // TODO: make tags feature implemented it here
              const TagInputWidget(),
              _featuredImageInput(),
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
      onChanged: (value) => _postParamsBuilder.setTitle(value),
    );
  }

  CustomFormInputField _slug() {
    return CustomFormInputField(
      initialValue: Uri.decodeComponent(widget.post?.slug ?? ""),
      label: "نامک",
      onChanged: (value) => _postParamsBuilder.setSlug(value),
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
          _htmlEditorToolBar(),
          Divider(color: ColorPallet.border, thickness: 1),
          _htmlEditor()
        ],
      ),
    );
  }

  Widget _htmlEditorToolBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: QuillSimpleToolbar(
        controller: contentController,
        configurations: const QuillSimpleToolbarConfigurations(
          axis: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _htmlEditor() {
    return Expanded(
      child: QuillEditor.basic(
        controller: contentController,
        configurations: const QuillEditorConfigurations(
          padding: EdgeInsets.all(10),
        ),
      ),
    );
  }

  Widget _excerpt() {
    return CustomFormInputField(
      initialValue: widget.post?.excerpt,
      label: "چکیده",
      maxLines: 4,
      onChanged: (value) => _postParamsBuilder.setExcerpt(value),
    );
  }

  Widget _featuredImageInput() {
    return FeaturedImageInput(
      initialPostImageLink: widget.post?.featureMediaLink,
      onImageSelected: (image) => _postParamsBuilder.setFeaturedImage(image.id),
      onClearImage: () => _postParamsBuilder.setFeaturedImage(0),
    );
  }
}
