
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/country_list_model.dart';
import '../../state/countr_list_state/country_list_notifier.dart';
import '../../state/countr_list_state/country_list_state.dart';
import '../widget/country_list_view.dart';
import '../widget/error_widget.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final countryNotifierProvider =
      NotifierProvider<CountryListNotifier, CountryListState>(() {
    return CountryListNotifier();
  });
  CountryListNotifier? countryListNotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      countryListNotifier?.getCountryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    countryListNotifier = ref.read(countryNotifierProvider.notifier);
    final countryListState = ref.watch(countryNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Country List'),
      ),
      body: switch (countryListState) {
        CountryListLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        CountryListSuccess(countryList: List<CountryListModel> countryList) =>
          CountryListView(
            countryList: countryList,
          ),
        // TODO: Handle this case.
        CountryListFailed(errorMessage: String errorMessage) => FailedWidget(
            errorMessage: errorMessage,
            tryAgain: () {
              countryListNotifier?.getCountryList();
            },
          ),
      },
    );
  }
}
