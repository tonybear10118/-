function hideallS(){ 
var temp = document.getElementsByClassName('container');  //力用array
for (i = 0; i < temp.length; i++) {
        temp[i].style.opacity = 0.3;
    }
document.getElementById("sign").style.display = "block";
document.getElementById("login").style.display = "none";

var judge = document.getElementById("Subscribe");
if(judge!=null){
document.getElementById("Subscribe").disabled = true;
}

document.getElementById("abgne_float_ad").style.display = "none"; //block

} 
function backallS(){ 
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
