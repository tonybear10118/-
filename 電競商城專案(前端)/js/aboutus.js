function Fshowinfo(judge){

    if(judge==1){
        document.getElementById("about1").src = "pic_element/about/about1.jpg";
        document.getElementById("about1").style.backgroundImage = url("pic_element/about/bear_s.PNG");
    }


    if(judge==2){
    	document.getElementById("about2").src = "pic_element/about/about2.jpg";
    }


    if(judge==3){
    	document.getElementById("about3").src = "pic_element/about/about3.jpg";
    }
}



function Fhideinfo(judge){
	if(judge==1){
    	document.getElementById("about1").src = "pic_element/about/bear_s.PNG";
    }
    if(judge==2){
    	document.getElementById("about2").src = "pic_element/about/chung_s.jpg";
    }
    if(judge==3){
    	document.getElementById("about3").src = "pic_element/about/tsai_s.jpg";
    }
}
