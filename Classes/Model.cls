/*****************************************************************************************
 * @ClassName : Model
 * @Author : Ashish Ranjan
 * @Date: 24/08/2019
 * @Description : Model class for Lightning Componenet Error Handling
 * *****************************************************************************************/
public class Model {
    public class ActionResult{
         @AuraEnabled
        public Boolean IsSuccess {get; set;}
        @AuraEnabled
        public Map<String, Object> Message {get; set;}
         @AuraEnabled
        public List<SelectOpt> SelectOptions {get; set;}
    }
    
    public class AObject{
        @AuraEnabled
        public String ObjectName {get; set;}
        @AuraEnabled
        public String FieldName {get; set;}
        @AuraEnabled
        public String FirstValue {get; set;}
    }
    
     public class SelectOpt {
        @AuraEnabled
        public String label {get; set;}
        @AuraEnabled
        public String value {get; set;}
        @AuraEnabled
        public Boolean selected {get; set;}
        public SelectOpt(String label, String value){            
            this.label = label;
            this.value = value; 
        }
        public SelectOpt(String label, String value, Boolean selected){            
            this.label = label;
            this.value = value; 
            this.selected = selected;
        }
    }
}