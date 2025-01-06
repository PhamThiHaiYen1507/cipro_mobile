import 'package:flutter/material.dart';

enum BottomNavigationType {
  overview(icon: Icons.home_outlined, title: 'Overview'),
  ticket(icon: Icons.checklist_rtl_outlined, title: 'Ticket'),
  task(icon: Icons.task_outlined, title: 'Task'),
  vulnerability(icon: Icons.security, title: 'Vulnerability'),
  home(icon: Icons.home_outlined, title: 'Home'),
  phase(icon: Icons.timeline_rounded, title: 'Phase'),
  script(icon: Icons.attractions_outlined, title: 'Script'),
  account(icon: Icons.account_box_outlined, title: 'Account'),
  template(icon: Icons.raw_on_rounded, title: 'Template'),
  scanningTool(icon: Icons.flag_outlined, title: 'Scanning Tool'),
  notification(icon: Icons.notifications, title: 'Notification');

  final IconData icon;

  final String title;

  const BottomNavigationType({required this.icon, required this.title});

  String get route => '/$name';
}
