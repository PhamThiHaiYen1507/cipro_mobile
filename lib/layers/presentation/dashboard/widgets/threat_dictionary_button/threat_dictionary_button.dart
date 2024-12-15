import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/widgets/threat_builder/threat_builder.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:flutter/material.dart';

class ThreatDictionaryButton extends StatelessWidget {
  const ThreatDictionaryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      padding: AppPadding.a8,
      onPressed: () => showThreatDictionary(context),
      backgroundColor: Colors.cyan,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bug_report, color: Colors.white),
          Text('Threat dictionary'),
        ],
      ),
    );
  }

  void showThreatDictionary(BuildContext context) {
    AppDialog.dialog(
        context: context,
        title: 'Threat dictionary',
        insetPadding: AppPadding.a16,
        content: ThreatBuilder(
          builder: (c, threats) {
            return ListView.builder(
              itemCount: threats.length,
              itemBuilder: (context, index) {
                return const Row(children: []);
              },
            );
          },
        ));
  }
}
