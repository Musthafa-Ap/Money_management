import 'package:flutter/material.dart';
import 'package:sample/database/catagory/catagory_db.dart';
import 'package:sample/database/transactions/transaction_db.dart';
import 'package:sample/models/catagory/catagory_model.dart';
import 'package:sample/models/transaction/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CatagoryType? _selectedCatagoryType;
  CatagoryModel? _selectedCatagoryModel;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  String? _catagoryID;
  @override
  void initState() {
    _selectedCatagoryType = CatagoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _purposeTextEditingController,
              decoration: const InputDecoration(hintText: 'Purpose'),
            ),
            TextFormField(
              controller: _amountTextEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now());
                if (_selectedDateTemp == null) {
                  return;
                } else {
                  print(_selectedDateTemp.toString());
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CatagoryType.income,
                        groupValue: _selectedCatagoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCatagoryType = CatagoryType.income;
                            _catagoryID = null;
                          });
                        }),
                    Text("Income")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CatagoryType.expense,
                        groupValue: _selectedCatagoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCatagoryType = CatagoryType.expense;
                            _catagoryID = null;
                          });
                        }),
                    Text("Expense")
                  ],
                ),
              ],
            ),
            DropdownButton(
              hint: const Text("Selected Catagory"),
              value: _catagoryID,
              items: (_selectedCatagoryType == CatagoryType.income
                      ? CatagoryDb().incomeCatagoryListListener
                      : CatagoryDb().expenseCatagoryListListener)
                  .value
                  .map((e) {
                return DropdownMenuItem(value: e.id, child: Text(e.name),
                onTap: () {
                _selectedCatagoryModel = e;
              },);
              }).toList(),
              onChanged: (selectedValue) {
                print(selectedValue);
                setState(() {
                  _catagoryID = selectedValue as String?;
                });
              },
              onTap: () {
                
              },
            ),
            ElevatedButton(
                onPressed: () {
                  addTransaction();
                },
                child: Text("Submit")),
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_catagoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if(_selectedCatagoryModel==null)
    {
  return;
    }
  final _parseAmount = double.tryParse(_amountText);
  if(_parseAmount == null){
    return;
  }



final _model = TransactionModel(purpose: _purposeText, amount: _parseAmount, date: _selectedDate!, type: _selectedCatagoryType!, catagory: _selectedCatagoryModel!);
TransactionDB.instance.addTransaction(_model);
Navigator.of(context).pop();
TransactionDB.instance.refresh();
  }
}
