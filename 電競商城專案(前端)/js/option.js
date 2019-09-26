var VisibleMenu = ''; // 記錄目前顯示的子選單的 ID
var NowLi = ''; //記錄目前顯式的li

// 顯示或隱藏子選單
function switchMenu( theMainMenu, theSubMenu, debugsub){   //(this, 帶入)
    var SubMenu = document.getElementById( theSubMenu );  //取ID
    if( SubMenu.style.display == 'none' )
    { // 顯示子選單
        if(debugsub!=''){
        document.getElementById(debugsub).style.display="none";
         }
        SubMenu.style.minWidth = theMainMenu.clientWidth; // 讓子選單的最小寬度與主選單相同 (僅為了美觀)
        SubMenu.style.display = 'block';
        hideMenu(); // 隱藏子選單
        VisibleMenu = theSubMenu;
    }
    else{ // 隱藏子選單
        
            SubMenu.style.display = 'none';
            VisibleMenu = '';
        
    }
}

// 隱藏子選單
function hideMenu(){
    if( VisibleMenu != '' ){
        document.getElementById( VisibleMenu ).style.display = 'none';
    }
    VisibleMenu = '';
}


