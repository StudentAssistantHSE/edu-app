import 'package:edu_localizations/edu_localizations.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_models_list_provider/feature_models_list_provider.dart';
import 'package:feature_profile_editing/feature_profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatefulWidget {
  const Categories({ Key? key }) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool _foundCategory = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        context.read<ModelsListProviderBloc<CategoryModel>>().add(const ModelsListProviderRefreshRequested());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Builder(
        builder: (context) => Text(
          context.select<S, String>((value) => value.root_profileEditing_categoriesTitle),
          style: EduTheme.of(context).textTheme.body,
        ),
      ),
      const SizedBox(height: 4),
      BlocBuilder<ModelsListProviderBloc<CategoryModel>, ModelsListProviderState<CategoryModel>>(
        buildWhen: (previous, current) => previous.models.value != current.models.value,
        builder: (context, state) {
          return RawAutocomplete<ExistingCategory>(
            textEditingController: _controller,
            focusNode: _focusNode,
            optionsViewBuilder: (context, onSelected, options) {
              return _AutocompleteOptions<ExistingCategory>(
                displayStringForOption: (category) => category.text,
                onSelected: onSelected,
                options: options,
                maxOptionsHeight: 200,
              );
            },
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<ExistingCategory>.empty();
              }
              return state.models.value?.where(
                    (e) => e.category.toLowerCase().startsWith(textEditingValue.text.toLowerCase()),
              ).map((e) => ExistingCategory(e.id, e.category)) ?? const Iterable<ExistingCategory>.empty();
            },
            fieldViewBuilder: (context, controller, focusNode, onSubmitted) => TextInput(
              controller: controller,
              focusNode: focusNode,
              hint: context.select<S, String>((value) => value.root_profileEditing_categoriesInputHint),
              onSubmitted: (value) {
                if (value.trim().isEmpty) {
                  return;
                }
                _foundCategory = false;
                onSubmitted();
                if (!_foundCategory) {
                  context.read<ProfileEditingBloc>().add(ProfileEditingCustomCategoryAdded(value.trim()));
                  _controller.clear();
                }
                _foundCategory = false;
              },
            ),
            onSelected: (selection) {
              _foundCategory = true;
              context.read<ProfileEditingBloc>().add(ProfileEditingExistingCategoryAdded(selection.value, selection.text));
              _controller.clear();
            },
          );
        },
      ),
      const SizedBox(height: 8),
      SizedBox(
        width: double.infinity,
        child: BlocBuilder<ProfileEditingBloc, ProfileEditingState>(
          buildWhen: (previous, current) => previous.categories != current.categories,
          builder: (context, state) {
            final theme = EduTheme.of(context);
            return Wrap(
              spacing: theme.categoriesListTheme.spacing,
              runSpacing: theme.categoriesListTheme.spacing,
              children: [
                for (final category in state.categories)
                  Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                    backgroundColor: theme.categoriesListTheme.backgroundColor
                        .resolveColorScheme(theme.colorScheme),
                    label: Text(
                      category.text,
                      style: theme.categoriesListTheme.labelStyle.resolveTextTheme(theme.textTheme)
                          .copyWith(color: theme.categoriesListTheme.foregroundColor.resolveColorScheme(theme.colorScheme)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    deleteIcon: Icon(Icons.close_rounded, color: theme.colorScheme.themeMain),
                    onDeleted: () => context.read<ProfileEditingBloc>().add(
                      category is ExistingCategory
                          ? ProfileEditingExistingCategoryRemoved(category.value)
                          : category is CustomCategory
                          ? ProfileEditingCustomCategoryRemoved(category.value)
                          : ProfileEditingCustomCategoryRemoved(category.text),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    ],
  );
}

class _AutocompleteOptions<T extends Object> extends StatelessWidget {
  final AutocompleteOptionToString<T> displayStringForOption;

  final AutocompleteOnSelected<T> onSelected;

  final Iterable<T> options;
  final double maxOptionsHeight;

  const _AutocompleteOptions({
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.maxOptionsHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxOptionsHeight),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Builder(
                    builder: (context) {
                      final highlight = AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(displayStringForOption(option)),
                      );
                    },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}