// Opacity and Fade in script.
// Script copyright (C) 2008 http://www.cryer.co.uk/.
// Script is free to use provided this copyright header is included.
var FadeDurationMS=1000;
function SetOpacity(object,opacityPct)
{
  // IE.
  object.style.filter = 'alpha(opacity=' + opacityPct + ')';
  // Old mozilla and firefox
  object.style.MozOpacity = opacityPct/100;
  // Everything else.
  object.style.opacity = opacityPct/100;
}
//function ChangeOpacity(id,msDuration,msStart,fromO,toO)
//{
//  var element=document.getElementById(id);
//  var opacity = element.style.opacity * 100;
//  var msNow = (new Date()).getTime();
//  opacity = fromO + (toO - fromO) * (msNow - msStart) / msDuration;
//  if (opacity<0)
//    SetOpacity(element,0)
//  else if (opacity>100)
//    SetOpacity(element,100)
//  else
//  {
//    SetOpacity(element,opacity);
//    element.timer = window.setTimeout("ChangeOpacity('" + id + "'," + msDuration + "," + msStart + "," + fromO + "," + toO + ")",1);
//  }
//}
function ChangeOpacity(id,msDuration,msStart,fromO,toO)
{
  var element=document.getElementById(id);
  var msNow = (new Date()).getTime();
  var opacity = fromO + (toO - fromO) * (msNow - msStart) / msDuration;
  if (opacity>=100)
  {
    SetOpacity(element,100);
    element.timer = undefined;
  }
  else if (opacity<=0)
  {
    SetOpacity(element,0);
    element.timer = undefined;
  }
  else
  {
    SetOpacity(element,opacity);
    element.timer = window.setTimeout("ChangeOpacity('" + id + "'," + msDuration + "," + msStart + "," + fromO + "," + toO + ")",10);
  }
}
function FadeIn(id)
{
  var element=document.getElementById(id);
  if (element.timer) window.clearTimeout(element.timer);
  var startMS = (new Date()).getTime();
  element.timer = window.setTimeout("ChangeOpacity('" + id + "',1000," + startMS + ",0,100)",1);
}
function FadeOut(id)
{
  var element=document.getElementById(id);
  if (element.timer) window.clearTimeout(element.timer);
  var startMS = (new Date()).getTime();
  element.timer = window.setTimeout("ChangeOpacity('" + id + "',1000," + startMS + ",100,0)",1);
}

function FadeInImage(foregroundID,newImage,backgroundID, id)
{
switch (id){
    case 'first': {
                    document.getElementById('first').style.backgroundPosition = '-322px -57px';
                    document.getElementById('second').style.backgroundPosition = '-322px -37px';
                    document.getElementById('third').style.backgroundPosition = '-322px -37px';
                    document.getElementById('four').style.backgroundPosition = '-322px -37px';
                    break;
                  }
    case 'second':{
                    document.getElementById('second').style.backgroundPosition = '-322px -57px';
                    document.getElementById('first').style.backgroundPosition = '-322px -37px';
                    document.getElementById('third').style.backgroundPosition = '-322px -37px';
                    document.getElementById('four').style.backgroundPosition = '-322px -37px';
                    break;
                  }
    case 'third': {
                    document.getElementById('third').style.backgroundPosition = '-322px -57px';
                    document.getElementById('second').style.backgroundPosition = '-322px -37px';
                    document.getElementById('first').style.backgroundPosition = '-322px -37px';
                    document.getElementById('four').style.backgroundPosition = '-322px -37px';
                    break;
                  }
    case 'four':  {
                    document.getElementById('four').style.backgroundPosition = '-322px -57px';
                    document.getElementById('second').style.backgroundPosition = '-322px -37px';
                    document.getElementById('third').style.backgroundPosition = '-322px -37px';
                    document.getElementById('first').style.backgroundPosition = '-322px -37px';
                    break;
                  }
           }
  var foreground=document.getElementById(foregroundID);
  if (foreground.timer) window.clearTimeout(foreground.timer);
  if (backgroundID)
  {
    var background=document.getElementById(backgroundID);
    if (background)
    {
      if (background.src)
      {
        foreground.src = background.src;
        SetOpacity(foreground,100);
      }
      background.src = newImage;
      background.style.backgroundImage = 'url(' + newImage + ')';
      background.style.backgroundRepeat = 'no-repeat';
      var startMS = (new Date()).getTime();
      foreground.timer = window.setTimeout("ChangeOpacity('" + foregroundID + "'," + FadeDurationMS + "," + startMS + ",100,0)",10);
    }
  } else {
    foreground.src = newImage;
  }
}
var slideCache = new Array();
function RunSlideShow(pictureID,backgroundID,imageFiles,displaySecs)
{
  var name;
  var imageSeparator = imageFiles.indexOf(";");
  var nextImage = imageFiles.substring(0,imageSeparator);
  if (slideCache[nextImage] && slideCache[nextImage].loaded)
  {
    switch(nextImage){
        case 'images/banner/welcome.png': {name = 'first';break;}
        case 'images/banner/i_investors.png': {name = 'second';break;}
        case 'images/banner/service_providers.png': {name = 'third';break;}
        case 'images/banner/money_managers.png': {name = 'four';break;}

    }
    FadeInImage(pictureID,nextImage,backgroundID,name);
    var futureImages = imageFiles.substring(imageSeparator+1,imageFiles.length)
      + ';' + nextImage;
    setTimeout("RunSlideShow('"+pictureID+"','"+backgroundID+"','"+futureImages+"',"+displaySecs+")",
      displaySecs*1000);
    // Identify the next image to cache.
    imageSeparator = futureImages.indexOf(";");
    nextImage = futureImages.substring(0,imageSeparator);
  } else {
    setTimeout("RunSlideShow('"+pictureID+"','"+backgroundID+"','"+imageFiles+"',"+displaySecs+")",
      250);
  }
  // Cache the next image to improve performance.
  if (slideCache[nextImage] == null)
  {
    slideCache[nextImage] = new Image;
    slideCache[nextImage].loaded = false;
    slideCache[nextImage].onload = function(){this.loaded=true};
    slideCache[nextImage].src = nextImage;
  }
}