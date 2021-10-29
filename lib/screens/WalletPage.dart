import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.black),
    elevation: MaterialStateProperty.all(4),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('CHOOSE WALLET')),
      body: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: false,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          TextButton(
            style: buttonStyle,
            onPressed: () async {
              // try {
              //   ESewaConfiguration _configuration = ESewaConfiguration(
              //       clientID: "<Client-ID>",
              //       secretKey: "<Secret-Key>",
              //       environment:
              //           ESewaConfiguration.ENVIRONMENT_TEST //ENVIRONMENT_LIVE
              //       );

              //   ESewaPnp _eSewaPnp = ESewaPnp(configuration: _configuration);
              //   ESewaPayment _payment = ESewaPayment(
              //       amount: 1200,
              //       productName: "<Product-Name>",
              //       productID: "<Unique-Product-ID>",
              //       callBackURL: "<Call-Back-URL>");
              //   final _res = await _eSewaPnp.initPayment(payment: _payment);
              //   // Handle success
              // } catch (e) {
              //   print(e.toString());
              // }
            },
            child: Container(
              child: Image(
                image: AssetImage("assets/icons/eSewa.png"),
                colorBlendMode: BlendMode.srcIn,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            style: buttonStyle,
            onPressed: () {
              // try {
              //   FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
              //     publicKey: "test_public_key_dc74e0fd57cb46cd93832aee0a390234",
              //     urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
              //     paymentPreferences: [
              //       KhaltiPaymentPreference.KHALTI,
              //     ],
              //   );

              //   KhaltiProduct product = KhaltiProduct(
              //     id: "test",
              //     amount: 1000,
              //     name: "Hello Product",
              //   );

              //   _flutterKhalti.startPayment(
              //     product: product,
              //     onSuccess: (data) {
              //       print("Success message here");
              //     },
              //     onFaliure: (error) {
              //       print("Error message here");
              //     },
              //   );
              // } catch (e) {
              //   print("error");
              //   print(e.toString());
              // }
            },
            child: Container(
              child: Image(
                image: AssetImage("assets/icons/khalti.png"),
                colorBlendMode: BlendMode.srcIn,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
