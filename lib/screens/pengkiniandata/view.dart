import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/logic.dart';
import 'package:jmcare/screens/pengkiniandata/widgets/container_menu.dart';

class PengkiniandataScreen extends StatelessWidget {
  const PengkiniandataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final logic = Get.put(PengkiniandataLogic());
    final state = Get.find<PengkiniandataLogic>().state;

    return JmcareBarScreen(
      title: 'Menu Pengkinian Data',
      body: SingleChildScrollView(
        padding: const EdgeInsetsGeometry.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var item in state.menu_pengkinian_data)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: InkWell(
                  onTap: () {
                    String? route = item['route'];
                    if (route != null && route.isNotEmpty) {
                      Get.toNamed(route);
                    } else {
                      print("Route belum didefinisikan untuk menu ini");
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: ContainerMenu(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.withOpacity(0.32)),
                        child: Center(
                          child: FaIcon(
                            item['icon'],
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              item['description'],
                              style: textTheme.bodyMedium,
                              softWrap: true,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
                ),
              )
          ],
        ),
      ),
    );
  }
}
