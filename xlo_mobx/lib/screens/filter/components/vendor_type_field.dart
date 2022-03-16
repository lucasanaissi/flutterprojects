import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  const VendorTypeField({Key? key, required this.filter}) : super(key: key);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Tipo de anunciante'),
          const SizedBox(height: 10),
          Observer(builder: (_) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (filter.isTypeParticular) {
                      if(filter.isTypeProfessional) {
                        filter.resetVendorType(VENDOR_TYPE_PARTICULAR);
                      } else {
                        filter.selectVendorType(VENDOR_TYPE_PROFESSIONAL);
                      }
                    } else {
                      filter.setVendorType(VENDOR_TYPE_PARTICULAR);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: 125,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: filter.isTypeParticular
                          ? Colors.deepPurple
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: filter.isTypeParticular
                            ? Colors.deepPurple
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      'Particular',
                      style: TextStyle(
                        color: filter.isTypeParticular
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (filter.isTypeProfessional) {
                      if(filter.isTypeParticular) {
                        filter.resetVendorType(VENDOR_TYPE_PROFESSIONAL);
                      } else {
                        filter.selectVendorType(VENDOR_TYPE_PARTICULAR);
                      }
                    } else {
                      filter.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: filter.isTypeProfessional
                          ? Colors.deepPurple
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: filter.isTypeProfessional
                            ? Colors.deepPurple
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      'Profissional',
                      style: TextStyle(
                        color: filter.isTypeProfessional
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
