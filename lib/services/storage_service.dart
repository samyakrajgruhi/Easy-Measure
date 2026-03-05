import 'package:easymeasure/models/customer.dart';
import 'package:easymeasure/models/measurement.dart';
import 'package:hive/hive.dart';

void saveCustomer(Customer customer) {
  final box = Hive.box<Customer>('customers');
  box.put(customer.id, customer);
}

List<Customer> getAllCustomers() {
  final box = Hive.box<Customer>('customers');
  return box.values.toList();
}

Customer? getCustomer(String id) {
  final box = Hive.box<Customer>('customers');
  return box.get(id);
}

void deleteCustomer(String id) {
  final customerBox = Hive.box<Customer>('customers');
  final measurementBox = Hive.box<Measurement>('measurements');
  final cmBox = Hive.box('customerMeasurements');

  final List<dynamic> measurementIds = cmBox.get(id) ?? [];

  for (String measurementId in measurementIds) {
    measurementBox.delete(measurementId);
  }

  cmBox.delete(id);
  customerBox.delete(id);
}

void saveMeasurement(String customerId, Measurement measurement) {
  final measurementBox = Hive.box<Measurement>('measurements');
  final cmBox = Hive.box('customerMeasurements');

  measurementBox.put(measurement.id, measurement);
  final List<dynamic> existingIds = cmBox.get(customerId) ?? [];
  existingIds.add(measurement.id);

  cmBox.put(customerId, existingIds);
}

List<Measurement> getMeasurementsForCustomer(String customerId) {
  final measurementBox = Hive.box<Measurement>('measurements');
  final cmBox = Hive.box('customerMeasurements');

  final List<dynamic> measurementIds = cmBox.get(customerId) ?? [];

  final List<Measurement> measurements = [];
  for (String id in measurementIds) {
    final m = measurementBox.get(id);
    if (m != null) measurements.add(m);
  }

  return measurements;
}

Measurement? getMeasurement(String measurementId) {
  final measurementBox = Hive.box<Measurement>('measurements');
  return measurementBox.get(measurementId);
}

void deleteMeasurement(String customerId, String measurementId) {
  final measurementBox = Hive.box<Measurement>('measurements');
  final cmBox = Hive.box('customerMeasurements');

  measurementBox.delete(measurementId);

  final List<dynamic> ids = cmBox.get(customerId) ?? [];
  ids.remove(measurementId);
  cmBox.put(customerId, ids);
}
