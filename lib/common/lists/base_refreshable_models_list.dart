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
  final Key? loadingIndicatorKey;
  final ScrollController? scrollController;

  const BaseRefreshableModelsList({
    required this.controller,
    required this.listViewBuilder,
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

      if (models.isEmpty) {
        return const Center(child: Text('Nothing found'));
      }

      return SmartRefresher(
        scrollController: widget.scrollController,
        header: CustomHeader(
          builder: (_, __) => const _LoadingIndicator(),
        ),
        footer: CustomFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          builder: (_, __) => const _LoadingIndicator(),
        ),
        enablePullUp: state.canLoadNextPage && widget.controller.overrideCanLoadNextPage,
        enablePullDown: state.status.canRefresh && widget.controller.overrideCanRefresh,
        onRefresh: () => context.read<ModelsListProviderBloc<T>>().add(ModelsListProviderRefreshRequested(
          queryParameters: widget.controller.queryParameters(context),
        )),
        onLoading: () => context.read<ModelsListProviderBloc<T>>().add(ModelsListProviderNextPageRequested(
          queryParameters: widget.controller.queryParameters(context),
        )),
        controller: _refreshController,
        child: widget.listViewBuilder(context, models),
      );
    },
  );
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: LoadingIndicator(scale: 1.2),
  );
}

class _ConnectionErrorViewController<T extends BaseModel> extends ErrorViewController {
  final RefreshableModelsListController<T> controller;

  @override
  ErrorImageType get type => ErrorImageType.connectionError;

  const _ConnectionErrorViewController(this.controller);

  @override
  String titleSelector(S translations) => translations.common_lists_loadingConnectionErrorMessage;

  @override
  String? subtitleSelector(S translations) => null;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.common_lists_loadingTryAgainButtonText;

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
  String titleSelector(S translations) => translations.common_lists_loadingUndefinedErrorMessageTitle;

  @override
  String? subtitleSelector(S translations) => translations.common_lists_loadingUndefinedErrorMessageSubtitle;

  @override
  String tryAgainButtonTextSelector(S translations) => translations.root_home_weatherLoadingTryAgainButtonText;

  @override
  void onTryAgainButtonTap(BuildContext context) => context.read<ModelsListProviderBloc<T>>()
      .add(ModelsListProviderRefreshRequested(
        queryParameters: controller.queryParameters(context),
      ));
}