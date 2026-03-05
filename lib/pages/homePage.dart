import 'package:easymeasure/components/dismissible_plate.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:easymeasure/models/customer.dart';
import 'package:easymeasure/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';
import 'package:easymeasure/components/name_plate.dart';
import 'package:easymeasure/pages/addCustomerPage.dart';
import 'package:easymeasure/pages/customerDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  List<Customer> _customers = [];

  void _loadCustomers() {
    setState(() {
      _customers = getAllCustomers();
      _customers.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  List<Customer> _getFilteredCustomers() {
    if (_searchQuery.isEmpty) return _customers;

    final fuse = Fuzzy<Customer>(
      _customers,
      options: FuzzyOptions(
        keys: [WeightedKey(name: 'name', getter: (c) => c.name, weight: 1)],
        threshold: 0.4,
      ),
    );

    return fuse.search(_searchQuery).map((r) => r.item).toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayedCustomers = _getFilteredCustomers();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Center(
          child: Text(
            "Easy Measure",
            style: TextStyle(
              color: textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by Name',
                hintStyle: TextStyle(color: textSecondary.withOpacity(0.6)),
                filled: true,
                fillColor: inputField,
                suffixIcon: Icon(
                  Icons.search,
                  color: textSecondary.withOpacity(0.6),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) => setState(() {
                _searchQuery = value;
              }),
            ),
            const SizedBox(height: 16),
            if (_customers.isEmpty)
              Center(
                child: Text(
                  'No customers yet',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else if (displayedCustomers.isEmpty)
              Center(
                child: Text(
                  'No results found',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: displayedCustomers.length,
                  itemBuilder: (context, index) {
                    final customer = displayedCustomers[index];
                    return DismissiblePlate(
                      childWidget: NamePlate(
                        name: customer.name,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CustomerDetails(customer: customer),
                            ),
                          ).then((_) => _loadCustomers());
                        },
                      ),
                      onDismissed: () => deleteCustomer(customer.id),
                      confirmTitle: "Delete ${customer.name}",
                      confirmMessage:
                          "All Saved Measurements for ${customer.name} will be lost. Confirm ?",
                      dismissSnackBarMessage: "${customer.name} Deleted.",
                      id: customer.id,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCustomerPage()),
          ).then((_) => _loadCustomers());
        },
        backgroundColor: inputField,
        child: const Icon(Icons.add, color: textSecondary, size: 32),
      ),
    );
  }
}
