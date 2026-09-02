enum InvoiceStatus { awaiting, paid }

class InvoiceModel {
  final String id;
  final String title;
  final double amount;
  final String date;
  final InvoiceStatus status;
  final bool isSelected;

  const InvoiceModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
    this.isSelected = false,
  });

  InvoiceModel copyWith({bool? isSelected}) {
    return InvoiceModel(
      id: id,
      title: title,
      amount: amount,
      date: date,
      status: status,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
