var forcount = 1;  //1==icon1, 2==icon2, 3==icon3 評價-> 修改 -> 訂購 順時中轉

function turnright(){
	if(forcount==3){
       forcount = 1;
	}
	else{
    forcount++;
    }

    

    if(forcount==1){
         document.getElementById("icon1").src="pic_element/judge.png";
         document.getElementById("cetnerword").innerHTML = "評價記錄";

         document.getElementById("icon2").src="pic_element/order.png";
         document.getElementById("icon3").src="pic_element/fix_mem.png";
         document.getElementById("Tri").style.animation = "Toright1 0.5s";
         document.getElementById("Tri").style.transform = "rotate(360deg)";
         document.getElementById("icon1H").href="center_judge.html";
    }

    else if(forcount==2){
         document.getElementById("icon1").src="pic_element/fix_mem.png";
         document.getElementById("cetnerword").innerHTML = "修改資料";

         document.getElementById("icon2").src="pic_element/judge.png";
         document.getElementById("icon3").src="pic_element/order.png";
         document.getElementById("Tri").style.animation = "Toright2 0.5s";
         document.getElementById("Tri").style.transform = "rotate(120deg)";
         document.getElementById("icon1H").href="center_fix.html";
         document.getElementById("icon1").style.animation = "Icon1Move 0.5s";
    }

    else if(forcount==3){
         document.getElementById("icon1").src="pic_element/order.png";
         document.getElementById("cetnerword").innerHTML = "訂購記錄";

         document.getElementById("icon2").src="pic_element/fix_mem.png";
         document.getElementById("icon3").src="pic_element/judge.png";
         document.getElementById("Tri").style.animation = "Toright3 0.5s";
         document.getElementById("Tri").style.transform = "rotate(240deg)";
         document.getElementById("icon1H").href="center_order.html";
    }

    else{}
}

////////////////////////////////////////////////////////////////////////////

function turnleft(){
    if(forcount==1){
       forcount = 3;
	}
	else{
    forcount--;
    }


    if(forcount==1){
         document.getElementById("icon1").src="pic_element/judge.png";
         document.getElementById("cetnerword").innerHTML = "評價記錄";

         document.getElementById("icon2").src="pic_element/order.png";
         document.getElementById("icon3").src="pic_element/fix_mem.png";
         document.getElementById("Tri").style.animation = "Toleft1 0.5s";
         document.getElementById("Tri").style.transform = "rotate(0deg)";
         document.getElementById("icon1H").href="center_judge.html";
    }

    else if(forcount==2){
         document.getElementById("icon1").src="pic_element/fix_mem.png";
         document.getElementById("cetnerword").innerHTML = "修改資料";

         document.getElementById("icon2").src="pic_element/judge.png";
         document.getElementById("icon3").src="pic_element/order.png";
         document.getElementById("Tri").style.animation = "Toleft2 0.5s";
         document.getElementById("Tri").style.transform = "rotate(-120deg)";
         document.getElementById("icon1H").href="center_fix.html";
    }

    else if(forcount==3){
         document.getElementById("icon1").src="pic_element/order.png";
         document.getElementById("cetnerword").innerHTML = "訂購記錄";

         document.getElementById("icon2").src="pic_element/fix_mem.png";
         document.getElementById("icon3").src="pic_element/judge.png";
         document.getElementById("Tri").style.animation = "Toleft3 0.5s";
         document.getElementById("Tri").style.transform = "rotate(-240deg)";
         document.getElementById("icon1H").href="center_order.html";
    }

    else{}
}