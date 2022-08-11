// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings
// import 'package:flutter/material.dart';
// import 'package:note_demo/models/task_model.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.only(top: 50, right: 25, left: 25),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Text(
//                   'Tasks Apps',
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                 ),
//                 Expanded(child: Container()),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.add,
//                     size: 30,
//                   ),
//                 ),
//               ],
//             ),
//             CustomText(
//               text: 'Task',
//               child: Expanded(
//                 child: Builder(builder: (context) {
//                   return ListView(children: [
//                     ...List.generate(
//                       3,
//                       (index) {
//                         return TaskContainer(
//                           index: index,
//                           task: Task(
//                               title:
//                                   CustomText.of(context).text + ' ${index + 1}',
//                               description: CustomText.of(context).text +
//                                   ' ${index + 1} description'),
//                         );
//                       },
//                     ),
//                   ]);
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // print(details.length);
//           // details.add(Task(
//           //     title: 'task ${details.length + 1}',
//           //     description: 'task description'));

//           setState(() {
//             // text = 'Item';
//           });
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class TaskContainer extends StatefulWidget {
//   const TaskContainer({
//     Key? key,
//     required this.task,
//     required this.index,
//   }) : super(key: key);

//   final Task task;
//   final int index;

//   @override
//   State<TaskContainer> createState() => _TaskContainerState();
// }

// class _TaskContainerState extends State<TaskContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       height: 80,
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: const Offset(5, 5))
//           ]),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.task.title,
//                 style:
//                     const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(widget.task.description),
//             ],
//           ),
//           Expanded(child: Container()),
//           Material(
//             color: Colors.transparent,
//             child: InkWell(
//                 onTap: () {
//                   // details.removeAt(index);
//                   // print(details.length);
//                   CustomText.of(context).text = 'Item';
//                   print(CustomText.of(context).text);
//                   setState(() {});
//                 },
//                 child: const Icon(Icons.edit)),
//           ),
//           const SizedBox(
//             width: 5,
//           ),
//           Material(
//             color: Colors.transparent,
//             child: InkWell(
//                 onTap: () {
//                   // details.removeAt(index);
//                   // print(details.length);
//                   // CustomText.of(context).text = 'Item';
//                 },
//                 child: const Icon(Icons.delete)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomText extends InheritedWidget {
//   final Widget child;
//   late String text;
//   CustomText({required this.text, required this.child}) : super(child: child);

//   static CustomText of(BuildContext context) {
//     final CustomText? result =
//         context.dependOnInheritedWidgetOfExactType<CustomText>();
//     assert(result != null, 'No Custom Text found in context');
//     return result!;
//   }

//   @override
//   bool updateShouldNotify(CustomText oldWidget) {
//     print(oldWidget.text);
//     if (oldWidget.text != text) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }



// // ListView.builder(
// //                   itemCount: details.length,
// //                   itemBuilder: ((context, index) {
// //                     return TaskContainer(
// //                       task: details[index],
// //                       index: index,
// //                     );
// //                   }),
// //                 ),