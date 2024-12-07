part of 'localization_cubit.dart';

//Có thể triển khai thêm isLeft, isRight cho cho vài ngôn ngữ viết từ bên phải qua
class LocalizationState extends Equatable {
  final Locale locale;
  const LocalizationState({required this.locale});

  LocalizationState copyWith({Locale? locale}) => LocalizationState(
        locale: locale ?? this.locale,
      );

  @override
  List<Object?> get props => [
        locale,
      ];
}
