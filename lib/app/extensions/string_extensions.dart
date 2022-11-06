extension StringExtensions on String {
  String get withFirstLetterCapitalized =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
}
