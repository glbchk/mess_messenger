import 'package:mess_messenger_app/features/settings/data/models/invoice_model.dart';

final sampleInvoices = [
  const InvoiceModel(
    id: '1',
    title: 'Basic Plan – Dec 2023',
    amount: 10.00,
    date: 'Dec 1, 2023',
    status: InvoiceStatus.awaiting,
  ),
  const InvoiceModel(
    id: '2',
    title: 'Basic Plan – Nov 2023',
    amount: 10.00,
    date: 'Nov 1, 2023',
    status: InvoiceStatus.paid,
  ),
  const InvoiceModel(
    id: '3',
    title: 'Basic Plan – Nov 2023',
    amount: 10.00,
    date: 'Nov 1, 2023',
    status: InvoiceStatus.paid,
  ),
  const InvoiceModel(
    id: '4',
    title: 'Basic Plan – Nov 2023',
    amount: 10.00,
    date: 'Nov 1, 2023',
    status: InvoiceStatus.paid,
  ),
  const InvoiceModel(
    id: '5',
    title: 'Basic Plan – Nov 2023',
    amount: 10.00,
    date: 'Nov 1, 2023',
    status: InvoiceStatus.paid,
  ),
];
