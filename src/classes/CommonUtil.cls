public class CommonUtil {
	
    public static Id[] getIdsOfSObject(sObject[] objects) {
        Id[] ids = new Id[]{};
            for(sObject so : objects) {
                ids.add(so.Id);
            }
        return ids;
    }
}