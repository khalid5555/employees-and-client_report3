import 'package:employed_target/controllers/employee_controller.dart';
import 'package:employed_target/model/employee_model.dart';
import 'package:employed_target/shared/utils/app_colors.dart';
import 'package:employed_target/shared/utils/show_loding.dart';
import 'package:employed_target/shared/widgets/app_text.dart';
import 'package:employed_target/shared/widgets/cardview.dart';
import 'package:employed_target/ui/manager_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientSearchDelegate extends SearchDelegate {
  final ClientController clientController = Get.find<ClientController>();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        color: AppColors.kreColor,
        icon: const Icon(Icons.clear),
        onPressed: () {
          printInfo(info: 'xxx');
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      color: AppColors.loginBg,
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String isAdmin = clientController.box.read('email') ?? '';
    final searchAdmin = isAdmin == 'mmmmmmmmm'
        ? clientController.clients
        : clientController.filteredCustomers;
    //  'mmmmmmmmmmm'
    final List<Client> searchResults = searchAdmin
        .where((client) =>
            client.name!.toLowerCase().contains(query.toLowerCase()) ||
            client.phone!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return searchAdmin.isNotEmpty && query.isNotEmpty
        ? Column(
            children: [
              App_Text(
                data: ' عدد النتائج   ${searchResults.length}',
                size: 18,
              ),
              Expanded(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final client = searchResults[index];
                  return CardView(
                    client: client,
                    onDelete: () {
                      // Delete the client
                      clientController.deleteClient(client.id!);
                    },
                    onEdit: () {
                      // Delete the client
                      showDialog(
                        context: context,
                        builder: (_) => EditClientDialog(client: client),
                      );
                    },
                  );
                },
              )),
            ],
          )
        : const ShowLoading(show: true);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final List<ProductModel> searchResults = controller.product_list
    //     .where((product) =>
    //         product.pName!.toLowerCase().contains(query.toLowerCase()))
    //     .toList();
    return query == '' ? const ShowLoading(show: true) : const SizedBox();
  }
}
