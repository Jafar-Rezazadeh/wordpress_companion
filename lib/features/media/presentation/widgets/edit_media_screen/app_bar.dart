import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordpress_companion/core/core_export.dart';

import '../../../media_exports.dart';

class EditMediaScreenAppBar {
  final BuildContext context;
  final MediaEntity mediaEntity;
  final Downloader downloader;
  final Function() onSubmit;

  EditMediaScreenAppBar({
    required this.context,
    required this.onSubmit,
    required this.mediaEntity,
    required this.downloader,
  });

  PushedScreenAppBar build() {
    return PushedScreenAppBar(
      context: context,
      title: "ویرایش رسانه",
      bottomLeadingWidgets: [_submitButton()],
      bottomActionWidgets: [
        _deleteButton(),
        _downloadButton(),
      ],
      showLoading: _isLoadingState(),
    );
  }

  bool _isLoadingState() {
    return context
        .watch<MediaCubit>()
        .state
        .maybeWhen(loading: () => true, orElse: () => false);
  }

  SaveButton _submitButton() {
    return SaveButton(
      key: const Key("save_button"),
      onPressed: () => onSubmit(),
    );
  }

  IconButton _deleteButton() {
    return IconButton(
      key: const Key("delete_button"),
      onPressed: () {
        CustomDialogs.showAreYouSureDialog(
          context: context,
          title: "حذف رسانه",
          content:
              "آیا مطمئن هستید که میخواهید (${mediaEntity.title}) را برای همیشه حذف کنید؟",
          onConfirm: _onDeleteConfirmed,
        );
      },
      iconSize: 30,
      color: ColorPallet.crimson,
      icon: const Icon(Icons.delete_outline),
    );
  }

  void _onDeleteConfirmed() {
    context.read<MediaCubit>().deleteMedia(mediaEntity.id);
    Navigator.of(context).pop();
  }

  IconButton _downloadButton() {
    return IconButton(
      key: const Key("download_button"),
      onPressed: () async => downloader.downloadFile(
        fileFullName: _getSourceUrlFullFileName(),
        url: mediaEntity.sourceUrl,
      ),
      icon: const Icon(Icons.file_download_outlined),
    );
  }

  String _getSourceUrlFullFileName() {
    return mediaEntity.sourceUrl.substring(
      mediaEntity.sourceUrl.lastIndexOf("/") + 1,
    );
  }
}
