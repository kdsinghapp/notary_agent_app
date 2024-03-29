

import 'package:flutter/material.dart';

popShowAccordingNotification(BuildContext context, String type) async{
   String title='',body='';
   switch(type){
      case 'CANCEL_BY_USER':{
         title='Booking status';
         body='Client has cancel booking';
      }break;
      case 'PAYMENT_DONE':{
         title='Booking status';
         body='Client has complete booking payment';
      }break;

   }

   showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
         ),
         title: Center(child: Text(title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
         content:SizedBox(
            height: 120,
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
             children: [
                ClipRRect(
                   borderRadius:
                   BorderRadius.circular(40.0),
                   child:Image.asset('assets/images/profile.png',height: 63, width: 63, fit: BoxFit.contain,),
                ),
               const SizedBox(height: 5,),
               Text(body,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),
               textAlign: TextAlign.center,),
             ],
           ),
         ),
         actions: <Widget>[
            Center(
              child: TextButton(
                 onPressed: () {
                    Navigator.of(ctx).pop();
                 },
                 child:const Text("Ok",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.indigo),
                 ),
              ),
            ),
         ],
      ),
   );
}