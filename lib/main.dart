import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const WeSplitApp());
}

class WeSplitApp extends StatelessWidget {
  const WeSplitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeSplit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ContentView(),
    );
  }
}

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  // MARK: - Properties
  final List<int> tipPercentages = [10, 15, 20, 25, 0];
  double checkAmount = 0.0;
  int numberOfPeople = 2;
  int tipPercentage = 20;

  final FocusNode _amountFocusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _amountController.dispose();
    super.dispose();
  }

  double get totalPerPerson {
    final peopleCount = numberOfPeople + 2;
    final tipSelection = tipPercentage.toDouble();

    final tipValue = checkAmount / 100 * tipSelection;
    final grandTotal = checkAmount + tipValue;
    final amountPerPerson = grandTotal / peopleCount;

    return amountPerPerson;
  }

  String _formatCurrency(double amount) {
    final format = NumberFormat.currency(
      symbol: NumberFormat.simpleCurrency().currencySymbol,
      decimalDigits: 2,
    );
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeSplit'),
        centerTitle: true,
        actions: [
          if (_amountFocusNode.hasFocus)
            TextButton(
              onPressed: () {
                _amountFocusNode.unfocus();
              },
              child: const Text('Done'),
            ),
        ],
      ),
      body: ListView(
        children: [
          // Section 1: Amount and Number of People
          Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _amountController,
                    focusNode: _amountFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        checkAmount = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Number of people'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${numberOfPeople + 2} people',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () async {
                      final result = await Navigator.push<int>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NumberOfPeoplePicker(
                            initialValue: numberOfPeople,
                          ),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          numberOfPeople = result;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // Section 2: Tip Percentage
          Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How much tip do you want to leave?',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  SegmentedButton<int>(
                    segments: tipPercentages.map((percentage) {
                      return ButtonSegment<int>(
                        value: percentage,
                        label: Text('$percentage%'),
                      );
                    }).toList(),
                    selected: {tipPercentage},
                    onSelectionChanged: (Set<int> newSelection) {
                      setState(() {
                        tipPercentage = newSelection.first;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Section 3: Total Per Person
          Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  _formatCurrency(totalPerPerson),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberOfPeoplePicker extends StatelessWidget {
  final int initialValue;

  const NumberOfPeoplePicker({
    super.key,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number of people'),
      ),
      body: ListView.builder(
        itemCount: 98,
        itemBuilder: (context, index) {
          final peopleCount = index + 2;
          final isSelected = index == initialValue;
          return ListTile(
            title: Text('$peopleCount people'),
            trailing: isSelected
                ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                : null,
            selected: isSelected,
            onTap: () {
              Navigator.pop(context, index);
            },
          );
        },
      ),
    );
  }
}
