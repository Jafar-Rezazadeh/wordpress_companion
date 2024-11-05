import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/utils/string_formatter.dart';
import 'package:wordpress_companion/features/media/presentation/logic_holders/cubits/upload_media_cubit/upload_media_cubit.dart';

class UploadCard extends StatefulWidget {
  @override
  Key? get key => UniqueKey();
  final PlatformFile file;
  final Function(PlatformFile file) onRemove;
  final Function(bool uploading) isUploading;
  const UploadCard({
    super.key,
    required this.file,
    required this.onRemove,
    required this.isUploading,
  });

  @override
  State<UploadCard> createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  late ValueNotifier<double> progressValueNotifier;
  CancelToken? _cancelToken;

  @override
  void initState() {
    progressValueNotifier = ValueNotifier<double>(0);
    super.initState();
  }

  @override
  void dispose() {
    progressValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: _cardDecoration(),
        child: _contents(),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          ColorPallet.midBlue,
          ColorPallet.blue,
        ],
      ),
      borderRadius: BorderRadius.circular(mediumCornerRadius),
    );
  }

  Widget _contents() {
    return BlocConsumer<UploadMediaCubit, UploadMediaState>(
      listener: _uploadMediaListener,
      builder: (_, state) => _uploadMediaContentBuilder(state),
    );
  }

  void _uploadMediaListener(_, UploadMediaState state) {
    widget.isUploading(_isUploading(state));
    state.whenOrNull(
      startingUpload: (cancelToken) => _cancelToken = cancelToken,
      uploading: (progress) => progressValueNotifier.value = progress,
    );
  }

  Widget _uploadMediaContentBuilder(UploadMediaState state) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fileDetails(state),
          _progress(state),
          if (!_isUploading(state)) _removeUploadItem(),
        ],
      ),
    );
  }

  bool _isUploading(UploadMediaState state) =>
      state.maybeWhen(uploading: (_) => true, orElse: () => false);

  Expanded _fileDetails(UploadMediaState state) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _uploadStatusInfo(state),
          _fileName(),
          _fileSize(),
        ],
      ),
    );
  }

  Widget _uploadStatusInfo(UploadMediaState state) {
    return state.when(
      initial: _initialStatus,
      startingUpload: (_) => Container(
        key: const Key("empty_container"),
      ),
      uploading: _uploadingStatus,
      uploaded: _uploadDoneStatus,
      error: _uploadFailureStatus,
    );
  }

  Widget _initialStatus() {
    return Text(
      key: const Key("initial_status"),
      "آپلود فایل",
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
          ),
    );
  }

  Widget _uploadingStatus(_) {
    return Row(
      key: const Key("uploading_status"),
      children: [
        Text(
          "در حال آپلود...",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
        const Gap(10),
        _cancelUploadButton(),
      ],
    );
  }

  Widget _cancelUploadButton() {
    return OutlinedButton(
      key: const Key("cancel_upload_button"),
      onPressed: () {
        if (_cancelToken != null) {
          context.read<UploadMediaCubit>().cancelMediaUpload(_cancelToken!);
        }
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: ColorPallet.lightBlue),
        foregroundColor: ColorPallet.lightBlue,
        padding: const EdgeInsets.all(2),
        visualDensity: VisualDensity.compact,
      ),
      child: Text(
        "لغو",
        style: TextStyle(color: ColorPallet.lightBlue),
      ),
    );
  }

  Widget _uploadDoneStatus() {
    return Text(
      key: const Key("upload_done_status"),
      "آپلود انجام شد.",
      style:
          Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
    );
  }

  Widget _uploadFailureStatus(Failure failure) {
    return Container(
      key: const Key("upload_failure_status"),
      child: failure is ServerFailure
          ? Flexible(
              key: const Key("server_failure_info"),
              child: Text(
                _failureMessage(failure),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white),
              ),
            )
          : Text(
              key: const Key("internal_failure_info"),
              "خطایی رخ داد!",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white),
            ),
    );
  }

  String _failureMessage(ServerFailure failure) {
    if (failure.dioException.requestOptions.cancelToken?.isCancelled == true) {
      return "بارگذاری لغو شد. ";
    } else {
      return "خطایی رخ داد: ${failure.response?.data["message"]}";
    }
  }

  Text _fileName() {
    return Text(
      "نام فایل: ${StringFormatter.shortenText(widget.file.name, 20, fromLast: true)}",
      style:
          Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
    );
  }

  Text _fileSize() {
    return Text(
      "اندازه ${filesize(widget.file.size)}",
      style:
          Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
    );
  }

  Expanded _progress(UploadMediaState state) {
    return Expanded(
      flex: 2,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        child: Stack(
          alignment: Alignment.center,
          textDirection: TextDirection.ltr,
          children: [
            _circleProgressBar(state),
            state.whenOrNull(
                  initial: () => _uploadButton(),
                  error: (_) => _refreshButton(),
                  uploaded: () => _doneIcon(),
                ) ??
                Container(),
          ],
        ),
      ),
    );
  }

  Widget _circleProgressBar(UploadMediaState state) {
    return SimpleCircularProgressBar(
      animationDuration: 1,
      backColor: ColorPallet.lightBlue.withOpacity(0.2),
      mergeMode: true,
      progressColors: const [Colors.white],
      startAngle: 0,
      backStrokeWidth: 10,
      progressStrokeWidth: 10,
      maxValue: 1,
      onGetText: _isUploading(state)
          ? (value) => Text(
                key: const Key("progress_text"),
                "${(value * 100).toInt()}%",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              )
          : null,
      fullProgressColor: Colors.white,
      valueNotifier: progressValueNotifier,
    );
  }

  Widget _uploadButton() {
    return _actionButton(
      key: const Key("upload_button"),
      onPressed: () {
        context.read<UploadMediaCubit>().uploadMedia(widget.file.path ?? "");
      },
      iconData: Icons.file_upload_outlined,
    );
  }

  IconButton _refreshButton() {
    return _actionButton(
      key: const Key("refresh_button"),
      iconData: Icons.refresh,
      onPressed: () {
        progressValueNotifier.value = 0;
        context.read<UploadMediaCubit>().uploadMedia(widget.file.path ?? "");
      },
    );
  }

  IconButton _doneIcon() {
    return _actionButton(
      key: const Key("done_icon"),
      iconData: Icons.done,
    );
  }

  IconButton _actionButton({
    Key? key,
    VoidCallback? onPressed,
    required IconData iconData,
  }) {
    return IconButton(
      key: key,
      onPressed: onPressed,
      icon: Icon(iconData),
      style: IconButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorPallet.lightBlue.withOpacity(0.5),
        disabledBackgroundColor: ColorPallet.lightBlue.withOpacity(0.5),
        disabledForegroundColor: Colors.white,
      ),
    );
  }

  IconButton _removeUploadItem() {
    return IconButton(
      key: const Key("remove_upload_item_button"),
      onPressed: () => widget.onRemove(widget.file),
      visualDensity: VisualDensity.compact,
      iconSize: 15,
      color: Colors.white,
      icon: const Icon(Icons.close),
    );
  }
}
