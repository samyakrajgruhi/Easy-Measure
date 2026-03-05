import 'package:easymeasure/components/name_plate.dart';
import 'package:easymeasure/models/customer.dart';
import 'package:easymeasure/models/measurement.dart';
import 'package:easymeasure/pages/addMeasurementPage.dart';
import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';
import 'package:uuid/uuid.dart';
import 'package:easymeasure/services/storage_service.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  List<Measurement> _measurements = [];

  late String _customerId;
  bool _customerSaved = false;

  @override
  void initState() {
    super.initState();
    _customerId = const Uuid().v4();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneContoller = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneContoller.dispose();
    super.dispose();
  }

  void onSubmit() {
    bool saved = _saveCustomerIfNeeded();
    if (!saved) return;
    Navigator.pop(context);
  }

  bool _saveCustomerIfNeeded() {
    String customerName = _nameController.text;
    String phoneNumber = _phoneContoller.text;

    if (customerName.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    saveCustomer(
      Customer(id: _customerId, name: customerName, phone: phoneNumber),
    );

    _customerSaved = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          "Add Customer",
          style: TextStyle(
            color: textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 15,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(color: textSecondary.withOpacity(0.6)),
                    filled: true,
                    fillColor: inputField,
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
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                TextField(
                  controller: _phoneContoller,
                  decoration: InputDecoration(
                    hintText: 'Enter Phone Number',
                    hintStyle: TextStyle(color: textSecondary.withOpacity(0.6)),
                    filled: true,
                    fillColor: inputField,
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
              ],
            ),

            Divider(color: textSecondary.withOpacity(0.3), thickness: 1),

            _measurements.isEmpty
                ? Text(
                    "No measurements Saved",
                    style: TextStyle(
                      fontSize: 18,
                      color: textSecondary.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _measurements.length,
                    itemBuilder: (context, index) {
                      return NamePlate(
                        name: _measurements[index].title,
                        onTap: () {},
                      );
                    },
                  ),

            SizedBox(
              width: 56,
              height: 56,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddMeasurementPage(customerId: _customerId),
                    ),
                  ).then((_) {
                    setState(() {
                      _measurements = getMeasurementsForCustomer(_customerId);
                    });
                  });
                },
                backgroundColor: appBarColor,
                child: const Icon(Icons.add, color: textPrimary, size: 32),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  onSubmit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appBarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
