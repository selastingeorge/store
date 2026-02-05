class StringUtils {
  static String toCamelCase(String text) {
    return text.replaceAll(RegExp(r'[_\-]'), ' ').splitMapJoin(
      RegExp(r'[^ ]+'), // match words
      onMatch: (m) {
        final word = m.group(0)!;
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      },
      onNonMatch: (nm) => nm, // preserve spaces as-is
    ).replaceFirstMapped(RegExp(r'^[A-Z]'), (m) => m[0]!.toLowerCase());
  }

  static String toPascalCase(String text) {
    return text.replaceAll(RegExp(r'[_\-]'), ' ').splitMapJoin(
      RegExp(r'[^ ]+'), // match words
      onMatch: (m) {
        final word = m.group(0)!;
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      },
      onNonMatch: (nm) => nm, // preserve spaces as-is
    );
  }
}
