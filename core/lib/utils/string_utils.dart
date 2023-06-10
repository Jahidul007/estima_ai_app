String defaultIfNull(String? s) {
  if (s == "null") {
    return '';
  }
  return s ?? '';
}
