import 'package:curricuts/bloc/subjects/subjects_bloc.dart';
import 'package:curricuts/core/theme/app.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/presentation/widgets/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:url_launcher/url_launcher.dart';

class SubjectsView extends StatelessWidget {
  const SubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppPaddingValues.smallPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _ContentWidget(),
          ],
        ),
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
          return Expanded(
            child: SearchableList<SubjectEntity>.seperated(
              initialList: state.subjects,
              builder: (subject) {
                final _url = Uri.parse(subject.link);
                return ListTile(
                  title: Text(subject.name),
                  onTap: () => _launchUrl(_url),
                );
              },
              filter: (value) {
                final filteredSubjects = state.subjects.where((element) {
                  return element.name
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
                    color: AppColors.blue,
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
