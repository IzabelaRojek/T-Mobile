public with sharing class MyDevices_controller {

    @AuraEnabled //ta funkcja oże być zawołana przez lightning
    public static List<Device__c> takeSimpleValue() {
    List<Device__c> devices = [select Id, Available__c, Name from Device__c where OwnerId =: UserInfo.getUserId()];
    return devices;
    }
}

