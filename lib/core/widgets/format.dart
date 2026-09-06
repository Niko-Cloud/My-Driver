/// Formats a whole-number rupiah amount as "Rp 18.000".
String formatRupiah(int amount) {
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    final posFromEnd = digits.length - i;
    buffer.write(digits[i]);
    if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write('.');
  }
  return '${amount < 0 ? '-' : ''}Rp $buffer';
}
