/**
 * Clase de test ejercicio 4.1 (Task)
 * Cuando una tarea (Task) se cierra, Status = End, la fecha
 *  de la tarea (ActivityDate)  tendrá que volcarse al campo 
 *  Last_Activity_Date de la Cuenta principal (Parent) de (únicamente 
 * si esta fecha nueva fuese mayor a la existente en ese campo):
 *      La cuenta a la que está asociada la tarea (WhatId)
 *      La cuenta (Account) de la oportunidad a la que está asociada la tarea (WhatId)
 *      Si la cuenta no tiene cuenta principal (Parent) no ocurrirá nada.
 */
@isTest
public with sharing class ej4_1_DateAccOppTest {
    
    public static Task mockAccount(){
        Account parentAcct = new Account(Name = 'Parent Account');
        insert parentAcct;

        Account childAcct = new Account (Name = 'Child Account', ParentId = parentAcct.Id);
        insert childAcct;

        Task task = new Task(Subject = 'Other',  WhatId = childAcct.Id, ActivityDate = Date.today().addDays(10));
        return task;
    }

    /*public static Task mockOpportunity(){
        Account parentAcct = new Account(Name = 'Parent Account');
        insert parentAcct;

        Account childAcct = new Account (Name = 'Child Account', ParentId = parentAcct.Id);
        insert childAcct;

        Opportunity opp = new Opportunity (Name='Opp Test', AccountId = childAcct.Id, StageName = 'Prospecting', CloseDate = Date.today());

        Task task = new Task(Subject = 'Call',  WhatId = opp.Id, ActivityDate = Date.today().addDays(10));
        return task;
    }*/

    @isTest static void TestTaskDateAccount(){
        Task task = ej4_1_DateAccOppTest.mockAccount();
        insert task;
        task.Status = 'Completed';

        Test.startTest();
        upsert task;
        Test.stopTest();

        Account acct = [SELECT Id, Name, Last_Activity_Date__c from Account WHERE Name = 'Parent Account' LIMIT 1];
        System.assertEquals(Date.today().addDays(10), acct.Last_Activity_Date__c);

    }

    /*
    @isTest static void TestTaskDateOpportunity(){
        Task task2 = ej4_1_DateAccOppTest.mockOpportunity();
        insert task2;
        task2.Status = 'Completed';

        Test.startTest();
        upsert; task2;
        Test.stopTest();

        Account acct = [SELECT Id, Name, Last_Activity_Date__c from Account WHERE Name = 'Parent Account' LIMIT 1];
        System.assertEquals(Date.today().addDays(10), acct.Last_Activity_Date__c);
    }*/
}
