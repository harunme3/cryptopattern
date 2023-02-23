// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, unused_field, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:crypto/affiliateconfig33.dart';
import 'package:crypto/affiliatetree33.dart';
import 'package:crypto/toastdata.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AffiliateReward33 extends StatefulWidget {
  AffiliateReward33({
    Key? key,
  }) : super(key: key);

  @override
  State<AffiliateReward33> createState() => _AffiliateReward33State();
}

class _AffiliateReward33State extends State<AffiliateReward33>
    with SingleTickerProviderStateMixin {
  var l = Logger();

  bool _isfetching = false;
  bool _isfetchingaffiliate = false;
  final TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: Theme.of(context).iconTheme.size,
          ),
        ),
        title: Text(
          'Your Affiliates Pattern',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _address,
                  decoration: InputDecoration(
                    hintText: "Enter Your Address",
                    labelText: "Enter Your Address",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Apply corner radius
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: SizedBox(
                  width: width * 0.60,
                  height: width * 0.14,
                  child: ElevatedButton(
                    autofocus: false,
                    onPressed: () async {
                      if (_address.text.isEmpty) {
                        ToastData.showToast(context, "Please Enter Address");
                        return;
                      }

                      setState(() {
                        _isfetchingaffiliate = true;
                      });

                      var response = await AffiliateConfig33.getreferraldata(
                          "0x6E546c4c2728D337d0acaDb9841Cfe569BeB8100");
                      l.w(response);

                      if (response["edges"].length != 0) {
                        setState(() {
                          _isfetchingaffiliate = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AffiliateTree33(
                                      json: response,
                                      storejson: response,
                                    )));
                      } else {
                        setState(() {
                          _isfetchingaffiliate = false;
                        });
                      }
                    },
                    child: _isfetchingaffiliate
                        ? Text(
                            'loading',
                          )
                        : Text(
                            'Affiliate Patterns',
                          ),
                    style: ButtonStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
