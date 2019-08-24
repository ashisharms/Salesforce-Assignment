/**************************************************************************************************************************
 * @ClassName : CreateAccount
 * @Author : Ashish Ranjan
 * @Date: 24/08/2019
 * @Description : CreateAccount class for Lightning Componenet controller.
 * *************************************************************************************************************************/
public class CreateAccount {
    
    @AuraEnabled
    public static Map<String, object> saveAcc(Account objAcc){
        
        System.debug('Account 1*****' + objAcc);
        Map<String, object> response = new Map<String, object>();
        Boolean isSuccess;
        
        try{
            Database.SaveResult result = Database.insert(objAcc);
            system.debug('Account result 2******' +result);
            if(result.isSuccess()) {
                isSuccess = true;
                response.put('STATUS', 'SUCCESS');
            }
        }catch(Exception ex){
            PackageException.handleException(ex);
            //response.put('STATUS', 'Error');
            isSuccess = false;
            String err = ex.getMessage();
            List<String> errors = err.split('REQUIRED_FIELD_MISSING,');
            system.debug('Error msg: 3*****'+ex.getMessage());
            response.put('STATUS', 'Error');
            if(!test.isRunningTest() && !errors.isEmpty()){
                response.put('MESSAGE', errors[1]);
            }
            //throw new AuraHandledException('Darn it! Something went wrong: '+ ex.getMessage());
        }
        return response;
        }
}