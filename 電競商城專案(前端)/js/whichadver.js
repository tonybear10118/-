function calladver()
{
var adverpick = "";	
var maxNum = 3;  
var minNum = 1;   <!--math.random取小數亂數，mathfloor去小數-->
var n = Math.floor(Math.random()*(maxNum-minNum+1)+minNum);
if(n==1){
     adverpick = "<a href='blue.html'>最新潮的鍵盤!只要1588元!<br><img src='pic_element/keyboard/1.jpg' title='最新潮的鍵盤'' width='200' height='150'/></a>";

     document.write(adverpick);	
}

else if (n==2){
	adverpick = "<a href='tt.html'>最新潮的滑鼠!只要2000元!<br><img src='pic_element/mouse/1.jpg' title='最新潮的滑鼠'' width='200' height='150'/></a>";

document.write(adverpick);	
}

else if(n==3){
	adverpick = "<a href='ear1.html'>最新潮的耳機!只要399元!<br><img src='pic_element/ear/1.jpg' title='最新潮的耳機'' width='200' height='150'/></a>";

document.write(adverpick);
}

else{}

}
