String formatUsd(double value) {
  return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
}
