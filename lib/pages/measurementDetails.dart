import 'package:easymeasure/components/input_field.dart';
import 'package:easymeasure/components/name_plate.dart';
import 'package:easymeasure/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';

class MeasurementDetails extends StatefulWidget {
  final Measurement measurement;
  const MeasurementDetails({super.key, required this.measurement});

  @override
  State<MeasurementDetails> createState() => _MeasurementDetailsState();
}

class _MeasurementDetailsState extends State<MeasurementDetails> {
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

  late final TextEditingController _titleController;
  late final Map<String, TextEditingController> _controllers;
  late final Map<String, String> _initialValues;

  final List<String> _customFieldNames = [];
  final Map<String, TextEditingController> _customControllers = {};
  late Map<String, String> _initialCustomValues;

  bool _isEditing = false;

  String _fieldToInitialValue(String field) {
    final m = widget.measurement;
    final val = switch (field) {
      "Full length FL" => m.fullLength,
      "Blouse length" => m.blouseLength,
      "Kurti length" => m.kurtiLength,
      "Should Sh" => m.shoulder,
      "Uppar bust" => m.upperBust,
      "Bust round B" => m.bustRound,
      "Under bust" => m.underBust,
      "Bust to Apex BL" => m.bustToApex,
      "Apex A" => m.apex,
      "Waist round W" => m.waistRound,
      "Hip round H" => m.hipRound,
      "Neck to waist N to W" => m.neckToWaist,
      "Neck to hip N to H" => m.neckToHip,
      "Sleeve length" => m.sleeveLength,
      "Sleeve hole" => m.sleeveHole,
      "Biceps" => m.biceps,
      "Arm hole" => m.armHole,
      "Pant length" => m.pantLength,
      "Waist to knee" => m.waistToKnee,
      "Thai round" => m.thighRound,
      "Knee round" => m.kneeRound,
      "Ankal round" => m.ankleRound,
      "Crotch" => m.crotch,
      "Skirt length" => m.skirtLength,
      "Low waist" => m.lowWaist,
      _ => null,
    };
    return val?.toString() ?? '';
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.measurement.title);
    _controllers = {};
    _initialValues = {'__title__': widget.measurement.title};

    for (final field in [...upperBodyFields, ...lowerBodyFields]) {
      final value = _fieldToInitialValue(field);
      _controllers[field] = TextEditingController(text: value);
      _initialValues[field] = value;
    }

    // Load custom fields
    final saved = widget.measurement.customFields ?? {};
    _initialCustomValues = {};
    for (final entry in saved.entries) {
      _customFieldNames.add(entry.key);
      _customControllers[entry.key] = TextEditingController(text: entry.value);
      _initialCustomValues[entry.key] = entry.value;
    }
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
      _initialCustomValues.remove(name);
    });
  }

  double? _getValue(String field) {
    final text = _controllers[field]!.text;
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }

  void _save() {
    final m = widget.measurement;
    m.title = _titleController.text;
    m.fullLength = _getValue("Full length FL");
    m.blouseLength = _getValue("Blouse length");
    m.kurtiLength = _getValue("Kurti length");
    m.shoulder = _getValue("Should Sh");
    m.upperBust = _getValue("Uppar bust");
    m.bustRound = _getValue("Bust round B");
    m.underBust = _getValue("Under bust");
    m.bustToApex = _getValue("Bust to Apex BL");
    m.apex = _getValue("Apex A");
    m.waistRound = _getValue("Waist round W");
    m.hipRound = _getValue("Hip round H");
    m.neckToWaist = _getValue("Neck to waist N to W");
    m.neckToHip = _getValue("Neck to hip N to H");
    m.sleeveLength = _getValue("Sleeve length");
    m.sleeveHole = _getValue("Sleeve hole");
    m.biceps = _getValue("Biceps");
    m.armHole = _getValue("Arm hole");
    m.pantLength = _getValue("Pant length");
    m.waistToKnee = _getValue("Waist to knee");
    m.thighRound = _getValue("Thai round");
    m.kneeRound = _getValue("Knee round");
    m.ankleRound = _getValue("Ankal round");
    m.crotch = _getValue("Crotch");
    m.skirtLength = _getValue("Skirt length");
    m.lowWaist = _getValue("Low waist");

    // Save custom fields
    final customFields = <String, String>{};
    for (final name in _customFieldNames) {
      customFields[name] = _customControllers[name]!.text.trim();
    }
    m.customFields = customFields.isNotEmpty ? customFields : null;

    m.save();

    // Update initial values so the save button hides after saving
    _initialValues['__title__'] = m.title;
    for (final field in [...upperBodyFields, ...lowerBodyFields]) {
      _initialValues[field] = _controllers[field]!.text;
    }
    _initialCustomValues = {
      for (final n in _customFieldNames) n: _customControllers[n]!.text,
    };
    setState(() => _isEditing = false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (final c in _controllers.values) {
      c.dispose();
    }
    for (final c in _customControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          "Measurement Details",
          style: TextStyle(
            color: textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            IgnorePointer(
              ignoring: !_isEditing,
              child: InputField(
                label: "Title",
                hintText: "Enter measurement title",
                keyboardType: TextInputType.text,
                controller: _titleController,
              ),
            ),

            if (!_isEditing)
              NamePlate(
                name: "Edit",
                icon: Icons.edit,
                onTap: () => setState(() => _isEditing = true),
              ),

            const SizedBox(height: 10),

            IgnorePointer(
              ignoring: !_isEditing,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "UPPER BODY",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ...upperBodyFields.map(
                    (field) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InputField(
                        label: field,
                        keyboardType: TextInputType.number,
                        controller: _controllers[field]!,
                      ),
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
                  const SizedBox(height: 15),
                  ...lowerBodyFields.map(
                    (field) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InputField(
                        label: field,
                        keyboardType: TextInputType.number,
                        controller: _controllers[field]!,
                      ),
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
                            if (_isEditing)
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
                ],
              ),
            ),

            if (_isEditing) ...[
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
            ],

            if (_isEditing) ...[
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _save,
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
