import 'package:equatable/equatable.dart';

class ProfileAvatar extends Equatable {
  final String size24px;
  final String size48px;
  final String size96px;
  const ProfileAvatar({
    required this.size24px,
    required this.size48px,
    required this.size96px,
  });
  @override
  List<Object?> get props => [size24px, size48px, size96px];
}
