import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/upload_card.dart';

import '../../../../../core/core_export.dart';
import '../../logic_holders/cubits/upload_media_cubit/upload_media_cubit.dart';

class Uploader extends StatefulWidget {
  @override
  Key? get key => ValueKey(file);
  final PlatformFile file;
  final Function(Uploader) onRemove;
  final ValueNotifier<bool> uploadingNotifier;

  Uploader({
    super.key,
    required this.file,
    required this.onRemove,
  }) : uploadingNotifier = ValueNotifier(false);

  @override
  State<Uploader> createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  isUploading(bool value) {
    widget.uploadingNotifier.value = value;
  }

  @override
  void dispose() {
    widget.uploadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UploadMediaCubit>(),
      child: UploadCard(
        onRemove: (file) => widget.onRemove(widget),
        file: widget.file,
        isUploading: isUploading,
      ),
    );
  }
}
