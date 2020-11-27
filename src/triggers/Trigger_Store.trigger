trigger Trigger_Store on Store__c (after update, after insert) {
    
    if(Trigger.isAfter && Trigger.isUpdate) {
        List<Id> devices = new List<Id>();
        for(Store__c store : Trigger.new) {
            if(store.Quantity__c == 0) {
                devices.add(store.Device__c);
            }
        }
        
        List<Device__c> devicesToUpdate = [select Id, Available__c from Device__c where Id in :devices];
        for(Device__c device : devicesToUpdate) {
            device.Available__c = false;
        }
        
        List<Device__c> devicesToMakeAvailable = makeDeviceAvailable(Trigger.new);
        devicesToUpdate.addAll(devicesToMakeAvailable);
        update devicesToUpdate;
    }
    
    if(Trigger.isAfter && Trigger.isInsert) {
        List<Device__c> devicesToMakeAvailable = makeDeviceAvailable(Trigger.new);
        update devicesToMakeAvailable;
    }
    
    
    
    public List<Device__c> makeDeviceAvailable(List<Store__c> stores) {
        if(stores != null && !stores.isEmpty()) {
            List<Id> devices = new List<Id>();
            for (Store__c store : stores) {
                if(store.Quantity__c > 0) {
                    devices.add(store.Device__c);
                }
            }
            
            List<Device__c> devicesToMakeAvailable = [select Id, Available__c from Device__c where Id in :devices];
            for(Device__c device : devicesToMakeAvailable) {
                device.Available__c = true;
            }
            return devicesToMakeAvailable;
        }
        return null;
    }
}