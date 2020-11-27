({
	doInit : function(component, event, helper) {
		helper.doInitImplementation(component, event);
	},

	handleClick: function(component, event, helper) {
		let currentName = component.get("v.userName"); //v- od variable

		console.log("@@ current name " + currentName);

		let lista = [];
		lista.push("a");
		lista.push("b");

		//debugger

		console.log("@@ " + lista);//wyswietla jakos toString
		console.log("@@ " , lista);//wyswietla jako obiekt

		let aga = {imie : "Agnieszka", wiek : 27}; // tworzymy obiekt ze wskazanymi polami

		console.log("@@ " + aga); //
		console.log("@@ " , aga); //wymuszamy, żeby wyswietlił jako obiekt


	},

	handleDrag: function (component, event, helper) {
		alert("heeeello");
	}

})