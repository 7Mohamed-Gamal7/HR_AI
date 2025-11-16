import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hr_ai/core/providers/app_provider.dart';
import 'package:hr_ai/core/models/attendance_model.dart';
import 'package:hr_ai/core/models/employee_model.dart';
import 'package:hr_ai/core/widgets/custom_card.dart';
import 'package:hr_ai/core/widgets/custom_text_field.dart';
import 'package:hr_ai/core/widgets/primary_button.dart';
import 'package:hr_ai/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    super.initState();
    // You might want to fetch initial data here if it's not already loaded
    // Provider.of<AppProvider>(context, listen: false).loadAttendanceRecords();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final filteredRecords = _getFilteredRecords(appProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, appProvider),
            const SizedBox(height: 16),
            _buildFilterBar(context, appProvider),
            const SizedBox(height: 16),
            _buildStats(context, filteredRecords),
            const SizedBox(height: 16),
            Expanded(
              child: _buildAttendanceList(context, filteredRecords),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRecordDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppProvider appProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'attendance.title'.tr(),
          style: AppTheme.of(context).typography.headlineMedium,
        ),
        PrimaryButton(
          text: 'attendance.manage_rules'.tr(),
          onPressed: () {
            // TODO: Navigate to attendance rules screen
          },
        ),
      ],
    );
  }

  Widget _buildFilterBar(BuildContext context, AppProvider appProvider) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Date Picker
        SizedBox(
          width: 200,
          child: InkWell(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: appProvider.selectedAttendanceDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                appProvider.updateAttendanceDate(pickedDate);
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'attendance.date'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                DateFormat.yMd().format(appProvider.selectedAttendanceDate),
              ),
            ),
          ),
        ),
        // Status Filter
        SizedBox(
          width: 200,
          child: DropdownButtonFormField<String>(
            initialValue: appProvider.attendanceStatusFilter,
            decoration: InputDecoration(
              labelText: 'attendance.status.title'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            items:
                ['all', 'present', 'absent', 'late', 'on_leave'].map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text('attendance.status.$status'.tr()),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                appProvider.updateAttendanceStatusFilter(value);
              }
            },
          ),
        ),
        // Search Field
        SizedBox(
          width: 300,
          child: CustomTextField(
            controller: TextEditingController(text: appProvider.searchQuery),
            hintText: 'search.placeholder'.tr(),
            onChanged: (value) {
              appProvider.updateSearchQuery(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context, List<AttendanceRecord> records) {
    final present =
        records.where((r) => r.status == AttendanceStatus.present).length;
    final absent =
        records.where((r) => r.status == AttendanceStatus.absent).length;
    final late = records.where((r) => r.isLate).length;
    final onLeave =
        records.where((r) => r.status == AttendanceStatus.onLeave).length;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildStatCard(context, 'attendance.status.present'.tr(),
            present.toString(), Colors.green),
        _buildStatCard(context, 'attendance.status.absent'.tr(),
            absent.toString(), Colors.red),
        _buildStatCard(context, 'attendance.status.late'.tr(), late.toString(),
            Colors.orange),
        _buildStatCard(context, 'attendance.status.on_leave'.tr(),
            onLeave.toString(), Colors.blue),
      ],
    );
  }

  Widget _buildStatCard(
      BuildContext context, String title, String value, Color color) {
    return CustomCard(
      width: 150,
      child: Column(
        children: [
          Text(
            value,
            style: AppTheme.of(context)
                .typography
                .headlineMedium
                .copyWith(color: color),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTheme.of(context).typography.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceList(
      BuildContext context, List<AttendanceRecord> records) {
    if (records.isEmpty) {
      return Center(child: Text('attendance.no_records'.tr()));
    }

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        final employee = Provider.of<AppProvider>(context, listen: false)
            .employees
            .firstWhere((e) => e.id == record.employeeId,
                orElse: () => Employee.empty());

        return _buildAttendanceCard(context, record, employee);
      },
    );
  }

  Widget _buildAttendanceCard(
      BuildContext context, AttendanceRecord record, Employee employee) {
    return CustomCard(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          // backgroundImage: NetworkImage(employee.profileImageUrl), // If you have profile images
          child:
              Text(employee.fullName.isNotEmpty ? employee.fullName[0] : '?'),
        ),
        title: Text(employee.fullName),
        subtitle: Text(
          '${'check_in'.tr()}: ${record.formattedCheckInTime} | ${'check_out'.tr()}: ${record.formattedCheckOutTime}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: Text(record.status.name.tr()),
              backgroundColor: record.statusColor,
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showAddRecordDialog(context, record: record),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDeleteRecord(context, record.id!),
            ),
          ],
        ),
      ),
    );
  }

  List<AttendanceRecord> _getFilteredRecords(AppProvider appProvider) {
    return appProvider.attendanceRecords.where((record) {
      final recordDate = DateTime.parse(record.date);
      final selectedDate = appProvider.selectedAttendanceDate;
      final isSameDay = recordDate.year == selectedDate.year &&
          recordDate.month == selectedDate.month &&
          recordDate.day == selectedDate.day;

      if (!isSameDay) return false;

      final statusMatch = appProvider.attendanceStatusFilter == 'all' ||
          record.status.name == appProvider.attendanceStatusFilter;

      final employee = appProvider.employees.firstWhere(
          (e) => e.id == record.employeeId,
          orElse: () => Employee.empty());
      final searchMatch = appProvider.searchQuery.isEmpty ||
          employee.fullName
              .toLowerCase()
              .contains(appProvider.searchQuery.toLowerCase()) ||
          employee.employeeNumber
              .toLowerCase()
              .contains(appProvider.searchQuery.toLowerCase());

      return statusMatch && searchMatch;
    }).toList();
  }

  void _showAddRecordDialog(BuildContext context, {AttendanceRecord? record}) {
    // This would typically be a more complex form in a real app
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // A simplified form for adding/editing a record
        return AlertDialog(
          title: Text(record == null
              ? 'attendance.add_record'.tr()
              : 'attendance.edit_record'.tr()),
          content: Text('form.not_implemented'.tr()), // Placeholder
          actions: [
            TextButton(
              child: Text('cancel'.tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('save'.tr()),
              onPressed: () {
                // TODO: Implement save logic
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteRecord(BuildContext context, int recordId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete.confirm_title'.tr()),
          content: Text(
              'delete.confirm_message'.tr(args: ['attendance.record'.tr()])),
          actions: [
            TextButton(
              child: Text('cancel'.tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('delete.title'.tr()),
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false)
                    .deleteAttendanceRecord(recordId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
