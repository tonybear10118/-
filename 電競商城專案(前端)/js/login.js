function hideall(){ 

if(document.getElementById("sign").style.display=="block")
{
	document.getElementById("login").style.animation="signMove 1s";
}
else{
	document.getElementById("login").style.animation="loginMove 1s";
}

var temp = document.getElementsByClassName('container');  //力用array
for (i = 0; i < temp.length; i++) {
        temp[i].style.opacity = 0.3;
    }
document.getElementById("login").style.display = "block";
document.getElementById("sign").style.display = "none";

var judge = document.getElementById("Subscribe");
if(judge!=null){
document.getElementById("Subscribe").disabled = true;
}

document.getElementById("abgne_float_ad").style.display = "none"; //block

} 
function backall(){ 
var temp = document.getElementsByClassName('container');  //力用array
for (i = 0; i < temp.length; i++) {
        temp[i].style.opacity = 1;
    }; 
document.getElementById("login").style.display = "none";
document.getElementById("sign").style.display = "none";
var judge = document.getElementById("Subscribe");
if(judge!=null){
document.getElementById("Subscribe").disabled = false;
}

document.getElementById("abgne_float_ad").style.display = "block";
}
