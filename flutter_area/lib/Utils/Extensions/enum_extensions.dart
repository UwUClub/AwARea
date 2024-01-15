extension EnumExtension on Enum {
  String get name => toString().split('.').last;
}
