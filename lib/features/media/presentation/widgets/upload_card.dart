import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/utils/string_formatter.dart';
import 'package:wordpress_companion/features/media/presentation/logic_holders/cubits/upload_media_cubit/upload_media_cubit.dart';

class UploadCard extends StatefulWidget {
  final PlatformFile file;
  const UploadCard({super.key, required this.file});

  @override
  State<UploadCard> createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  late ValueNotifier<double> valueNotifier;
  CancelToken? _cancelToken;

  @override
  void initState() {
    valueNotifier = ValueNotifier<double>(0);
    super.initState();
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
    return BlocBuilder<UploadMediaCubit, UploadMediaState>(
      builder: (context, state) {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fileDetails(state),
              _progress(state),
              _cancelButton(),
            ],
          ),
        );
      },
    );
  }

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
      initial: () => Text(
        "آپلود فایل",
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white),
      ),
      startingUpload: (cancelToken) {
        _cancelToken = cancelToken;
        return Container();
      },
      uploading: (_) => Text(
        "در حال آپلود...",
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white),
      ),
      uploaded: () => Text(
        "آپلود انجام شد.",
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white),
      ),
      error: (failure) => Flexible(
        child: Text(
          "خطا: ${failure.message}",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
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
      backStrokeWidth: 15,
      progressStrokeWidth: 15,
      onGetText: state.whenOrNull(uploading: (progress) {
                valueNotifier.value = progress * 100;
                return true;
              }) ==
              true
          ? (value) => Text(
                "${value.toInt()}%",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              )
          : null,
      fullProgressColor: Colors.white,
      valueNotifier: valueNotifier,
    );
  }

  IconButton _uploadButton() {
    return _actionButton(
      onPressed: () {
        context.read<UploadMediaCubit>().uploadMedia(widget.file.path ?? "");
      },
      iconData: Icons.file_upload_outlined,
    );
  }

  IconButton _refreshButton() {
    return _actionButton(
      iconData: Icons.refresh,
      onPressed: () {},
    );
  }

  IconButton _doneIcon() => _actionButton(iconData: Icons.done);

  IconButton _actionButton({
    VoidCallback? onPressed,
    required IconData iconData,
  }) {
    return IconButton(
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

  IconButton _cancelButton() {
    return IconButton(
      onPressed: () {
        if (_cancelToken != null) {
          context.read<UploadMediaCubit>().cancelMediaUpload(_cancelToken!);
        }
      },
      visualDensity: VisualDensity.compact,
      iconSize: 15,
      color: Colors.white,
      icon: const Icon(Icons.close),
    );
  }
}
