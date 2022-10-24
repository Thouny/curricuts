import 'package:curricuts/bloc/subjects/subjects_bloc.dart';
import 'package:curricuts/core/theme/app.dart';
import 'package:curricuts/core/utils/responsive.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/presentation/widgets/error_card.dart';
import 'package:curricuts/presentation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:url_launcher/url_launcher.dart';

class SubjectsView extends StatelessWidget {
  const SubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            const Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: SideMenu(),
            ),
          const Expanded(
            // It takes 5/6 part of the screen
            flex: 5,
            child: _ContentWidget(),
          ),
        ],
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({Key? key}) : super(key: key);

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectsBloc, SubjectsState>(
      builder: (context, state) {
        if (state is LoadedSubjectsState) {
          return Padding(
            padding: const EdgeInsets.all(AppPaddingValues.smallPadding),
            child: SearchableList<SubjectEntity>.seperated(
              initialList: state.subjects,
              builder: (subject) {
                final url = Uri.parse(subject.link);
                return ListTile(
                  title: Text('${subject.code} - ${subject.name}'),
                  onTap: () => _launchUrl(url),
                );
              },
              filter: (value) {
                final filteredSubjects = state.subjects.where((element) {
                  return '${element.code} - ${element.name}'
                      .toLowerCase()
                      .contains(value.toLowerCase());
                }).toList();
                return filteredSubjects;
              },
              emptyWidget: const ErrorCardWidget(
                message: 'No match was found',
                shouldRenderCard: false,
              ),
              inputDecoration: InputDecoration(
                labelText: "Search a subject",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              seperatorBuilder: (context, indext) => const Divider(),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
