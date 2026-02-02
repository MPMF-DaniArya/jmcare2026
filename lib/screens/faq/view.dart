import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/faq/logic.dart';
import 'package:jmcare/screens/faq/state.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FaqLogic logic = Get.put(FaqLogic());
    final FaqState state = Get.find<FaqLogic>().state;

    return GetBuilder<FaqLogic>(
      assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "FAQ",
            body: Obx(
                () => logic.is_loading.value
                    ? Komponen.getLoadingWidget()
                    : RefreshIndicator(
                        child: Column(
                          children: [
                            // Komponen.pullDowntoRefresh(),
                            Row(
                              children: [
                                Expanded(child:
                                  TextField(
                                    decoration: const InputDecoration(
                                        hintText: "Pencarian pertanyaan"
                                    ),
                                    controller: state.tecSearch,
                                  )),
                                  IconButton(
                                      onPressed: (){
                                        logic.filterFAQ();
                                      },
                                      icon: const Icon(Icons.search)
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        logic.allFAQ();
                                      },
                                      icon: const Icon(Icons.close)
                                  ),
                              ],
                            ),
                            logic.jmlRow.value == 0
                                ? const Padding(padding: EdgeInsets.all(20), child: Text("Tidak ada data"))
                                : Expanded(child:
                                  ListView.builder(
                                      itemCount: logic.jmlRow.value,
                                      itemBuilder: (context, index){
                                        return ExpansionTile(
                                          title: logic.obsIsSearch.value == false
                                              ? Text(logic.obsFaqRespon.value.data![index].pertanyaan!, style: TextStyle(color: Colors.black),)
                                              : TextHighlight(
                                                  text: logic.obsFaqRespon.value.data![index].pertanyaan!,
                                                  words: state.words
                                                ),
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                                child: HtmlWidget(logic.obsFaqRespon.value.data![index].jawaban!)
                                            )
                                          ],
                                        );
                                      }
                                  ))
                          ],
                        ),
                        onRefresh: () async {
                          logic.allFAQ();
                        }
                )
            )
          );
        }
    );
  }
}
