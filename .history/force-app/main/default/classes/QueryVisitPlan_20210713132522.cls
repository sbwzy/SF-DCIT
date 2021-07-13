/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-13-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-12-2021   robert   Initial Version
**/
public with sharing class QueryVisitPlan {
    
    public List<VisitPlan__c> visitPlanList{get; set;}    
    public VisitPlan__c visitPlan{get; set;} // 拜访计划
    public VisitPlan__c visitPlan2{get; set;}
    public String salesName {get; set;}	// 销售姓名
    
    //分页参数
    public Integer counter = 0;  //基于第一位的偏移量
    public static  Integer listSize = 5;//每页显示5条记录
    public Integer totalSize; //总记录数
    
    // 获取拜访计划
    public QueryVisitPlan() {
        totalSize = [SELECT count() FROM VisitPlan__c];
        visitPlanList = new List<VisitPlan__c>();
        visitPlan = new VisitPlan__c();
        visitPlan2 = new VisitPlan__c();
    }
    
    //变量 visitPlanList 的get方法，数据库查询
    public List<VisitPlan__c> getVisitPlans() {
        try {            
            visitPlanList = [SELECT Id, Owner.Name, Name, AccountName__c, DateOfVisit__c, VisitMethod__c, SalesName__c FROM VisitPlan__c limit 5 offset :counter];
            System.debug(visitPlanList);
            totalSize = visitPlanList.size();            
            return visitPlanList;
        } catch (Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
    }
    
    totalSize = 

    // 变量 Total_size 的get方法
    // 返回Total_size的值
    public Integer getTotalSize() {
        return totalSize;
    }
    
    // 变量 PageNumber 的get方法
    // 计算当前页码
    public Integer getPageNumber() {
        return counter/listSize + 1;
    }
    
    // 变量 TotalPages 的get方法
    // 计算总页数
    public Integer getTotalPages() {
        if (math.mod(totalSize, listSize )  > 0) {
            return totalSize/listSize + 1;
        } else {
            return (totalSize/listSize ) ;
        }
    }
    
    // 首页
    public PageReference first() {
        counter = 0;
        query();
        return null;
    }
    
    // 上一页
    public PageReference previous() {
        counter -= listSize ;
        if(counter < 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '已至最前'));
        }
        else{
            query();
        }
        return null;
    }
    
    // 下一页
    public PageReference next() {
        counter += listSize ;
        if(counter > totalSize){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '已至最后'));
        }
        else {
            query();
        }
        return null;
    }
    
    // 尾页
    public PageReference end() {
        counter = totalSize - math.mod(totalSize, listSize ) ;
        query();
        return null;
    }
    
    //数据查询
    public void query(){
        system.debug(salesName);
        system.debug(visitPlan.AccountName__c);
        system.debug(visitPlan.DateOfVisit__c);
        system.debug(visitPlan2.DateOfVisit__c);
        
        if( String.isBlank(salesName)&& visitPlan.AccountName__c == null && visitPlan.DateOfVisit__c == null && visitPlan2.DateOfVisit__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '检索条件不能为空'));            
            return;
        }       
        String sql = 'SELECT Id, Owner.Name, Name, AccountName__c, DateOfVisit__c, VisitMethod__c, SalesName__c FROM VisitPlan__c WHERE Id != null';
        //销售名查询        
        if(salesName.length() > 0){
            sql += ' and SalesName__c = '+'\''+salesName+'\'';
        }
        //客户名查询
        if(visitPlan.AccountName__c != null){
            sql += ' and AccountName__c = '+'\''+visitPlan.AccountName__c+'\'';
        }
        //拜访时间查询        
        if(visitPlan.DateOfVisit__c != null && visitPlan2.DateOfVisit__c != null){
            Date d1 = visitPlan.DateOfVisit__c;
            Date d2 = visitPlan2.DateOfVisit__c;
            sql +=  ' and DateOfVisit__c >= : d1 and DateOfVisit__c <= : d2';
            
        }
        System.debug(sql);
        sql += ' limit 5 offset :counter';
        visitPlanList = Database.query(sql);
        
    }     
}