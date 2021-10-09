import 'transactions.dart';
class User{
  final String name;
  final String number;
  List<Transaction> history;
  double balance;

  User(this.name, this.number);
}