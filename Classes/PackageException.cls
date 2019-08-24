/**************************************************************************************************************************
 * @ClassName : PackageException
 * @Author : Ashish Ranjan
 * @Date: 24/08/2019
 * @Description : PackageException class for Lightning Componenet Error Handling and debug log generation
 * *************************************************************************************************************************/
 
public class PackageException extends Exception {
    
    public static Model.ActionResult handleException(Exception exc) {
        Model.ActionResult actionResultObject = new Model.ActionResult();
        try{
            actionResultObject.Message = new Map<String, Object>();
            actionResultObject.Message.put('Message', exc.getMessage());
            actionResultObject.Message.put('LineNumber', exc.getLineNumber());
            actionResultObject.Message.put('Cause', exc.getCause());
            actionResultObject.Message.put('StackTraceString', exc.getStackTraceString());
            actionResultObject.Message.put('TypeName', exc.getTypeName());
            actionResultObject.Message.put('OrgID', UserInfo.getOrganizationId());
            actionResultObject.Message.put('OrgName', UserInfo.getOrganizationName());
            actionResultObject.Message.put('UserID', UserInfo.getUserId());
            actionResultObject.Message.put('UserName', UserInfo.getName());
            actionResultObject.IsSuccess = false;
            
            String stackTrace = exc.getStackTraceString().substringBefore('\n');
            String className = stackTrace.substringAfter('.').substringBefore('.');
            
            // insert exception in Exception record
            Package_Exception__c pec = new Package_Exception__c();
            pec.Stack_Trace__c = exc.getStackTraceString();
            pec.Class_Name__c = className;
            pec.Cause__c = String.valueOf(exc.getCause());
            pec.Error_Message__c = exc.getMessage();
            pec.Line_Number__c = exc.getLineNumber();
            Database.insert(pec);
            
        }Catch(Exception ex){
            actionResultObject.IsSuccess = false;
            actionResultObject.Message = new Map<String, Object>();
            actionResultObject.Message.put('Message', ex.getMessage());
            actionResultObject.Message.put('LineNumber', ex.getLineNumber());
            actionResultObject.Message.put('Cause', ex.getCause());
            actionResultObject.Message.put('StackTraceString', ex.getStackTraceString());
            actionResultObject.Message.put('TypeName', ex.getTypeName());
            actionResultObject.Message.put('OrgID', UserInfo.getOrganizationId());
            actionResultObject.Message.put('OrgName', UserInfo.getOrganizationName());
            actionResultObject.Message.put('UserID', UserInfo.getUserId());
            actionResultObject.Message.put('UserName', UserInfo.getName());
        }
        return actionResultObject;
    }
    
    public static Model.ActionResult readPicklist(String objectName, String fieldName, String firstValue){
        Model.ActionResult actionResultObject = new Model.ActionResult();
        try{
            List<Model.SelectOpt> selectOptionList = MetadataServiceUtility.readPicklist(objectName, fieldName, firstValue);
            actionResultObject.SelectOptions = selectOptionList;
            actionResultObject.IsSuccess = true;
        }
        Catch(Exception ex){
            actionResultObject = handleException(ex);
        }
        return actionResultObject;
    }
}