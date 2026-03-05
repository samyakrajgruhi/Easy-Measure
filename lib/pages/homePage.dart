import 'package:easymeasure/components/dismissible_plate.dart';
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

  @override
  Widget build(BuildContext context) {
    List<String> names = [
      'Nirmala Rajgruhi',
      'Kalpana Kumari',
      'Kavita Kumari',
      'Shakshi Patel',
      'Guljari Prasad',
      'Harshita Ben',
      'Anjali Sharma',
      'Priya Singh',
      'Meera Reddy',
      'Sunita Gupta',
      'Rekha Joshi',
      'Pooja Verma',
      'Divya Nair',
      'Lakshmi Iyer',
      'Radha Pillai',
      'Geeta Devi',
      'Shalini Rao',
      'Usha Menon',
      'Vidya Kulkarni',
      'Deepa Mishra',
    ];

    names.sort((a, b) => a.compareTo(b));
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
            ),
            const SizedBox(height: 16),
            _customers.isEmpty
                ? Center(
                    child: Text(
                      'No customers yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _customers.length,
                      itemBuilder: (context, index) {
                        return DismissiblePlate(
                          childWidget: NamePlate(
                            name: _customers[index].name,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerDetails(
                                    customer: _customers[index],
                                  ),
                                ),
                              ).then((_) => _loadCustomers());
                            },
                          ),
                          onDismissed: () =>
                              deleteCustomer(_customers[index].id),
                          confirmTitle: "Delete ${_customers[index].name}",
                          confirmMessage:
                              "All Saved Measurements for ${_customers[index].name} will be lost. Confirm ?",
                          dismissSnackBarMessage:
                              "${_customers[index].name} Deleted.",
                          id: _customers[index].id,
                        );
                        // return NamePlate(
                        //   name: _customers[index].name,
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => CustomerDetails(
                        //           customer: _customers[index],
                        //         ),
                        //       ),
                        //     ).then((_) => _loadCustomers());
                        //   },
                        // );
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
