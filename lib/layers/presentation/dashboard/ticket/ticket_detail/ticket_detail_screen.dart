import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';

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
  _TicketDetailScreenState createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState
    extends MobxState<TicketDetailScreen, TicketDetailController> {
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
      body: Padding(
        padding: AppPadding.a16,
        child: TicketDetailBuilder(
          ticketId: widget.ticketId,
          builder: (controller, ticket) {
            if (ticket == null) return const SizedBox();

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
                          Icon(statusIcons[ticket.status], color: Colors.white),
                          AppSpacing.w8,
                          Text(
                            ticket.status ?? '',
                            style:
                                AppTextStyle.f16R.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: AppPadding.a8.add(AppPadding.h8),
                      decoration: BoxDecoration(
                        color: statusColors[ticket.status],
                        borderRadius: AppBorderRadius.xl,
                      ),
                      child: Row(
                        children: [
                          Icon(confirmationIcons[ticket.status],
                              color: Colors.white),
                          AppSpacing.w8,
                          Text(
                            textConfirmation[ticket.status] ?? '',
                            style:
                                AppTextStyle.f16R.copyWith(color: Colors.white),
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
              ],
            );
          },
        ),
      ),
    );
  }
}
