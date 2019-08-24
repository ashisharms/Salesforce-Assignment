({
	handleAccountSave : function(component, event, helper) {
		debugger;
        var accountObject = component.get("v.objAccount");
        
        var action = component.get("c.saveAcc");
        
        action.setParams({
            objAcc : accountObject
        });
        
        action.setCallback(this,function(response){
            
            var state = response.getState();
            
            var result = response.getReturnValue();
            
            if(result['STATUS'] === 'SUCCESS') {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: "Success",
                        type : "Success",
                        mode: "pester",
                        message: "The Account record has been created successfully.",
                        duration:'5000'
                    });
                    toastEvent.fire();
            }else{
                /*var errors = action.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            alert('****' +errors[0].message + '*****');
                        }
                    }*/
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: "Error",
                        type : "Error",
                        mode: "pester",
                        message: result['MESSAGE'],
                        duration:'5000'
                    });
                    toastEvent.fire();
                }
        });
         $A.enqueueAction(action);  
	}
})