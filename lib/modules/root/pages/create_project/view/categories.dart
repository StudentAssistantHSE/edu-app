import 'package:edu_app/modules/root/pages/create_project/view/controllers.dart';
import 'package:edu_app/modules/root/root_module.dart';
import 'package:edu_models/edu_models.dart';
import 'package:edu_ui_components/edu_ui_components.dart';
import 'package:feature_create_project/feature_create_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  const Categories({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => EduCard(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: TextWidget(
                textStyle: TextThemeReference.title,
                controller: CategoriesTitleTextController(),
              ),
            ),
            const SizedBox(width: 16),
            EduIconButton(
              icon: const Icon(CustomIcons.plus),
              onPressed: () => ModuleControllerProvider.of<RootModuleController>(context)
                  ?.openCategories().then(
                    (value) {
                  if (value is CategoryModel) {
                    context.read<CreateProjectBloc>().add(
                      value.isCustom
                          ? CreateProjectCustomCategoryAdded(value.category)
                          : CreateProjectExistingCategoryAdded(value.id, value.category),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        BlocBuilder<CreateProjectBloc, CreateProjectState>(
          buildWhen: (previous, current) => previous.categories != current.categories,
          builder: (context, state) {
            if (state.categories.isEmpty) {
              return const SizedBox.shrink();
            }
            final theme = EduTheme.of(context);
            return Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 16,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
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
                        onDeleted: () => context.read<CreateProjectBloc>().add(
                          category is ExistingCategory
                              ? CreateProjectExistingCategoryRemoved(category.value)
                              : category is CustomCategory
                              ? CreateProjectCustomCategoryRemoved(category.value)
                              : CreateProjectCustomCategoryRemoved(category.text),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}