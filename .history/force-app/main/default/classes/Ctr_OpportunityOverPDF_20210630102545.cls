public without sharing class Ctr_OpportunityOverPDF {
    //商机
    public Opportunity opportunityRecord{get;set;}
    //商机产品列表
    public List<OpportunityLineItem> opportunityItemList{get;set;}
    //当前页面信息
    Private String oppId;

    public Ctr_OpportunityOverPDF(ApexPages.StandardController controller){
        oppId = Apexpages.currentPage().getParameters().get('id');
        //获取商机相关记录
        getOpportunityRecords(oppId);
        //获取商机产品相关记录
        getOpportunityItemRecords(oppId);
    }

    public void getOpportunityRecords(String oppId){
        opportunityRecord = [SELECT Id
                                    , Name  //名称
                                    , Account.Name //客户名称
                                    , Type //类型
                                    , StageName //阶段
                                    FROM Opportunity
                                    WHERE Id =: oppId];
    }

    public void getOpportunityItemRecords(String oppId){
        opportunityItemList = [SELECT Id
                                        , Product2Id //产品ID
                                        , productCode //产品编码
                                        , Product2.Name //产品名称
                                        , Quantity //数量
                                        , UnitPrice //金额
                                        , Name //名称
                                        , TotalPrice //总价
                                        FROM OpportunityLineItem
                                        WHERE OpportunityId =: oppId];
    }
}