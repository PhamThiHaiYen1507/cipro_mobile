import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/layers/domain/entities/ticket_model.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/create_ticket_button/create_ticket_button.dart';
import 'package:base_project/layers/presentation/widgets/grid_table/grid_table.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'ticket_builder/ticket_builder.dart';

class DashboardTicketScreen extends StatelessWidget {
  final String projectName;

  const DashboardTicketScreen({super.key, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return TicketBuilder(
        projectName: projectName,
        builder: (c, tickets) {
          final List<GridTableColumnConfig<TicketModel>> configs = [
            GridTableColumnConfig(
              columnWidth: const TableSpan(extent: FixedSpanExtent(180)),
              headerBuilder: (context) {
                return Container(
                  color: AppColors.greyColor.o(0.2),
                  padding: AppPadding.h8,
                  alignment: Alignment.centerLeft,
                  child: Text('Name'.toUpperCase()),
                );
              },
              cellBuilder: (context, data, index) => Container(
                padding: AppPadding.h8,
                alignment: Alignment.centerLeft,
                child: TextMarqueeWidget(child: Text(data.title ?? '')),
              ),
            ),
            GridTableColumnConfig(
              columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
              headerBuilder: (context) {
                return Container(
                  color: AppColors.greyColor.o(0.2),
                  alignment: Alignment.center,
                  child: Text('Priority'.toUpperCase()),
                );
              },
              cellBuilder: (context, data, index) => Align(
                alignment: Alignment.center,
                child: Text(data.priority ?? ''),
              ),
            ),
            GridTableColumnConfig(
              columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
              headerBuilder: (context) {
                return Container(
                  color: AppColors.greyColor.o(0.2),
                  alignment: Alignment.center,
                  child: Text('Status'.toUpperCase()),
                );
              },
              cellBuilder: (context, data, index) => Align(
                alignment: Alignment.center,
                child: Text(data.status ?? ''),
              ),
            ),
            GridTableColumnConfig(
              columnWidth: const TableSpan(extent: FixedSpanExtent(170)),
              headerBuilder: (context) {
                return Container(
                  color: AppColors.greyColor.o(0.2),
                  alignment: Alignment.centerLeft,
                  child: Text('Assigned to'.toUpperCase()),
                );
              },
              cellBuilder: (context, data, index) => Align(
                alignment: Alignment.centerLeft,
                child:
                    TextMarqueeWidget(child: Text(data.assignee?.name ?? '')),
              ),
            ),
            GridTableColumnConfig(
              columnWidth: const TableSpan(extent: FixedSpanExtent(170)),
              headerBuilder: (context) {
                return Container(
                  color: AppColors.greyColor.o(0.2),
                  alignment: Alignment.center,
                  child: Text('Created At'.toUpperCase()),
                );
              },
              cellBuilder: (context, data, index) => Align(
                alignment: Alignment.center,
                child: Text(Utils.formatDateToDisplay(data.createdAt)),
              ),
            ),
          ];

          return Column(
            children: [
              Padding(
                padding: AppPadding.h16,
                child: CreateTicketButton(
                  projectName: projectName,
                  onCreateSuccess: c.getTickets,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: context.defaultBox,
                  margin: AppPadding.a16,
                  child: GridTable<TicketModel>(
                    items: tickets,
                    configs: configs,
                    onTapRow: (index) => TicketDetailScreenRoute(
                      ticketId: tickets[index].id,
                      projectName: projectName,
                    ).push(context),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
