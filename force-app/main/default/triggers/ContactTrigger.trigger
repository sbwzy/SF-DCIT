/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
 * @last modified by  : robert
**/
trigger ContactTrigger on Contact (before insert, after insert, before update, after update) {
    new ContactTriggerHandler().run();
}