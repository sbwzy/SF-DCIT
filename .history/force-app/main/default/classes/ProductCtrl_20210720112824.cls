/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-20-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-20-2021   robert   Initial Version
**/
public with sharing class ProductCtrl {
    @AuraEnabled
    public static string findProductByName(){
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string methodName(){
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
