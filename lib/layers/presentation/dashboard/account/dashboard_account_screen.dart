import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/presentation/dashboard/account/widgets/delete_account_dialog.dart';
import 'package:base_project/layers/presentation/dashboard/account/widgets/edit_account/edit_account_dialog.dart';
import 'package:base_project/layers/presentation/widgets/account_list_builder/account_list_builder.dart';
import 'package:base_project/layers/presentation/widgets/account_list_builder/account_list_builder_controller.dart';
import 'package:base_project/layers/presentation/widgets/grid_table/grid_table.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'dashboard_account_controller.dart';

class DashboardAccountScreen
    extends MobxStatefulWidget<DashboardAccountController> {
  final AccountRole role;

  const DashboardAccountScreen({super.key, required this.role});

  @override
  MobxState<MobxStatefulWidget<DashboardAccountController>,
          DashboardAccountController>
      createState() => _DashboardAccountScreenState();

  @override
  DashboardAccountController? createController() =>
      DashboardAccountController(injector());
}

class _DashboardAccountScreenState
    extends MobxState<DashboardAccountScreen, DashboardAccountController> {
  AccountListBuilderController? _accountListBuilderController;
  @override
  Widget build(BuildContext context) {
    final List<GridTableColumnConfig<AccountInfoModel>> configs = [
      GridTableColumnConfig(
        columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
        headerBuilder: (context) {
          return Container(
            color: AppColors.greyColor.o(0.2),
            alignment: Alignment.center,
            child: Text('Username'.toUpperCase()),
          );
        },
        cellBuilder: (context, data, index) =>
            Align(child: TextMarqueeWidget(child: Text(data.username))),
      ),
      GridTableColumnConfig(
        columnWidth: const TableSpan(extent: FixedSpanExtent(180)),
        headerBuilder: (context) {
          return Container(
            color: AppColors.greyColor.o(0.2),
            alignment: Alignment.centerLeft,
            child: Text('Email'.toUpperCase()),
          );
        },
        cellBuilder: (context, data, index) => Align(
            alignment: Alignment.centerLeft,
            child: TextMarqueeWidget(child: Text(data.email))),
      ),
      GridTableColumnConfig(
        columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
        headerBuilder: (context) {
          return Container(
            color: AppColors.greyColor.o(0.2),
            alignment: Alignment.center,
            child: Text('Role'.toUpperCase()),
          );
        },
        cellBuilder: (context, data, index) => Center(
          child: Container(
            padding: AppPadding.a8.add(AppPadding.h8),
            decoration: BoxDecoration(
              borderRadius: AppBorderRadius.xl,
              color: data.role.color,
            ),
            child: Text(
              data.role.name,
              style: AppTextStyle.f14B.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      GridTableColumnConfig(
        columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
        headerBuilder: (context) {
          return Container(
            color: AppColors.greyColor.o(0.2),
            alignment: Alignment.center,
            child: Text('Action'.toUpperCase()),
          );
        },
        cellBuilder: (context, data, index) => Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () => AppDialog.dialog(
                      title: 'Edit Account',
                      context: context,
                      content: EditAccountDialog(
                          accountInfo: data,
                          onSave: () =>
                              _accountListBuilderController?.getAccountList())),
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () => AppDialog.dialog(
                      title: 'Delete Account',
                      context: context,
                      content: DeleteAccountDialog(onDelete: () async {
                        final bool result =
                            await controller.deleteAccount(context, data);
                        if (result) {
                          _accountListBuilderController?.getAccountList();
                        }
                      })),
                  icon: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    ];

    return AccountListBuilder(
      onInitialize: (controller) => _accountListBuilderController = controller,
      builder: (accounts) {
        return GridTable(
          items: accounts,
          configs: configs,
          rowHeight: 70,
        );
      },
    );
  }
}
