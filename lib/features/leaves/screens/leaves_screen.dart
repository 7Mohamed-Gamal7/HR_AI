import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hr_management/core/providers/app_provider.dart';
import 'package:hr_management/features/leaves/models/leave_model.dart';
import 'package:hr_management/core/widgets/custom_app_bar.dart';
import 'package:hr_management/core/widgets/custom_drawer.dart';
import 'package:hr_management/core/widgets/responsive.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({Key? key}) : super(key: key);

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'إدارة الإجازات',
        isDesktop: isDesktop,
      ),
      drawer: isDesktop ? null : const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterBar(appProvider),
            const SizedBox(height: 16),
            _buildStats(appProvider),
            const SizedBox(height: 16),
            Expanded(child: _buildLeavesList(appProvider)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add leave request dialog
        },
        child: const Icon(Icons.add),
        tooltip: 'إضافة طلب إجازة',
      ),
    );
  }

  Widget _buildFilterBar(AppProvider appProvider) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Filter by leave type
        DropdownButton<String>(
          value: appProvider.leaveTypeFilter,
          hint: const Text('نوع الإجازة'),
          onChanged: (value) {
            if (value != null) {
              appProvider.updateLeaveTypeFilter(value);
            }
          },
          items: [
            const DropdownMenuItem(value: 'all', child: Text('الكل')),
            ...appProvider.leaveTypes.map((type) {
              return DropdownMenuItem(
                value: type.id.toString(),
                child: Text(type.name),
              );
            }),
          ],
        ),
        // Filter by status
        DropdownButton<String>(
          value: appProvider.leaveStatusFilter,
          hint: const Text('الحالة'),
          onChanged: (value) {
            if (value != null) {
              appProvider.updateLeaveStatusFilter(value);
            }
          },
          items: [
            const DropdownMenuItem(value: 'all', child: Text('الكل')),
            ...LeaveRequestStatus.values.map((status) {
              return DropdownMenuItem(
                value: status.name,
                child: Text(status.name), // TODO: Add translation
              );
            }),
          ],
        ),
        // Search field
        SizedBox(
          width: 200,
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'بحث...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              // TODO: Implement search logic
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStats(AppProvider appProvider) {
    // TODO: Implement stats calculation
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Card(child: Padding(padding: EdgeInsets.all(16.0), child: Text('إجمالي الطلبات: 0'))),
        Card(child: Padding(padding: EdgeInsets.all(16.0), child: Text('مقبولة: 0'))),
        Card(child: Padding(padding: EdgeInsets.all(16.0), child: Text('مرفوضة: 0'))),
        Card(child: Padding(padding: EdgeInsets.all(16.0), child: Text('قيد الانتظار: 0'))),
      ],
    );
  }

  Widget _buildLeavesList(AppProvider appProvider) {
    final filteredRequests = appProvider.leaveRequests.where((request) {
      final typeFilter = appProvider.leaveTypeFilter == 'all' ||
          request.leaveTypeId.toString() == appProvider.leaveTypeFilter;
      final statusFilter = appProvider.leaveStatusFilter == 'all' ||
          request.status.name == appProvider.leaveStatusFilter;
      return typeFilter && statusFilter;
    }).toList();

    if (filteredRequests.isEmpty) {
      return const Center(child: Text('لا توجد طلبات إجازة.'));
    }

    return ListView.builder(
      itemCount: filteredRequests.length,
      itemBuilder: (context, index) {
        final request = filteredRequests[index];
        final employee = appProvider.employees.firstWhere(
          (emp) => emp.id == request.employeeId,
          orElse: () => appProvider.employees.first, // Placeholder
        );
        final leaveType = appProvider.leaveTypes.firstWhere(
          (type) => type.id == request.leaveTypeId,
          orElse: () => appProvider.leaveTypes.first, // Placeholder
        );

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text('${employee.fullName} - ${leaveType.name}'),
            subtitle: Text(
                'من ${request.startDate.toLocal()} إلى ${request.endDate.toLocal()} (${request.totalDays} أيام)'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Chip(
                  label: Text(request.status.name), // TODO: Add translation
                  backgroundColor: request.statusColor,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Implement edit leave request dialog
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // TODO: Implement delete confirmation
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}