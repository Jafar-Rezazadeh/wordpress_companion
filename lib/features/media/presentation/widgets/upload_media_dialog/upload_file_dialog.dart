import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/uploader.dart';

class UploadFileDialog extends StatefulWidget {
  final BuildContext dialogContext;
  const UploadFileDialog({super.key, required this.dialogContext});

  @override
  State<UploadFileDialog> createState() {
    return _UploadFileDialogState();
  }
}

class _UploadFileDialogState extends State<UploadFileDialog> {
  List<Uploader> listOfUploader = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: edgeToEdgePaddingHorizontal,
            vertical: 20,
          ),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _header(),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _backButton(),
        ],
      ),
    );
  }

  Widget _backButton() {
    return TextButton.icon(
      key: const Key("back_button"),
      onPressed: () {
        _isNotUploading()
            ? Navigator.of(widget.dialogContext).pop()
            : _uploadingAlert();
      },
      label: const Text("بازگشت"),
      iconAlignment: IconAlignment.end,
      icon: const Icon(
        Icons.chevron_left,
        textDirection: TextDirection.ltr,
      ),
    );
  }

  Future<dynamic> _uploadingAlert() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        key: const Key("uploading_alert"),
        title: Text(
          "لطفا منتظر بمانید، در حال آپلود هستید",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }

  bool _isNotUploading() {
    return listOfUploader
        .every((uploader) => uploader.uploadingNotifier.value == false);
  }

  Widget _body() {
    return Expanded(
      flex: 9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _pickFileButton(),
          Divider(color: ColorPallet.border),
          _listOfUploader(),
        ],
      ),
    );
  }

  FilledButton _pickFileButton() {
    return FilledButton(
      key: const Key("pick_file_button"),
      onPressed: _pickFile,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50),
      ),
      child: const Text("انتخاب فایل"),
    );
  }

  void _pickFile() async => await FilePicker.platform
          .pickFiles(
        allowMultiple: true,
        allowedExtensions: allowedExtensions,
        type: FileType.custom,
      )
          .then(
        (value) {
          if (value != null) {
            _addUploader(value);
          }
        },
      );

  void _addUploader(FilePickerResult value) => setState(
        () => listOfUploader.addAll(
          value.files.map(
            (e) => Uploader(file: e, onRemove: _onUploaderRemove),
          ),
        ),
      );

  _onUploaderRemove(Uploader uploader) {
    setState(
      () => listOfUploader.removeWhere((e) => e.key == uploader.key),
    );
  }

  Widget _listOfUploader() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: listOfUploader.withGapInBetween(10),
        ),
      ),
    );
  }
}
