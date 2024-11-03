import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_card.dart';

import '../logic_holders/cubits/upload_media_cubit/upload_media_cubit.dart';

class UploadFileDialog extends StatefulWidget {
  final BuildContext dialogContext;
  const UploadFileDialog({super.key, required this.dialogContext});

  @override
  State<UploadFileDialog> createState() => _UploadFileDialogState();
}

class _UploadFileDialogState extends State<UploadFileDialog> {
  List<PlatformFile> listOfUploadFiles = [];

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
          // TODO: make this disable while uploading
          TextButton.icon(
            onPressed: () {
              Navigator.of(widget.dialogContext).pop();
            },
            label: const Text("بازگشت"),
            iconAlignment: IconAlignment.end,
            icon: const Icon(
              Icons.chevron_left,
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
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
          Expanded(child: _listOfUploads()),
        ],
      ),
    );
  }

  FilledButton _pickFileButton() {
    return FilledButton(
      onPressed: _pickFile,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50),
      ),
      child: const Text("انتخاب فایل"),
    );
  }

  void _pickFile() async =>
      await FilePicker.platform.pickFiles(allowMultiple: false).then(
        (value) {
          if (value != null) {
            setState(() => listOfUploadFiles.add(value.files.first));
          }
        },
      );

  Widget _listOfUploads() {
    return ListView.separated(
      itemCount: listOfUploadFiles.length,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      itemBuilder: (context, index) => _uploadItem(index),
      separatorBuilder: (context, index) => const Gap(15),
    );
  }

  BlocProvider<UploadMediaCubit> _uploadItem(int index) {
    return BlocProvider(
      create: (context) => getIt<UploadMediaCubit>(),
      child: UploadCard(
        file: listOfUploadFiles[index],
      ),
    );
  }
}
