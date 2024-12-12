import 'package:flutter/material.dart';

class PermissionGroup extends StatefulWidget {
  final String groupName;
  final List<String> permissions;
  final List<String> userPermissions;
  const PermissionGroup(
      {super.key,
      required this.groupName,
      required this.permissions,
      required this.userPermissions});

  @override
  State<PermissionGroup> createState() => _PermissionGroupState();
}

class _PermissionGroupState extends State<PermissionGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.groupName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...widget.permissions.map((permission) {
          return CheckboxListTile(
            title: Text(permission.split(":")[1]),
            value: widget.userPermissions.contains(permission),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  widget.userPermissions.add(permission);
                } else {
                  widget.userPermissions.remove(permission);
                }
              });
            },
          );
        }),
        const Divider(),
      ],
    );
  }
}
