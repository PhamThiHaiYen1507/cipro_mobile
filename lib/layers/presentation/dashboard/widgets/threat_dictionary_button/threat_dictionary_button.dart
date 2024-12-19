import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/widgets/threat_builder/threat_builder.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

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
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Name',
                    style: AppTextStyle.f16B,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Description',
                    style: AppTextStyle.f16B,
                  ),
                ),
              ),
            ]),
            ThreatBuilder(
              builder: (c, threats) {
                return ListView.builder(
                  padding: AppPadding.v8,
                  shrinkWrap: true,
                  itemCount: threats.length,
                  itemBuilder: (context, index) {
                    final threat = threats[index];
                    return Padding(
                      padding: AppPadding.a8,
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: TextMarqueeWidget(
                                child: Text(threat.name ?? ''))),
                        Expanded(
                            child: TextMarqueeWidget(
                                child: Text(threat.description ?? ''))),
                      ]),
                    );
                  },
                );
              },
            ),
            AppSpacing.h16,
            Align(
              alignment: Alignment.centerRight,
              child: Button(onPressed: context.pop, child: const Text('Close')),
            )
          ],
        ),
      ),
    );
  }
}
