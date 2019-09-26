function showdes(product){
	var temp = document.getElementsByClassName('container');  //力用array
    for (i = 0; i < temp.length; i++) {
        temp[i].style.opacity = 0.3;
    }

    document.getElementById(product).style.display = "block";
}

function hidedes(product){
	var temp = document.getElementsByClassName('container');  //力用array
    for (i = 0; i < temp.length; i++) {
        temp[i].style.opacity = 1.0;
    }

    document.getElementById(product).style.display = "none";
}

