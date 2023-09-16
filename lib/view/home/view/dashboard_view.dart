// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:my_furniture/core/extension/context_extension.dart';
// import 'package:my_furniture/core/extension/string_extension.dart';
// import 'package:my_furniture/core/init/lang/locale_keys.g.dart';
// import 'package:my_furniture/view/home/viewmodel/home_cubit.dart';

// import '../../../core/base/view/base_view.dart';

// class DashboardView extends StatelessWidget {
//   const DashboardView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BaseView<HomeCubit>(
//       viewModel: HomeCubit(),
//       onModelReady: (model) {
//         model.setContext(context);
//         model.init();
//       },
//       onPageBuilder: (BuildContext context, HomeCubit value) {
//         return Scaffold(
//           body: ListView(
//             children: [
//               Padding(
//                 padding: context.paddingLow,
//                 child: Text(LocaleKeys.home_title.locale),
//               ),
//               Padding(
//                 padding: context.paddingLow,
//                 child: TextField(
//                   decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: LocaleKeys.home_search.locale),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
