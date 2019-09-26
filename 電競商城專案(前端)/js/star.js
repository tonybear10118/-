function star(count){
     if(count==1){
        document.getElementById("star1").src = "pic_element/star_true.png";
        document.getElementById("star2").src = "pic_element/star_null.png";
        document.getElementById("star3").src = "pic_element/star_null.png";
        document.getElementById("star4").src = "pic_element/star_null.png";
        document.getElementById("star5").src = "pic_element/star_null.png";
     }
          
     else if(count==2){
        document.getElementById("star1").src = "pic_element/star_true.png";
        document.getElementById("star2").src = "pic_element/star_true.png";
        document.getElementById("star3").src = "pic_element/star_null.png";
        document.getElementById("star4").src = "pic_element/star_null.png";
        document.getElementById("star5").src = "pic_element/star_null.png";
     }

     else if(count==3){
        document.getElementById("star1").src = "pic_element/star_true.png";
        document.getElementById("star2").src = "pic_element/star_true.png";
        document.getElementById("star3").src = "pic_element/star_true.png";
        document.getElementById("star4").src = "pic_element/star_null.png";
        document.getElementById("star5").src = "pic_element/star_null.png";
     }

     else if(count==4){
        document.getElementById("star1").src = "pic_element/star_true.png";
        document.getElementById("star2").src = "pic_element/star_true.png";
        document.getElementById("star3").src = "pic_element/star_true.png";
        document.getElementById("star4").src = "pic_element/star_true.png";
        document.getElementById("star5").src = "pic_element/star_null.png";
     }

     else if(count==5){
        document.getElementById("star1").src = "pic_element/star_true.png";
        document.getElementById("star2").src = "pic_element/star_true.png";
        document.getElementById("star3").src = "pic_element/star_true.png";
        document.getElementById("star4").src = "pic_element/star_true.png";
        document.getElementById("star5").src = "pic_element/star_true.png";
     }

     else{}
}