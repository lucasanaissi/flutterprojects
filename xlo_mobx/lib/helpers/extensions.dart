import 'package:intl/intl.dart';

extension StringExtension on String {

  bool isEmailValid() {
    final RegExp regex = RegExp(
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
    return regex.hasMatch(this);
  }

  bool isPassValid() {
    final RegExp regex = RegExp(
        r"^(?=[^A-Z\n]*[A-Z])(?=[^a-z\n]*[a-z])(?=[^0-9\n]*[0-9])(?=[^#?!@$%^&*\n-]*[#?!@$%^&*-]).{8,}$");
    return regex.hasMatch(this);
  }
}

extension NumberExtension on num {
  String formattedMoney() {
    return NumberFormat('R\$###,##0.00', 'pt-BR').format(this);
  }
}

extension DateTimeExtension on DateTime {
  String formattedDate() {
    return DateFormat('dd MMM HH:mm', 'pt-BR').format(this);
  }

  String formattedDate2() {
    return DateFormat('MMMM yyyy', 'pt-BR').format(this);
  }

}