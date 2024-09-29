import 'package:flutter/material.dart';

class ManagementSection extends StatefulWidget {
  const ManagementSection({super.key});

  @override
  State<ManagementSection> createState() => _ManagementSectionState();
}

class _ManagementSectionState extends State<ManagementSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(context),
          _listOfButtons(),
        ],
      ),
    );
  }

  Text _title(BuildContext context) =>
      Text("مدیریت", style: Theme.of(context).textTheme.titleMedium);

  Widget _listOfButtons() {
    return Column(
      children: [
        _userManagement(),
        _siteManagement(),
      ],
    );
  }

  Widget _userManagement() {
    return ListTile(
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
      onTap: () {},
      title: const Text("مدیریت کاربران"),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  Widget _siteManagement() {
    return ListTile(
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
      onTap: () {},
      title: const Text("مدیریت سایت"),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
