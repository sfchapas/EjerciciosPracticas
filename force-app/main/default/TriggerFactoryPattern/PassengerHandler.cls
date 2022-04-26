/**
* @author       Santiago Fernandez Morillas
* @date         
*               Implements the ITrigger interface to help ensure the trigger code is bulkified and all in one place.
*/
public with sharing class PassengerHandler implements ITrigger{

    // Var declaration
        List<Contact> contactsWithNifs  = new List<Contact>();
    // Constant declaration

    // Builder

    // Handler before methods

    /**
    * This method is called prior to execution of a BEFORE trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
    * Se usa para sacar datos del mismo objeto, el var es para objetos relacionados
    */
    public void bulkBefore() {
        contactsWithNifs = [SELECT Id, NIF__c FROM Contact WHERE NIF__c != null AND NIF__c != ''];
    }

    public void beforeInsert(SObject sObj) {
        Passenger__c passenger = (Passenger__c) sObj;

        //Comprobar antes que el passenger tiene nif
        if(passenger.ID_Card__c!=null){
            if(!Utils.validarNIF(passenger.ID_Card__c)){
                passenger.addError(passenger.ID_Card__c +' Invalid NIF (ID Card)');
            }
        }
        

        if(passenger.Contact__c == null || passenger.Contact__c == ''){
            for (Contact ctc : contactsWithNifs) {
                if(passenger.ID_Card__c == ctc.NIF__c){
                    passenger.Contact__c = ctc.Id;
                }
            }
        }
    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {
        Passenger__c passenger = (Passenger__c) sObj;

        if(passenger.ID_Card__c!=null){
            if(!Utils.validarNIF(passenger.ID_Card__c)){
                passenger.addError(passenger.ID_Card__c +' Invalid NIF (ID Card)');
            }
        }

        if(passenger.Contact__c == null || passenger.Contact__c == ''){
            for (Contact ctc : contactsWithNifs) {
                if(passenger.ID_Card__c == ctc.NIF__c){
                    passenger.Contact__c = ctc.Id;
                }
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

    }

    // Other methods
    
}