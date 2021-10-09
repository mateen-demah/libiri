class Transaction{
  final String type;
  final double amount;
  final DateTime time = DateTime.now();
  final String recipient;
  final String reference;
  final String item;
  final String agentNumber;

  Transaction.send({this.amount, this.recipient, this.reference, this.item = null, this.agentNumber = null, this.type = "send"});
  Transaction.pay({this.amount, this.recipient, this.reference, this.item, this.agentNumber = null, this.type = "pay"});
  Transaction.withdraw({this.amount, this.recipient=null, this.reference=null, this.item = null, this.agentNumber=null, this.type = "withdraw"});
}
