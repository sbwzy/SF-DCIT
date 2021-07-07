/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-06-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-06-2021   robert   Initial Version
**/
public with sharing class OppPageController {
    
    //分页参数
    public Integer counter = 0;  //偏移量
    public static  Integer LIST_SIZE = 5;//每页显示记录数
    public Integer total_size; //总记录数
    
    public Integer flag = 0 ; //设置标签
    
    public List<VisitPlan__c> VisitPlans{get;set;}

    
    public VisitPlan__c visitPlan{get; set;}			// 拜访计划
    public VisitPlan__c visitPlan2{get; set;}			
    public String SalesName {get; set;}					// 销售姓名
    
    public OppPageController() {
        total_size = [select count() from VisitPlan__c];
        visitPlan = new VisitPlan__c();
        visitPlan2 = new VisitPlan__c();
        getNullVisitPlans();
    }
    
   
    //变量 VisitPlans 的get方法
    public List<VisitPlan__c> getNullVisitPlans() {
        try {
            VisitPlans = [SELECT Id, Owner.Name, Name, AccountName__c, DateOfVisit__c, VisitMethod__c, SalesName__c FROM VisitPlan__c limit :LIST_SIZE  offset :counter];
            return VisitPlans;
        } catch (Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
    }
    
    
    //变量 DisablePrevious 的get方法
    //控制上一页按钮是否可点击
    public Boolean getDisablePrevious() {
        if (counter>0)
            return false;
        else
            return true;
    }
    
    //变量 DisableNext 的get方法
    //控制下一页按钮是否可点击
    public Boolean getDisableNext() {
        if (counter + LIST_SIZE   < total_size)
            return false;
        else
            return true;
    }
    
    //变量 Total_size 的get方法
    //返回Total_size的值
    public Integer getTotal_size() {
        return total_size;
    }
    
    //变量 PageNumber 的get方法
    //计算当前页码
    public Integer getPageNumber() {
        return counter/LIST_SIZE   + 1;
    }
    
    //变量 TotalPages 的get方法
    //计算总页数
    public Integer getTotalPages() {
        if (math.mod(total_size, LIST_SIZE )  > 0) {
            return total_size/LIST_SIZE   + 1;
        } else {
            return (total_size/LIST_SIZE ) ;
        }
    }
    
    //首页
    public void First() {
        counter = 0;
        if(flag==0){
           getNullVisitPlans();
        }else{
            Query();
        }
    }
    
    //上一页
    public void Previous() {
        counter -= LIST_SIZE ;
        if(flag==0){
           getNullVisitPlans();
        }else{
            Query();
        }
    }
    
    //下一页
    public void Next() {
        counter += LIST_SIZE ;
        if(flag==0){
           getNullVisitPlans();
        }else{
            Query();
        }
    }
    
    //尾页
    public void End() {
        counter = total_size - math.mod(total_size, LIST_SIZE ) ;
        if(flag==0){
           getNullVisitPlans();
        }else{
            Query();
        }
    }
    
    
    public void clear(){
        SalesName = null;
        visitPlan.AccountName__c = null;
        visitPlan.DateOfVisit__c = null ;
        visitPlan2.DateOfVisit__c =null;
    }
    
    public void Query(){
        if(SalesName.length() <= 0 && visitPlan.AccountName__c == null && visitPlan.DateOfVisit__c == null && visitPlan2.DateOfVisit__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '检索条件不能为空'));
            
            
            System.debug('----------------------------');
            return;
        }
        flag=1;
        String sql = 'SELECT Id, Owner.Name, Name, AccountName__c, DateOfVisit__c, VisitMethod__c, SalesName__c FROM VisitPlan__c WHERE Id != null';
        
        
        if(SalesName.length() > 0){
            sql += ' and SalesName__c = '+'\''+SalesName+'\'';
        }
        
        if(visitPlan.AccountName__c != null){
            sql += ' and AccountName__c = '+'\''+visitPlan.AccountName__c+'\'';
        }
        
        
        if(visitPlan.DateOfVisit__c != null && visitPlan2.DateOfVisit__c != null){
            Date d1 = visitPlan.DateOfVisit__c;
            Date d2 = visitPlan2.DateOfVisit__c;
            sql +=  ' and DateOfVisit__c >= : d1 and DateOfVisit__c <= : d2';
        }
        sql += ' limit '+LIST_SIZE;
        sql += ' offset '+counter;
        //System.debug('分页： '+sql);
   		//visitPlans.clear();
        System.debug('-------'+VisitPlans);
        VisitPlans = (List<VisitPlan__c>)Database.query(sql);
        total_size = VisitPlans.size() + 1;
        System.debug(VisitPlans);
    }
}