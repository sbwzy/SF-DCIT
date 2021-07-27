/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-27-2021
 * @last modified by  : robert
**/
public static Product2 duplicateCheck(String objectApiName,List<sObject> newList,List<sObject> oldList){
    Map<String,Schema.SObjectType> allSObjectTypeDescribes = Schema.getGlobalDescribe();
    Schema.SObjectType studentType = allSObjectTypeDescribes.get(objectApiName);
    Set<String> fields = studentType.getDescribe().fields.getMap().keySet();//对象的所有字段API
    
    //移除掉系统默认字段 Id、编号、时间不能有
    for(String str :fields)if(!str.contains('ProductCode'))fields.remove(str);
    
    Map<String,sObject> newMap = new Map<String,sObject>();
    Map<String,sObject> oldMap = new Map<String,sObject>();
    
    for(sObject obj :newList){
        String strFields = '';
        for(String field : fields){
            strFields+=obj.get(field);
        }
        newMap.put(strFields,obj);
    }
    
    for(sObject obj :oldList){
        String strFields = '';
        for(String field : fields){
            strFields+=obj.get(field);
        }
        oldMap.put(strFields,obj);
    }
    
    for(String str : newMap.Keyset())if(oldMap.get(str)!=null)return newMap.get(str);//返回重复的对象
    return null;
}
