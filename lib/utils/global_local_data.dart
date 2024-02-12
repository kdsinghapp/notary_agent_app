
class GlobalLocalData{
    static String requestId='';

    static String getRequestId(){
      return requestId;
    }

    static void setRequestId(String id){
        requestId=id;
    }
}