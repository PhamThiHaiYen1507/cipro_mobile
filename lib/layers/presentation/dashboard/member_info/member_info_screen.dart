import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/presentation/widgets/project_member_info_builder/project_member_info_builder.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

class MemberInfoScreen extends StatelessWidget {
  final String memberId;

  const MemberInfoScreen({super.key, required this.memberId});

  @override
  Widget build(BuildContext context) {
    return ProjectMemberInfoBuilder(
      memberId: memberId,
      builder: (c, member) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: AppPadding.a16,
            children: [
              Container(
                padding: AppPadding.a16,
                decoration: context.defaultBox,
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 120,
                      color: Colors.blueGrey,
                    ),
                    Row(
                      children: [
                        AppSpacing.a8,
                        Expanded(
                          child: member?.name?.isNotEmpty == true
                              ? TextMarqueeWidget(
                                  child: Text(
                                    member?.name ?? '',
                                    style: AppTextStyle.f24B,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        AppSpacing.a8,
                        Container(
                          padding: AppPadding.a8.add(AppPadding.h8),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: AppBorderRadius.xl,
                          ),
                          child: Text(
                            member?.account?.role.name ?? '',
                            style:
                                AppTextStyle.f16B.copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.h16,
              Container(
                padding: AppPadding.a16,
                decoration: context.defaultBox,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tasks',
                      style: AppTextStyle.f20B,
                    )
                  ],
                ),
              ),
              AppSpacing.h16,
              Container(
                padding: AppPadding.a16,
                decoration: context.defaultBox,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity history',
                      style: AppTextStyle.f20B,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
