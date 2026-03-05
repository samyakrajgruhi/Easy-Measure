import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';
import 'package:easymeasure/components/input_field.dart';
import 'package:easymeasure/models/measurement.dart';
import 'package:easymeasure/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class AddMeasurementPage extends StatefulWidget {
  final String customerId;
  const AddMeasurementPage({super.key, required this.customerId});

  @override
  State<AddMeasurementPage> createState() => _AddMeasurementPageState();
}

class _AddMeasurementPageState extends State<AddMeasurementPage> {
  final TextEditingController _titleController = TextEditingController();

  final List<String> upperBodyFields = [
    "Full length FL",
    "Blouse length",
    "Kurti length",
    "Should Sh",
    "Uppar bust",
    "Bust round B",
    "Under bust",
    "Bust to Apex BL",
    "Apex A",
    "Waist round W",
    "Hip round H",
    "Neck to waist N to W",
    "Neck to hip N to H",
    "Sleeve length",
    "Sleeve hole",
    "Biceps",
    "Arm hole",
  ];

  final List<String> lowerBodyFields = [
    "Pant length",
    "Waist to knee",
    "Thai round",
    "Knee round",
    "Ankal round",
    "Crotch",
    "Skirt length",
    "Low waist",
  ];

  late Map<String, TextEditingController> _controllers;
  final List<String> _customFieldNames = [];
  final Map<String, TextEditingController> _customControllers = {};

  @override
  void initState() {
    super.initState();
    _controllers = {};
    for (final field in [...upperBodyFields, ...lowerBodyFields]) {
      _controllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    for (final controller in _customControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showAddCustomFieldDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Field'),
        content: TextField(
          controller: nameController,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Field name',
            hintText: 'e.g. Chest round',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isNotEmpty &&
                  !_customFieldNames.contains(name) &&
                  !upperBodyFields.contains(name) &&
                  !lowerBodyFields.contains(name)) {
                setState(() {
                  _customFieldNames.add(name);
                  _customControllers[name] = TextEditingController();
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    ).then((_) => nameController.dispose());
  }

  void _removeCustomField(String name) {
    setState(() {
      _customFieldNames.remove(name);
      _customControllers[name]?.dispose();
      _customControllers.remove(name);
    });
  }

  double? _getValue(String field) {
    final text = _controllers[field]!.text;
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }

  void onSubmit() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a title'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final customFields = <String, String>{};
    for (final name in _customFieldNames) {
      final val = _customControllers[name]!.text.trim();
      customFields[name] = val;
    }

    final measurement = Measurement(
      id: const Uuid().v4(),
      customerId: widget.customerId,
      title: _titleController.text,
      createdAt: DateTime.now(),
      fullLength: _getValue("Full length FL"),
      blouseLength: _getValue("Blouse length"),
      kurtiLength: _getValue("Kurti length"),
      shoulder: _getValue("Should Sh"),
      upperBust: _getValue("Uppar bust"),
      bustRound: _getValue("Bust round B"),
      underBust: _getValue("Under bust"),
      bustToApex: _getValue("Bust to Apex BL"),
      apex: _getValue("Apex A"),
      waistRound: _getValue("Waist round W"),
      hipRound: _getValue("Hip round H"),
      neckToWaist: _getValue("Neck to waist N to W"),
      neckToHip: _getValue("Neck to hip N to H"),
      sleeveLength: _getValue("Sleeve length"),
      sleeveHole: _getValue("Sleeve hole"),
      biceps: _getValue("Biceps"),
      armHole: _getValue("Arm hole"),
      pantLength: _getValue("Pant length"),
      waistToKnee: _getValue("Waist to knee"),
      thighRound: _getValue("Thai round"),
      kneeRound: _getValue("Knee round"),
      ankleRound: _getValue("Ankal round"),
      crotch: _getValue("Crotch"),
      skirtLength: _getValue("Skirt length"),
      lowWaist: _getValue("Low waist"),
      customFields: customFields.isNotEmpty ? customFields : null,
    );

    saveMeasurement(widget.customerId, measurement);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          "Add Measurement",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            InputField(
              label: "Title",
              hintText: "Enter measurement title",
              keyboardType: TextInputType.text,
              controller: _titleController,
            ),

            const SizedBox(height: 10),

            Text(
              "UPPER BODY",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textSecondary,
              ),
            ),
            ...upperBodyFields.map(
              (field) => InputField(
                label: field,
                keyboardType: TextInputType.number,
                controller: _controllers[field]!,
              ),
            ),

            Divider(
              color: textSecondary.withOpacity(0.3),
              thickness: 1,
              height: 30,
            ),

            Text(
              "LOWER BODY",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textSecondary,
              ),
            ),
            ...lowerBodyFields.map(
              (field) => InputField(
                label: field,
                keyboardType: TextInputType.number,
                controller: _controllers[field]!,
              ),
            ),

            if (_customFieldNames.isNotEmpty) ...[
              Divider(
                color: textSecondary.withOpacity(0.3),
                thickness: 1,
                height: 30,
              ),
              Text(
                "CUSTOM",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 15),
              ...(_customFieldNames.map(
                (name) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: InputField(
                          label: name,
                          keyboardType: TextInputType.number,
                          controller: _customControllers[name]!,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeCustomField(name),
                        icon: const Icon(Icons.close),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              )),
            ],

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _showAddCustomFieldDialog,
                icon: const Icon(Icons.add),
                label: const Text(
                  "Add Custom Field",
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onSubmit,
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
