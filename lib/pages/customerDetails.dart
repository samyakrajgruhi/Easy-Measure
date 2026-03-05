import 'package:easymeasure/components/dismissible_plate.dart';
import 'package:easymeasure/components/name_plate.dart';
import 'package:easymeasure/models/customer.dart';
import 'package:easymeasure/models/measurement.dart';
import 'package:easymeasure/pages/addMeasurementPage.dart';
import 'package:easymeasure/pages/measurementDetails.dart';
import 'package:easymeasure/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';

class CustomerDetails extends StatefulWidget {
  final Customer customer;
  const CustomerDetails({super.key, required this.customer});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late String _initialName;
  late String _initialPhone;

  bool _hasChanges = false;

  List<Measurement> measurements = [];

  @override
  void initState() {
    super.initState();
    _initialName = widget.customer.name;
    _initialPhone = widget.customer.phone;

    _nameController.text = _initialName;
    _phoneController.text = _initialPhone;

    _nameController.addListener(_checkForChanges);
    _phoneController.addListener(_checkForChanges);

    _loadMeasurements();
  }

  void _loadMeasurements() {
    setState(() {
      measurements = getMeasurementsForCustomer(widget.customer.id);
    });
  }

  void _deleteMeasurement(Measurement measurement) {
    deleteMeasurement(widget.customer.id, measurement.id);
    setState(() {
      measurements.remove(measurement);
    });
  }

  void _checkForChanges() {
    setState(() {
      _hasChanges =
          _nameController.text != _initialName ||
          _phoneController.text != _initialPhone;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          "Customer Details",
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
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
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

            if (_hasChanges) ...[
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print('Save customer changes');
                    setState(() {
                      _hasChanges = false;
                    });
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
            ],

            const SizedBox(height: 15),

            Divider(color: textSecondary.withOpacity(0.3), thickness: 1),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Measurements",
                  style: TextStyle(
                    fontSize: 22,
                    color: textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddMeasurementPage(customerId: widget.customer.id),
                      ),
                    ).then((_) => _loadMeasurements());
                  },
                  icon: Icon(Icons.add_circle, color: appBarColor, size: 32),
                ),
              ],
            ),

            if (measurements.isEmpty) ...[
              Center(
                child: Text(
                  "No Measurements Saved",
                  style: TextStyle(
                    fontSize: 18,
                    color: textSecondary.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ] else
              ...measurements
                  .map(
                    (measurement) => DismissiblePlate(
                      id: measurement.id,
                      childWidget: NamePlate(
                        name: measurement.title,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MeasurementDetails(measurement: measurement),
                            ),
                          );
                        },
                      ),
                      onDismissed: () => _deleteMeasurement(measurement),
                      confirmTitle: "Delete Measurement",
                      confirmMessage:
                          "Are you sure you want to delete this measurement?",
                      dismissSnackBarMessage: "${measurement.title} deleted",
                    ),
                  )
                  .toList(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
