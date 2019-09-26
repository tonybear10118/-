<html>
<head><meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>抓取模擬器資料</title>
<script>
function clear(){  //清除上一筆資料
    document.getElementById('show').innerHTML='';
  

}
function clearspeed(){  //清除上一筆速度
 
    document.getElementById('speed').innerHTML='';

}
</script>
</head>
<body>
[{<br>
<p id="show"></p>
<p id="speed">"線速：":"0"<br>}]</p>

<?php
set_time_limit(0);
$servername = "localhost";
$username = "root";
$password = "1234";
$dbname = "sa";
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
$sql = "truncate table data";
if ($conn->query($sql) === TRUE) {
    
} else {
    echo "Error deleting record: " . $conn->error;
}





$sec=0;
$min=0;
$hour=0;
$time="";
$speed=0;
$speedfinal="0";

ob_end_flush();
    for($i=0;$i<=60;$i++)
    {
        $min=$i;
        if($i==60)
        {
            break;
            $time="1:0:0";
        }
        else{


            for($n=0;$n<=59;$n++)
            {           
               
                        $sec=$n;
                        $time=(String)$hour.":".(String)$min.":".(String)$sec;
                    
                    //抓c11i1 meter
                    $handle = fopen("http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-I1-Meter&time=".$time,"rb");
                    $content = "";
                    while (!feof($handle)) {
                        $content .= fread($handle, 10000);
                    }
                    fclose($handle);
                    $content = json_decode($content,true);
                    $data=(string)$content['data'];
    
                    //抓c11i1 position
                    $handle2 = fopen("http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-I1-Position&time=".$time,"rb");
                    $content2 = "";
                    while (!feof($handle2)) {
                        $content2 .= fread($handle2, 10000);
                    }
                    fclose($handle2);
                    $content2 = json_decode($content2,true);
                    $data2=(string)$content2['data'];
    
                    //抓c11o1 meter
                    $handle3 = fopen("http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-O1-Meter&time=".$time,"rb");
                    $content3 = "";
                    while (!feof($handle3)) {
                        $content3 .= fread($handle3, 10000);
                    }
                    fclose($handle3);
                    $content3 = json_decode($content3,true);
                    $data3=(string)$content3['data'];
    
                    //抓c11o1 position
                    $handle4 = fopen("http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-O1-Position&time=".$time,"rb");
                    $content4 = "";
                    while (!feof($handle4)) {
                        $content4 .= fread($handle4, 10000);
                    }
                    fclose($handle4);
                    $content4 = json_decode($content4,true);
                    $data4=(string)$content4['data'];
    
                    //抓c11 thermal
                    $handle5 = fopen("http://etouch20.cycu.edu.tw:5146/simone/read/?mid=%E8%B3%87%E7%AE%A1%E4%B8%89C11%E4%BC%B8%E7%B7%9A%E6%A9%9F&sid=C11-Thermal&time=".$time,"rb");
                    $content5 = "";
                    while (!feof($handle5)) {
                        $content5 .= fread($handle5, 10000);
                    }
                    fclose($handle5);
                    $content5 = json_decode($content5,true);
                    $data5=(string)$content5['data'];
                    $show='"時間：":"'.$time.'",<br>"c11i1 meter：":"'.$data.'",<br>"c11i1 position：":"'.$data2.'",<br>"c11o1 meter：":"'.$data3.'",<br>"c11o1 position：":"'.$data4.'",<br>"c11 thermal：":"'.$data5.'",<br>';
                   
                   


                    //計算速度
                    if($sec==0&&$min!=0)
                    {
                        echo "<script>clearspeed()</script>";      
                        flush();
                        $min2=$min-1;
                        $time2=(String)$hour.":".(String)$min2.":".(String)$sec;//上一分鐘
                        $handles = fopen("http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-O1-Meter&time=".$time2,"rb");
                        $contents = "";
                        while (!feof($handles)) {
                            $contents .= fread($handles, 10000);
                        }
                        fclose($handles);
                        $contents = json_decode($contents,true);
                        $datas=(int)$contents['data']; // 上一分鐘的C11-O1-Meter
                        $data3s=(int)$data3; // C11O1Meter
                        $speed=$data3s-$datas;
                        $speedfinal=$speedfinal.",".(string)$speed;
                        
                        echo "<script>showspeed()</script>";
                        
                        flush();
                        

                    }                    
                    ?>
                    <script>
                       
                        function show()//顯示下一筆資料
                        {
                            document.getElementById('show').innerHTML='<?php 
                                    echo $show;
                            ?>';                                                       
                        }
                        function showspeed()//顯示速度
                        {                           
                            document.getElementById('speed').innerHTML='"線速：":"<?php 
                                    echo $speedfinal;
                            ?>"<br>}]';                              
                        }

                    </script>

                    




                 <?php   
                    echo "<script>clear()</script>";      
                    flush();              
                    $sql = "INSERT INTO data (time,C11I1Meter,C11I1Position,C11O1Meter,C11O1Position,C11Thermal)
                    VALUES ('".$time."','".$data."','".$data2."','".$data3."','".$data4."','".$data5."')";
                    
                    echo "<script>show()</script>";
                    flush();
                    sleep(0.2);
                    
                    if ($conn->query($sql) === TRUE) 
                    {
                        
                    } else {
                       // echo "Error: " . $sql . "<br>" . $conn->error;
                    }    
            }
        }    
    }
  ?>
    
    



<?php
$conn->close();

/* 
$handle = fopen("http://etouch20.cycu.edu.tw:5146/simone/read/?mid=資管三C11伸線機&sid=C11-I1-Meter&time=".$time,"rb");
$content = "";
while (!feof($handle)) {
    $content .= fread($handle, 10000);
}
fclose($handle);
$content = json_decode($content,true);
echo $content['time']."<br>";
echo $content['data']."<br>";

$servername = "localhost";
$username = "root";
$password = "1234";*/



 /*$file = fopen("out.html", 'w');    //開啟檔案
 fwrite($file, $data);            //寫入檔案                                   
 fclose($file);                    //關閉檔案
 */


?>
<br>}]
</body>





                                                              