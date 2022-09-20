import 'package:curricuts/bloc/graph/graph_bloc.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/presentation/widgets/error_card.dart';
import 'package:curricuts/presentation/widgets/subject_overview_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphview/GraphView.dart';

class GraphWidgetWrapper extends StatelessWidget {
  const GraphWidgetWrapper({
    super.key,
    required this.subjects,
    required this.selectedSubject,
  });

  final List<SubjectEntity> subjects;
  final SubjectEntity selectedSubject;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = GraphBloc(subjects);
        bloc.add(LoadGraphEvent(subject: selectedSubject));
        return bloc;
      },
      child: GraphWidget(selectedSubject: selectedSubject),
    );
  }
}

class GraphWidget extends StatelessWidget {
  const GraphWidget({super.key, required this.selectedSubject});

  final SubjectEntity selectedSubject;

  Widget _generateNodeWidget(
    BuildContext context,
    SubjectEntity currentSubject,
  ) {
    final isSelected = selectedSubject == currentSubject;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: InkWell(
        onTap: () {
          // print('Subject ${subject.spkCode} clicked');
          // const radius = AppBorderRadiusValues.xSmallBorderRadius;
          // final borderRadius = BorderRadius.circular(radius);
          showDialog<void>(
            context: context,
            builder: (context) {
              return SubjectOverviewDialog(subject: currentSubject);
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 80,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isSelected ? 100 : 10),
            boxShadow: [
              BoxShadow(
                color: isSelected ? Colors.green : const Color(0xFF0E4BEB),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              currentSubject.name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphBloc, GraphState>(
      builder: (context, state) {
        if (state is LoadedGraphState) {
          return InteractiveViewer(
            constrained: false,
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.001,
            maxScale: 100,
            child: GraphView(
              graph: state.graph,
              algorithm: state.builder,
              paint: Paint()
                ..color = Colors.green
                ..strokeWidth = 1
                ..style = PaintingStyle.fill,
              builder: (Node node) {
                // I can decide what widget should be shown here based on the id
                final subject = node.key!.value as SubjectEntity;
                return _generateNodeWidget(context, subject);
              },
            ),
          );
        } else if (state is LoadingGraphState) {
          return const CircularProgressIndicator();
        } else if (state is EmptyGraphState) {
          return Text(
            'No subject has ${selectedSubject.name} as a prerequisite',
          );
        } else if (state is FailedGraphState) {
          return ErrorCardWidget(message: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

// class GraphWidget extends StatefulWidget {
//   const GraphWidget({Key? key, required this.subjects}) : super(key: key);

//   final List<SubjectEntity> subjects;

//   @override
//   State<GraphWidget> createState() => _GraphWidgetState();
// }

// class _GraphWidgetState extends State<GraphWidget> {
//   late Algorithm builder;
//   final Graph graph = Graph();
//   Random r = Random();

//   @override
//   void initState() {
//     final node1 = Node.Id(widget.subjects[400]);
//     final node2 = Node.Id(widget.subjects[405]);
//     final node3 = Node.Id(widget.subjects[409]);
//     final node4 = Node.Id(widget.subjects[400]);

//     graph.addEdge(node1, node2);
//     graph.addEdge(node1, node3);
//     graph.addEdge(node2, node4);
//     builder = FruchtermanReingoldAlgorithm(renderer: ArrowEdgeRenderer());
//   }

//   Widget _generateNodeWidget(SubjectEntity subject) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0),
//       child: InkWell(
//         onTap: () {
//           // print('Subject ${subject.spkCode} clicked');
//           // const radius = AppBorderRadiusValues.xSmallBorderRadius;
//           // final borderRadius = BorderRadius.circular(radius);
//           showDialog<void>(
//             context: context,
//             builder: (context) => SubjectOverviewDialog(subject: subject),
//           );
//         },
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           height: 80,
//           width: 160,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: const [
//               BoxShadow(color: Color(0xFF0E4BEB), spreadRadius: 2),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               subject.name,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InteractiveViewer(
//       constrained: false,
//       boundaryMargin: const EdgeInsets.all(100),
//       minScale: 0.001,
//       maxScale: 100,
//       child: GraphView(
//         graph: graph,
//         algorithm: builder,
//         paint: Paint()
//           ..color = Colors.green
//           ..strokeWidth = 1
//           ..style = PaintingStyle.fill,
//         builder: (Node node) {
//           // I can decide what widget should be shown here based on the id
//           var a = node.key!.value as SubjectEntity;
//           return _generateNodeWidget(a);
//         },
//       ),
//     );
//   }
// }
