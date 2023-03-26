import 'package:edu_app/common/lists/refreshable_models_list_controller.dart';
import 'package:edu_app/common/views/error/error_view.dart';
import 'package:edu_app/common/views/error/error_view_controller.dart';
import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef ListViewBuilder<T> = Widget Function(
  BuildContext context,
  List<T> models,
);

abstract class BaseRefreshableModelsList<T extends BaseModel> extends StatefulWidget {
  final RefreshableModelsListController<T> controller;
  final ListViewBuilder<T> listViewBuilder;
  final EdgeInsets listPadding;
  final Key? loadingIndicatorKey;
  final ScrollController? scrollController;

  const BaseRefreshableModelsList({
    required this.controller,
    required this.listViewBuilder,
    required this.listPadding,
    this.loadingIndicatorKey,
    this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  _BaseRefreshableModelsListState<T> createState() => _BaseRefreshableModelsListState<T>();
}

class _BaseRefreshableModelsListState<T extends BaseModel> extends State<BaseRefreshableModelsList<T>> {
  final _refreshController = RefreshController();

  late final _connectionErrorViewController = _ConnectionErrorViewController(widget.controller);
  late final _undefinedErrorViewController = _UndefinedErrorViewController(widget.controller);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        context.read<ModelsListProviderBloc<T>>().add(ModelsListProviderRefreshRequested(
          queryParameters: widget.controller.queryParameters(context),
        ));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<ModelsListProviderBloc<T>, ModelsListProviderState<T>>(
    listenWhen: (previous, current) => previous.status != current.status,
    listener: (context, state) {
      switch (state.status) {
        case ModelsListProviderStatus.refreshingSuccess:
          _refreshController.refreshCompleted(resetFooterState: true);
          _refreshController.footerMode?.value = LoadStatus.idle;
          break;
        case ModelsListProviderStatus.loadingNextPageSuccess:
          _refreshController.loadComplete();
          break;
        case ModelsListProviderStatus.refreshingConnectionError:
        case ModelsListProviderStatus.refreshingUndefinedError:
          _refreshController.refreshFailed();
          if (state.models.value != null) {
            EduSnackBar.showError(context, message: 'error');
          }
          break;
        case ModelsListProviderStatus.loadingNextPageConnectionError:
        case ModelsListProviderStatus.loadingNextPageUndefinedError:
          _refreshController.loadFailed();
          if (state.models.value != null) {
            EduSnackBar.showError(context, message: 'error');
          }
          break;
        default:
          break;
      }
    },
    buildWhen: (previous, current) => previous.models.value != current.models.value
        || previous.count.value != current.count.value
        || previous.canLoadNextPage != current.canLoadNextPage
        || previous.status != current.status,
    builder: (context, state) {
      final models = state.models.value;
      if (models == null) {
        if (state.status == ModelsListProviderStatus.refreshingConnectionError) {
          return ErrorView(
            controller: _connectionErrorViewController,
          );
        } else if (state.status == ModelsListProviderStatus.refreshingUndefinedError) {
          return ErrorView(
            controller: _undefinedErrorViewController,
          );
        }

        return Center(
          child: LoadingIndicator(scale: 2, key: widget.loadingIndicatorKey),
        );
      }

      return SmartRefresher(
        scrollController: widget.scrollController,
        header: CustomHeader(
          height: 52,
          builder: (_, __) => const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: LoadingIndicator(scale: 1.2),
          ),
        ),
        footer: CustomFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          height: 52,
          builder: (_, __) => const Padding(
            padding: EdgeInsets.only(top: 16),
            child: LoadingIndicator(scale: 1.2),
          ),
        ),
        enablePullUp: state.canLoadNextPage
            && widget.controller.overrideCanLoadNextPage
            && models.isNotEmpty
            && models.length < (state.count.value ?? 0),
        enablePullDown: state.status.canRefresh && widget.controller.overrideCanRefresh,
        onRefresh: () => context.read<ModelsListProviderBloc<T>>().add(ModelsListProviderRefreshRequested(
          queryParameters: widget.controller.queryParameters(context),
        )),
        onLoading: () => context.read<ModelsListProviderBloc<T>>().add(ModelsListProviderNextPageRequested(
          queryParameters: widget.controller.queryParameters(context),
        )),
        controller: _refreshController,
        child: models.isEmpty
            ? Builder(builder: (context) => Center(child: Text(
                context.select<S, String>((value) => value.common_lists_loading_noItemsMessage),
                style: Theme.of(context).textTheme.bodyMedium,
              )))
            : widget.listViewBuilder(context, models),
      );
    },
  );
}

class _ConnectionErrorViewController<T extends BaseModel> extends ErrorViewController {
  final RefreshableModelsListController<T> controller;

  @override
  ErrorImageType get type => ErrorImageType.connectionError;

  const _ConnectionErrorViewController(this.controller);

  @override
  String titleSelector(S translations) => translations.common_lists_loading_connectionErrorMessage;

  @override
  String? subtitleSelector(S translations) => null;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.common_lists_loading_tryAgainButtonText;

  @override
  void onTryAgainButtonTap(BuildContext context) => context.read<ModelsListProviderBloc<T>>()
      .add(ModelsListProviderRefreshRequested(
        queryParameters: controller.queryParameters(context),
      ));
}

class _UndefinedErrorViewController<T extends BaseModel> extends ErrorViewController {
  final RefreshableModelsListController<T> controller;

  @override
  ErrorImageType get type => ErrorImageType.undefinedError;

  const _UndefinedErrorViewController(this.controller);

  @override
  String titleSelector(S translations) => translations.common_lists_loading_undefinedErrorMessageTitle;

  @override
  String? subtitleSelector(S translations) => translations.common_lists_loading_undefinedErrorMessageSubtitle;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.common_lists_loading_tryAgainButtonText;

  @override
  void onTryAgainButtonTap(BuildContext context) => context.read<ModelsListProviderBloc<T>>()
      .add(ModelsListProviderRefreshRequested(
        queryParameters: controller.queryParameters(context),
      ));
}