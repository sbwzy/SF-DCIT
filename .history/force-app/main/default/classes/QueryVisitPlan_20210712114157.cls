/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-12-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-12-2021   robert   Initial Version
**/
public with sharing class QueryVisitPlan {
    
    public List<VisitPlan__c> VisitPlanList{get; set;}
    
    public VisitPlan__c visitPlan{get; set;}			// 拜访计划
    public VisitPlan__c visitPlan2{get; set;}			
    public String salesName {get; set;}					// 销售姓名
    
    
    //分页参数
    public Integer counter = 0;  //偏移量
    public static  Integer LIST_SIZE = 5;//每页显示记录数
    public Integer total_size; //总记录数
    
    // 获取拜访计划
    public QueryVisitPlan() {
        total_size = [SELECT count() FROM VisitPlan__c];
        VisitPlanList = getVisitPlans();
        visitPlan = new VisitPlan__c();
        visitPlan2 = new VisitPlan__c();
    }
    
    //变量 VisitPlanList 的get方法
    public List<VisitPlan__c> getVisitPlans() {
        try {
            
            VisitPlanList = [SELECT Id, Owner.Name, Name, AccountName__c, DateOfVisit__c, VisitMethod__c, SalesName__c FROM VisitPlan__c limit :LIST_SIZE  offset :counter];// limit x,y
            
            System.debug(VisitPlanList);
            
            return VisitPlanList;
        } catch (Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
    }
    
    // 变量 Total_size 的get方法
    // 返回Total_size的值
    public Integer getTotal_size() {
        return total_size;
    }
    
    // 变量 PageNumber 的get方法
    // 计算当前页码
    public Integer getPageNumber() {
        return counter/LIST_SIZE   + 1;
    }
    
    // 变量 TotalPages 的get方法
    // 计算总页数
    public Integer getTotalPages() {
        if (math.mod(total_size, LIST_SIZE )  > 0) {
            return total_size/LIST_SIZE   + 1;
        } else {
            return (total_size/LIST_SIZE ) ;
        }
    }
    
    // 首页
    public PageReference First() {
        counter = 0;
        return null;
    }
    
    // 上一页
    public PageReference Previous() {
        counter -= LIST_SIZE ;
        return null;
    }
    
    // 下一页
    public PageReference Next() {
        counter += LIST_SIZE ;
        return null;
    }
    
    // 尾页
    public PageReference End() {
        counter = total_size - math.mod(total_size, LIST_SIZE ) ;
        return null;
    }
    
    
    
    
    
    
    public void Query(){
        if(salesName == null && visitPlan.AccountName__c == null && visitPlan.DateOfVisit__c == null && visitPlan2.DateOfVisit__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '检索条件不能为空'));
            return;
        }
        
        String sql = 'SELECT Id, Owner.Name, Name, AccountName__c, DateOfVisit__c, VisitMethod__c, SalesName__c FROM VisitPlan__c WHERE Id != null';
        
        
        if(salesName.length() > 0){
            sql += ' and SalesName__c = '+'\''+salesName+'\'';
        }
        
        if(visitPlan.AccountName__c != null){
            sql += ' and AccountName__c = '+'\''+visitPlan.AccountName__c+'\'';
        }
        
        
        if(visitPlan.DateOfVisit__c != null && visitPlan2.DateOfVisit__c != null){
            Date d1 = visitPlan.DateOfVisit__c;
            Date d2 = visitPlan2.DateOfVisit__c;
            sql +=  ' and DateOfVisit__c >= : d1 and DateOfVisit__c <= : d2';
            System.debug(sql);
        }
        
        VisitPlanList = Database.query(sql);
    }
    
    
}