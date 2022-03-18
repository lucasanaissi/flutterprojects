import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/ad.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    if(ad.status == AdStatus.PENDING) {
      return Container();
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.deepOrange),
                  icon: const Icon(
                    Icons.chat_outlined,
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Chat',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              !ad.hidePhone
                  ? SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.deepOrange),
                          ),
                          primary: Colors.white,
                        ),
                        icon: const Icon(
                          Icons.phone_outlined,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () {
                          final phone =
                              ad.user!.phone!.replaceAll(RegExp('[^0-9]'), '');
                          launch('tel: $phone');
                        },
                        label: const Text(
                          'Ligar',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(height: 12),
          Divider(
            height: 0.1,
            thickness: 1,
            color: Colors.grey[200],
          ),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: Text(
              '${ad.user!.name!.toLowerCase()} (anunciante)',
            ),
          ),
          Divider(
            height: 0.1,
            thickness: 1,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
