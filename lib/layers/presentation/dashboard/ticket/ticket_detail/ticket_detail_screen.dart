import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/entities/ticket_model.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/common/text_input_validator/text_input_validator.dart';
import 'package:base_project/layers/presentation/dashboard/ticket/ticket_history_builder/ticket_history_builder.dart';
import 'package:base_project/layers/presentation/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:base_project/layers/presentation/widgets/project_member_builder/project_member_builder.dart';
import 'package:base_project/layers/presentation/widgets/resolution_builder/resolution_builder.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/helpers/text_input_validator.dart';
import 'package:base_project/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../vulnerabilities/dashboard_vulnerabilities_screen.dart';
import '../ticket_detail_builder/ticket_detail_builder.dart';
import 'ticket_detail_controller.dart';

class TicketDetailScreen extends MobxStatefulWidget<TicketDetailController> {
  final String ticketId;

  final String projectName;

  const TicketDetailScreen({
    super.key,
    required this.ticketId,
    required this.projectName,
  });

  @override
  TicketDetailController? createController() =>
      TicketDetailController(injector(), ticketId);

  @override
  _TicketDetailScreenState createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState
    extends MobxState<TicketDetailScreen, TicketDetailController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController resolution = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final statusColors = {
      'open': Colors.green,
      'closed': AppColors.primaryColor,
    };

    final statusIcons = {
      'open': Icons.check,
      'closed': Icons.close,
    };

    final confirmationIcons = {
      'open': Icons.check_circle_outline_rounded,
      'closed': Icons.replay,
    };

    final textConfirmation = {
      'open': 'Close ticket',
      'closed': 'Reopen ticket',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.a16,
          child: TicketDetailBuilder(
            ticketId: widget.ticketId,
            builder: (c, ticket) {
              if (ticket == null) return const SizedBox();

              return TicketHistoryBuilder(
                  ticketId: widget.ticketId,
                  builder: (historyController, histories) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ticket.title ?? '', style: AppTextStyle.f20B),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: AppPadding.a8.add(AppPadding.h8),
                              decoration: BoxDecoration(
                                color: statusColors[ticket.status],
                                borderRadius: AppBorderRadius.xl,
                              ),
                              child: Row(
                                children: [
                                  Icon(statusIcons[ticket.status],
                                      color: Colors.white),
                                  AppSpacing.w8,
                                  Text(
                                    ticket.status ?? '',
                                    style: AppTextStyle.f16R
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Button(
                              padding: AppPadding.a8.add(AppPadding.h8),
                              onPressed: () =>
                                  updateStatus(ticket.status).then((value) {
                                historyController.getHistories();
                                c.getTicket();
                              }),
                              backgroundColor: statusColors[ticket.status],
                              borderRadius: AppBorderRadius.xl,
                              child: Row(
                                children: [
                                  Icon(confirmationIcons[ticket.status],
                                      color: Colors.white),
                                  AppSpacing.w8,
                                  Text(
                                    textConfirmation[ticket.status] ?? '',
                                    style: AppTextStyle.f16R
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.h8,
                        Text(
                          'This ticket was ${ticket.status ?? ''} at ${Utils.formatDateToDisplay(ticket.updatedAt?.add(const Duration(hours: 7)), 'dd/MM/yyyy HH:mm')}',
                        ),
                        AppSpacing.h16,
                        const Text('History', style: AppTextStyle.f16B),
                        IntrinsicHeight(
                          child: Column(
                            children: histories.reversed
                                .map((e) => Padding(
                                      padding: AppPadding.a8,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                                Utils.getTimeDifferenceFromNow(
                                                    e.timestamp ??
                                                        DateTime.now())),
                                          ),
                                          IntrinsicHeight(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 12,
                                                  height: 12,
                                                  margin: AppPadding.a4,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Container(
                                                  width: 1,
                                                  color: Colors.grey,
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Text(e.description ?? '')),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        AppSpacing.h16,
                        const Text('Assigner', style: AppTextStyle.f16B),
                        Text(ticket.assigner?.account?.username ?? 'System'),
                        AppSpacing.h16,
                        const Text('Assignee', style: AppTextStyle.f16B),
                        ProjectMemberBuilder(
                          projectName: widget.projectName,
                          builder: (_, members) {
                            return CustomDropdown(
                              items: members,
                              fitSize: true,
                              itemBuilder: (item) => Container(
                                width: double.maxFinite,
                                padding: AppPadding.a8,
                                child: Text(item.account?.username ?? ''),
                              ),
                              selectedItem: controller.assignee ??
                                  members.firstWhereOrNull((element) =>
                                      ticket.assignee?.memberId ==
                                      element.memberId),
                              onSelected: (item) {
                                controller.onUpdateAssignee(item);
                                updateAssignee(item, ticket).then((result) {
                                  if (result) {
                                    historyController.getHistories();
                                    c.getTicket();
                                  }
                                });
                              },
                            );
                          },
                        ),
                        AppSpacing.h16,
                        const Text('Priority', style: AppTextStyle.f16B),
                        Container(
                          padding: AppPadding.a8.add(AppPadding.h8),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: AppBorderRadius.xl,
                          ),
                          child: Text(
                            ticket.priority ?? '',
                            style:
                                AppTextStyle.f16B.copyWith(color: Colors.white),
                          ),
                        ),
                        AppSpacing.h16,
                        const Text('Description', style: AppTextStyle.f16B),
                        Text(ticket.description ?? ''),
                        AppSpacing.h16,
                        const Text('Vulnerabilities', style: AppTextStyle.f16B),
                        ...ticket.targetedVulnerability.map((e) => Padding(
                              padding: AppPadding.v8,
                              child: Column(
                                children: [
                                  VulnerabilityItem(vuln: e),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Button(
                                        onPressed: () => showAddResolutionPopup(
                                            e.cveId ?? ''),
                                        backgroundColor: Colors.transparent,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.add,
                                              color: AppColors.primaryColor,
                                            ),
                                            Text(
                                              'Add resolution',
                                              style: AppTextStyle.f14B.copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Button(
                                        onPressed: () =>
                                            showResolutionView(e.cveId ?? ''),
                                        backgroundColor: Colors.transparent,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.menu_book_rounded,
                                              color: AppColors.primaryColor,
                                            ),
                                            AppSpacing.w4,
                                            Text(
                                              'View resolution',
                                              style: AppTextStyle.f14B.copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                      ],
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  Future<void> updateStatus(String? status) async {
    bool result = false;

    if (status == 'closed') {
      result = await controller.updateTicket(status: 'open');
    } else if (status == 'open') {
      result = await controller.updateTicket(status: 'closed');
    }

    if (result) {
      AppDialog.showNotification(
        context: context,
        message: 'Update ticket success',
        type: NotificationType.success,
      );
    }
  }

  Future<bool> updateAssignee(
      ProjectMemberInfoModel item, TicketModel ticket) async {
    if (item.memberId != ticket.assignee?.memberId) {
      return controller.updateTicket(assigneeId: item.memberId);
    }

    return false;
  }

  void showAddResolutionPopup(String cveId) {
    AppDialog.dialog(
      context: context,
      title: 'Add resolution',
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextInputValidator(
              controller: resolution,
              label: 'Description',
              minLines: 5,
              maxLines: 5,
              validator: (value) => TextValidate.validateEmpty(value,
                  errorText: 'Description cannot be empty'),
            ),
            AppSpacing.h16,
            Row(
              children: [
                Expanded(
                  child: Button(
                    backgroundColor: Colors.red,
                    onPressed: context.pop,
                    child: const Text('Cancel'),
                  ),
                ),
                AppSpacing.w16,
                Expanded(
                  child: Button(
                    onPressed: () async {
                      if (formKey.currentState?.validate() == true) {
                        context.pop();
                        final result = await controller.onAddResolution(
                          cveId,
                          resolution.text,
                        );

                        if (result) {
                          AppDialog.showNotification(
                            context: context,
                            message: 'Add resolution success',
                            type: NotificationType.success,
                          );
                        } else {
                          AppDialog.showNotification(
                            context: context,
                            message: 'Add resolution failed',
                            type: NotificationType.error,
                          );
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showResolutionView(String cveId) {
    AppDialog.dialog(
      context: context,
      title: 'Resolution',
      insetPadding: AppPadding.a16,
      content: SizedBox(
        width: double.maxFinite,
        child: ResolutionBuilder(
          cveIds: [cveId],
          builder: (resolutions) {
            if (resolutions.isEmpty) {
              return const Text(
                'Please add the resolution',
                style: AppTextStyle.f14B,
                textAlign: TextAlign.center,
              );
            }

            final resolution = resolutions.first.resolution;

            return ListView.builder(
              shrinkWrap: true,
              itemCount: resolution.length,
              itemBuilder: (context, index) {
                final data = resolution[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_circle),
                        AppSpacing.w8,
                        Text(data.createdBy, style: AppTextStyle.f14B),
                      ],
                    ),
                    Text.rich(TextSpan(children: [
                      const TextSpan(
                          text: 'Description: ', style: AppTextStyle.f14B),
                      TextSpan(text: data.description)
                    ])),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    resolution.dispose();
    super.dispose();
  }
}
