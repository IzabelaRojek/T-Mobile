({
	doInitImplementation : function(component, event) {
		//alert("Agunia Zgagunia");

		var action = component.get("c.takeSimpleValue");
		//action.setParams({ name : component.get("v.userName") });
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === "SUCCESS") {
				//alert("From server: " + response.getReturnValue());
				let backendResult = response.getReturnValue();
				console.log("@@ " , backendResult);
			}
			else if (state === "INCOMPLETE") {
				// do something
			}
			else if (state === "ERROR") {
				var errors = response.getError();
				if (errors) {
					if (errors[0] && errors[0].message) {
						console.log("Error message: " +
							errors[0].message);
					}
				} else {
					console.log("Unknown error");
				}
			}
		});
		$A.enqueueAction(action);
	}
})