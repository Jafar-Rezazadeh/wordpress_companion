import 'package:equatable/equatable.dart';

class MediaDetailsEntity extends Equatable {
  final int fileSize;
  final int? height;
  final int? width;

  const MediaDetailsEntity({
    required this.fileSize,
    this.height,
    this.width,
  });
  @override
  List<Object?> get props => [fileSize];
}
