import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {

    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout(){
    var options = {
      "key" : "rzp_test_Anl21w49o471Nj",
      "amount" : num.parse(textEditingController.text)*100,
      "name" : "HSMS APP",
      "description" : "Society Maintenance",
      "prefill" : {
        "contact" : "9876543210",
        "email" : "test123@gmail.com"
      },
      "external" : {
        "wallets" : ["Paytm"]
      }
    };

    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }
  }
  void handlerPaymentSuccess(){
    print("Payment successful!");

  }

  void handlerPaymentError(){
    print("Payment unsuccessful!");
  }

  void handlerExternalWallet(){
    print("External Wallet");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Razor Pay")
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                hintText: "Enter the amount to pay"
            ),


          ),
           Padding(
             padding: const EdgeInsets.all(30.0),
             child: SizedBox(height: 12,),
           ),
          RaisedButton(
            color: Colors.blue,
            child: Text("Pay Now", style: TextStyle(color: Colors.white),),
            onPressed: (){
              openCheckout();

            },
          )

        ],
      ),
    );
  }
}

