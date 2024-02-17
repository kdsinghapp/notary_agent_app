
import 'package:notary_agent_app/import.dart';

class LiveChat extends StatefulWidget{
  const LiveChat({super.key});

  @override
  State<LiveChat> createState()=>_LiveChatState();


}
class _LiveChatState extends State<LiveChat> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Live Chat"),
      body: Column(
        children: [
          const SizedBox(height: 120,),
          Container(
            height: 50,
            alignment: Alignment.center,
            margin:const  EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrangeAccent,width: 1,),
              borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
            child: const Text('Live Chat',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color:Colors.deepOrangeAccent ),
            textAlign: TextAlign.center,) ,
          )
        ],
      )
    );
  }
}
