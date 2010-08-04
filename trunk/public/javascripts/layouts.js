function MM_preloadImages() { //v3.0
    var d=document; if(d.images){
        if(!d.MM_p) d.MM_p=new Array();
        var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
            if (a[i].indexOf("#")!=0){
                d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];
            }
            }
}

function MM_swapImgRestore() { //v3.0
    var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
    var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
        d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
    }
    if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
    for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
    if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
    var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
        if ((x=MM_findObj(a[i]))!=null){
            document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];
        }
}

function clear_assit_login(ele){
      if(ele.value == 'User Name'){
      ele.value = '';
      ele.style.color = '#000';}
    }
    function clear_assit_password(ele){
      if(ele.value == 'Password'){
      ele.value = '';
      ele.style.color = '#000';}
    }
    function showLoginDetais(id){
      if(id=='loginLink'){
        document.getElementById('sharethisdiv').style.display = 'none';
        document.getElementById('login').value = 'User Name';
        document.getElementById('login').style.color = '#ccc';
        document.getElementById('password').value = 'Password';
        document.getElementById('password').style.color = '#ccc';
        document.getElementById('LoginDetais').style.display = '';
        document.getElementById('forgotPwd').style.display = 'none';
        document.getElementById('loginLink').style.display = 'none';
      }
      if(id=='closeLoginDetails'){
        document.getElementById('sharethisdiv').style.display = '';
        document.getElementById('LoginDetais').style.display = 'none';
        document.getElementById('forgotPwd').style.display = '';
        document.getElementById('loginLink').style.display = '';
      }
    }
    <!-- -->


    var timeout	= 500;
    var closetimer	= 0;
    var ddmenuitem	= 0;

    // open hidden layer
    function mopen(id)
    {
      // cancel close timer
      mcancelclosetime();

      // close old layer
      if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';

      // get new layer and show it
      ddmenuitem = document.getElementById(id);
      ddmenuitem.style.visibility = 'visible';

    }
    // close showed layer
    function mclose()
    {
      if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
    }

    // go close timer
    function mclosetime()
    {
      closetimer = window.setTimeout(mclose, timeout);
    }

    // cancel close timer
    function mcancelclosetime()
    {
      if(closetimer)
      {
        window.clearTimeout(closetimer);
        closetimer = null;
      }
    }

    function openSubmenu(id){
        $(id).style.display = '';
    }
    function hideLink(id){
        $(id).style.display = 'none';
    }
    // close layer when click-out
    document.onclick = mclose;
    setTimeout("hide_flash();",5000,"","");
    function hide_flash(){
      if ($('flash')){
        $('flash').hide();
      }
    }