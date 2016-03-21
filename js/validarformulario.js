// JavaScript Document
(function($){
$.fn.validarformulario=
function(options){
	//OPCIONES PARA INTERACTUAR CON EL PLUGIN
var optiondefaults={
identificador:'id'
};
//TOMA EL VALOR DE LAS OPCIONES, YA SEAN LAS DE DEFECTO O LAS DEL USUARIO
var opciones=$.extend(optiondefaults,options);
//inicia a correr el plugin
return this.each(function(){
var caracteridentificador;
//definimos un identificador, ya sea id o clase
if(opciones.identificador=='id'){
	caracteridentificador="#";
}
else{
caracteridentificador=".";	
}
//iniciamos con los keyup, solo texto
$(caracteridentificador+$(this).attr(opciones.identificador)+" input[data-id=solotexto]").keyup
	(function(e) {
        var expregul=/^[A-Za-z\s]+$/;
		if(expregul.test($(this).val())){
			
		}
		else{
			var valor=$(this).val().substring(0, $(this).val().length-1);
             $(this).val(valor);
		}
    });
	//solo numeros
	$(caracteridentificador+$(this).attr(opciones.identificador)+" input[data-id=solonumero]").keyup
	(function(e) {
        var expregul=/^[0-9]*$/;
		if(expregul.test($(this).val())){
			
		}
		else{
			var valor=$(this).val().substring(0, $(this).val().length-1);
             $(this).val(valor);
		}
    });
	//obtiene el primer passowrd
	var primerpassword=caracteridentificador+$(this).attr(opciones.identificador)+" input[type=password]";
	//obtiene el segundo password
	$(caracteridentificador+$(this).attr(opciones.identificador)+" input[type=password]").eq(1).keyup(function(e) {

		
    if($(this).val()==$(primerpassword).eq(0).val())
	{
		$("label[for="+$(this).attr("id")+"]").html("ok");
		$("label[for="+$(primerpassword).eq(0).attr("id")+"]").html("ok");
		
	}
	else
	{
		$("label[for="+$(this).attr("id")+"]").html("error");
		$("label[for="+$(caracteridentificador+$(this).attr(opciones.identificador)+" input[type=password]").eq(0).attr("id")+"]").html("error");
	}
    });
	//saber si un email es correcto
	$(caracteridentificador+$(this).attr(opciones.identificador)+" input[type=email]").keyup
	(function(e) {
        var expreg1=/^[a-zA-Z0-9\-_]+([a-zA-Z0-9\-_.]+)*@([a-zA-Z0-9\-_]+)*\.([a-zA-Z]{2,3}|[a-zA-Z]{4})$/;
var expreg2=/^[a-zA-Z0-9\-_]+([a-zA-Z0-9\-_.]+)*@([a-zA-Z0-9\-_]+)*\.([a-zA-Z]{2,3}|[a-zA-Z]{4})*\.([a-zA-Z]{2,3}|[a-zA-Z]{2,4})$/;
		if(expreg1.test($(this).val()) || 
		expreg2.test($(this).val())){
		$("label[for="+$(this).attr("id")+"]").html("ok");	
		}
		else{
			$("label[for="+$(this).attr("id")+"]").html("error");
		}
    });
	//Identifica los textarea para mensajes y evita escribir groserias, las mencionadas en el vector
		$(caracteridentificador+$(this).attr(opciones.identificador)+" textarea").keyup
	(function(e) {
        var groserias=["Pendej","Ping","Mierd","Hijueput","Malpari","Maric","Idiot","Estupid","Imbecil"]; //se escriben con la primera mayuscula y la segunda minuscula
var valormensaje=$(this).val();	//Obtiene el valor del textarea que obtiene el evento
for(i in groserias){
var reg=new RegExp("("+groserias[i]+")","g");  //primera en mayuscula
valormensaje=valormensaje.replace(reg, "#4@!@");
var reg=new RegExp("("+groserias[i].toUpperCase()+")","g"); //mayuscula
valormensaje=valormensaje.replace(reg, "#4@!@");
var reg=new RegExp("("+groserias[i].toLowerCase()+")","g"); //minuscula
valormensaje=valormensaje.replace(reg, "#4@!@");
}
//devuelve el mensaje
$(this).val(valormensaje);
    });

});
};
})(jQuery)
