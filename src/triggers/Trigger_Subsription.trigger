trigger Trigger_Subsription on Subscruption__c (after insert, before insert) {
    
    if(Trigger.isAfter && Trigger.isInsert) {
        Map<Id, Integer> subscriptionDevices = new Map<Id, Integer>();
        List<Id> devices = new List<Id>();
        for ( Subscruption__c sub : Trigger.new ) { 
            devices.add(sub.Device__c);
            if(!subscriptionDevices.containsKey(sub.Device__c)) {
                subscriptionDevices.put(sub.Device__c, 1);
            } else {
                subscriptionDevices.put(sub.Device__c, subscriptionDevices.get(sub.Device__c) + 1);
            }
        }
        
       List<Store__c> stores = [select Id, Device__c, Quantity__c from Store__c where Device__c in :devices ];
       for(Store__c store : stores) {
           store.Quantity__c = store.Quantity__c - subscriptionDevices.get(store.Device__c);
       }
       update stores;
    }
    
    
    
    if(Trigger.isBefore && Trigger.isInsert) {
        id[] idsOfSubscription = CommonUtil.getIdsOfSObject(Trigger.new);
        
        Id[] idsOfDevices = new Id[]{};
        
        for(Subscruption__c sub : Trigger.new) {
            idsOfDevices.add(sub.Device__c);
        }
        
        Map<Id, Device__c> devicesMap = new Map<Id, Device__c>([select Id, Available__c from Device__c where Id in: idsOfDevices]);
        Device__c device;
        
        for(Subscruption__c sub : Trigger.new) {
            device = devicesMap.get(sub.Device__c);
            
            if(!device.Available__c) {
                sub.Device__c.addError('No active device');
            }
        }
    }  
}