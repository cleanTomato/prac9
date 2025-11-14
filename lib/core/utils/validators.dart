bool isValidVolume(String value) {
  final volume = int.tryParse(value);
  return volume != null && volume > 0;
}