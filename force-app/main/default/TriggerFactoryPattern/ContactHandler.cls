/**
* @author       Santiago Fernandez Morillas
* @date         
*               Implements the ITrigger interface to help ensure the trigger code is bulkified and all in one place.
*/
public with sharing class ContactHandler implements ITrigger{

    // Var declaration

    // Constant declaration

    // Builder

    // Handler before methods

    /**
    * This method is called prior to execution of a BEFORE trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
    */
    public void bulkBefore() {

    }

    public void beforeInsert(SObject sObj) {
        Contact contact = (Contact) sObj;
        if (contact.NIF__c != null) {
            if(!Utils.validarNIF(contact.NIF__c)){
                contact.addError(contact.NIF__c +' Invalid NIF (ID Card)');
            }
        }   
    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {
        Contact contact = (Contact) sObj;
        if (contact.NIF__c != null) {
            if(!Utils.validarNIF(contact.NIF__c)){
                contact.addError(contact.NIF__c +' Invalid NIF (ID Card)');
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