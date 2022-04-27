/**
* @author       Santiago Fernandez Morillas
* @date         
*               Implements the ITrigger interface to help ensure the trigger code is bulkified and all in one place.
*/
public with sharing class TaskHandler implements ITrigger{

    // Var declaration
    List<Account> accts = new List<Account>();
    Map<Id,Task> taskMap;
    // Constant declaration

    // Builder

    // Handler before methods

    /**
    * This method is called prior to execution of a BEFORE trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
    */
    public void bulkBefore() {
        //consulta con typeof para coger el objeto relacionado con whatid
        taskMap = new Map<Id,Task>([SELECT TYPEOF what 
                        WHEN Account THEN Id, Name, ParentId, Last_Activity_Date__c, Parent.Last_Activity_Date__c
                        WHEN Opportunity THEN Id, Name, Account.ParentId, Account.Last_Activity_Date__c, Account.Parent.Last_Activity_Date__c
                    END
                    FROM Task where Id in :Trigger.new]);
    }

    public void beforeInsert(SObject sObj) {

    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {
        Task oldTask = (Task) oldSobj;
        Task newTask = (Task) sObj;

        //Comprobamos si se ha cerrado el task
        if (newTask.Status == 'Completed' && oldTask.Status != 'Completed') {
            Account acct;

            //Si el whatid es una instancia de ciemta la asignamos a acct
            if (taskMap.get(newTask.Id).What instanceof Account) {
                acct = (Account)taskMap.get(newTask.Id).What;
            }

            //Si el whatid es una instancia de opportunity, cogemos la oportunidad
            //y la cuenta es la de la oportunidad
            if (taskMap.get(newTask.Id).What instanceof Opportunity) {
                Opportunity opp = (Opportunity)taskMap.get(newTask.Id).What;
                acct = opp.Account;
            }

            //Si la cuenta tiene cuenta padre
            if (acct.ParentId != null) {
                Account parentAcct = acct.Parent;
                if (parentAcct.Last_Activity_Date__c < newTask.ActivityDate && parentAcct.Last_Activity_Date__c != null){
                    parentAcct.Last_Activity_Date__c = newTask.ActivityDate;
                } else {
                    parentAcct.Last_Activity_Date__c = newTask.ActivityDate;
                }
                accts.add(parentAcct);
            }


        }

    }

    public void beforeDelete(SObject sObj) {

    }

    // Handler after methods

    public void bulkAfter() {

    }

    public void afterInsert(SObject sObj) {
        
    }

    public void afterUpdate(SObject oldSobj, SObject sObj) {
        
    }

    public void afterDelete(SObject sObj) {

    }

    /**
    * This method is called once all records have been processed by the trigger.
    * Use this method to accomplish any final operations such as creation or updates of other records.
    */
    public void andFinally() {
        if (accts.size()>0) {
            upsert accts;
        }
    }

    // Other methods
    
}