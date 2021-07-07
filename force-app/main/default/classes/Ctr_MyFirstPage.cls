public with sharing class Ctr_MyFirstPage {
    //客户信息
    public List<Account> accList{get;set;}
    public Ctr_MyFirstPage(){
        //获得商机相关记录
        accList = getAccountList();
    }

    /**
     * @param
     * @Description 获取客户相关信息
     */
    public static List<Account> getAccountList(){
        List<Account> accList = [SELECT Id
                                ,Name //产品ID
                                ,Phone //电话
                                ,Type //类型
                                FROM Account
                                LIMIT 10];
        return accList;
    }
}