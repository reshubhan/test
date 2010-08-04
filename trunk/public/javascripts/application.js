// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function init() {
    makeItCount('secondary_description', 140);
    makeItCount('manager_description', 400);
    makeItCount('classified_fund_description', 2000);
    makeItCount('company_description', 400);

    if ($('manager_name')){
        $('manager_name').value = 'Search Manager';
    }
    if ($('name')){
        $('name').focus();
    }
}

function facebook_login(loc){
    new Ajax.Request('/facebook/connect'+'/'+loc, {
        method:'get',
        asynchronous:true,
        evalScripts:true
    });
}

function show_received(){
    document.getElementById('sent_messages').style.display = 'none';
    document.getElementById('received_messages').style.display ='';
}
function show_sent(){
    document.getElementById('sent_messages').style.display ='';
    document.getElementById('received_messages').style.display = 'none';
}

function close_popup(){
    RedBox.close();
    return false;
}

Event.observe(window,'load',init);

function keyPressHandler(e) {
    var kC  = (window.event) ?    // MSIE or Firefox?
    event.keyCode : e.keyCode;
    var Esc = (window.event) ?
    27 : e.DOM_VK_ESCAPE // MSIE : Firefox
    if(kC==Esc){
        RedBox.close();
        return false;
    }
        
}



function charCounter(id, maxlimit, limited){
    if (!$('counter-'+id)){
        $(id).insert({
            after: '<div style="font-size:11px;color:black;" id="counter-'+id+'"></div>'
        });
    }
    if($F(id).length >= maxlimit){
        if(limited){	
            $(id).value = $F(id).substring(0, maxlimit);
        }
        $('counter-'+id).addClassName('charcount-limit');
        $('counter-'+id).removeClassName('charcount-safe');
    } else {
        $('counter-'+id).removeClassName('charcount-limit');
        $('counter-'+id).addClassName('charcount-safe');
    }
    $('counter-'+id).update( (maxlimit - $F(id).length) + ' characters left');

}

function makeItCount(id, maxsize, limited){
    if(limited == null) limited = true;
    if ($(id)){
        Event.observe($(id), 'keyup', function(){
            charCounter(id, maxsize, limited);
        }, false);
        Event.observe($(id), 'keydown', function(){
            charCounter(id, maxsize, limited);
        }, false);
        charCounter(id,maxsize,limited);
    }
}

/*
function trim_txt(ele){
    if (ele.value.indexOf('[Asset:')!=-1){
      ele.value = ele.value.substring(0, ele.value.indexOf('[Asset:'));
    }
}
 */

function get_asset_types(asset_class, object_type){
    pars1 = '&asset_id='+$(asset_class).value+'&object_type='+object_type;
    new Ajax.Updater('assettypes', '/assets/get_children', {
        method:'post',
        asynchronous:true,
        evalScripts:true,
        parameters:pars1
    });
}

function get_manager_funds(elem,secondary_id,manager_elem){
    /*
 if (ele.value.indexOf('[Asset:')!=-1){
        ele.value = ele.value.substring(0, ele.value.indexOf('[Asset:'));
    }
     */
    pars1 = '&manager_id='+$(manager_elem).value.replace('&', '!!and!!');
    pars2 = '&manager_id='+$(manager_elem).value.replace('&', '!!and!!')+'&secondary_id='+secondary_id;
    pars2.replace('&', '<<and>>')
    new Ajax.Updater('managerurl', '/secondaries/get_manager_url', {
        method:'post',
        asynchronous:true,
        evalScripts:true,
        parameters:pars1
    });
    new Ajax.Updater('managerfunds', '/secondaries/getfunds', {
        method:'post',
        asynchronous:true,
        evalScripts:true,
        parameters:pars2
    });
}

function get_manager_funds_sell(elem,fund_id,manager_elem){
    /*
 if (ele.value.indexOf('[Asset:')!=-1){
        ele.value = ele.value.substring(0, ele.value.indexOf('[Asset:'));
    }
     */
    pars1 = '&manager_id='+$(manager_elem).value.replace('&', '!!and!!');
    pars2 = '&manager_id='+$(manager_elem).value.replace('&', '!!and!!')+'&fund_id='+fund_id;
    pars2.replace('&', '<<and>>')
    new Ajax.Updater('managerurl', '/classified_funds/get_manager_url', {
        method:'post',
        asynchronous:true,
        evalScripts:true,
        parameters:pars1
    });
    new Ajax.Updater('managerfunds', '/classified_funds/getfunds', {
        method:'post',
        asynchronous:true,
        evalScripts:true,
        parameters:pars2
    });
}


function check_availability(ele){
    pars1 = '&manager_name=' + ele.value;
    new Ajax.Updater('error', '/managers/check_availibility', {
        method:'post',
        asynchronous:true,
        evalScripts:true,
        parameters:pars1
    });
}

function validate_checkboxes(){
    for(var i=0; i<document.getElementsByName('asset_list[]').length; i++){
        if(document.getElementsByName('asset_list[]')[i].checked){
            return true;
        }
    }
    document.getElementById('error_select_asset').style.display="";
    return false;
}

function select_pros_by_default(asset_id){
    if(document.getElementById('asset_list').checked == true){
        document.getElementById('pros_'+asset_id).checked = true;
    }else{
        document.getElementById('pros_'+asset_id).checked = false;
        document.getElementById('cons_'+asset_id).checked = false;
    }
}

// For the sliders in the filter
var slidersActive = false;
var sliderfeedback;

//var feedbackSliderArray = new Array('All','Above 30M','Above 40M','Above 50M','Above 60M','Above 70M','Above 80M','Above 90M');

//var valSliderArray = new Array('0','10','20','30','40','50','60','70','80','90');

//function initArr(maxValue){
//   var segment = maxValue/10
//   var temp = 0
//   valSliderArray = new Array(temp,temp+=segment,temp+=segment,temp+=segment,temp+=segment,temp+=segment,temp+=segment,temp+=segment,temp+=segment,temp+=segment,temp+=segment);
//}

var bgfeedback="feedbackBGDiv";
var thumbmin="minHandleDiv";
var thumbmax="maxHandleDiv";


function init_feedbackSlider(funds_max_size,url,min_size,max_size) {
    /*
     var initvalueMin = Math.max(0, 150.0 / (minValSliderArray.length-1) * (0 - 0.5));
	var initvalueMax = Math.max(0, 150.0 / (maxValSliderArray.length-1) * (0 - 0.5));
    sliderfeedback.setValues(initvalueMin, initvalueMax);
     */
   
    var max_size_for_scroller = '30000';
    var display_max_size = '30B';
    if (funds_max_size > max_size_for_scroller){
        max_size_for_scroller = funds_max_size;
        display_max_size = Math.round(funds_max_size/1000)+'B';
    }
    var valSliderArray = new Array('0','50','100','150','200','250','300','350','400', '450', '500', '750', '1000', '5000', max_size_for_scroller);
    var sliderDisplayValuesArray = new Array('0M','50M','100M','150M','200M','250M','300M','350M','400M','450M','500M','750M','1B','5B',display_max_size);
    var arrayLength = valSliderArray.length-1;

    $('minFilter').value = valSliderArray[0];
    $('maxFilter').value = valSliderArray[arrayLength];
    $('minFilterValueForDisplay').value = sliderDisplayValuesArray[0];
    $('maxFilterValueForDisplay').value = sliderDisplayValuesArray[arrayLength];
    // $('feedbackSliderVal').innerHTML = $('minFilter').value + ' - ' + $('maxFilter').value + ' M';
    $('feedbackSliderVal').innerHTML = $('minFilterValueForDisplay').value + ' - ' + $('maxFilterValueForDisplay').value;

    $('feedbackSliderVal').innerHTML = min_size + ' - ' + max_size;

    var incrementLength = (150.0/arrayLength);

    sliderfeedback.subscribe("change", function() {
      
        var i = Math.min( arrayLength, Math.ceil(sliderfeedback.minVal / incrementLength) );
        var j = Math.min( arrayLength, Math.ceil(sliderfeedback.maxVal / incrementLength) );

        $('minFilter').value = valSliderArray[i];
        $('maxFilter').value = valSliderArray[j];
        $('minFilterValueForDisplay').value = sliderDisplayValuesArray[i];
        $('maxFilterValueForDisplay').value = sliderDisplayValuesArray[j];
        //$('feedbackSliderVal').innerHTML = $('minFilter').value + ' - ' + $('maxFilter').value + ' M';
        $('feedbackSliderVal').innerHTML = $('minFilterValueForDisplay').value + ' - ' + $('maxFilterValueForDisplay').value;
    });
    
    sliderfeedback.subscribe("slideEnd", function() {
        if( slidersActive )
        {
            new Ajax.Request('/managers/filter_results',

            { 
                    asynchronous:true,
                    evalScripts:true,
                    onComplete:function(request){
                        $('loading').style.display='none'
                    },
                    onLoading:function(request){
                        $('loading').style.display=''
                    },
                    parameters:'size_min=' + $('minFilter').value + '&size_max=' + $('maxFilter').value+ '&url=' + url
                });
            return false;
        }
    });
}

function set_feedbackSlider( setval ) {
    var newIndex = -1;
    var i;
    for( i=0; i < feedbackSliderArray.length; i++ ) {
        if( setval == feedbackValSliderArray[i] ) {
            newIndex = i;
        }
    }
    if( newIndex >= 0 && newIndex < feedbackSliderArray.length) {
        var newValue = Math.max(0, 150.0 / (feedbackSliderArray.length-1) * (newIndex - 0.5));
        //-- need to set the filter, in IE, the setValue is not called until after the search is executed
        $('feedbackFilter').value = feedbackValSliderArray[newIndex];
        sliderfeedback.setValue( newValue );
    }
}



function reviewbodycount(limitField, limitNum) {   
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    }
}

function setText(field, text){
    if (field.value == ""){
        field.value = text;
    }
}
function clearText(field){
    if (field.value == "Search Manager"){
        field.value = "";
    }
    if (field.value == "Search Fund"){
        field.value = "";
    }
}
function checkEnter(e)
{
    var characterCode;
    if(e && e.which){
        e = e;
        characterCode = e.which;
    }
    else{
        e = event;
        characterCode = e.keyCode;
    }
    if(characterCode == 13){
        document.forms[0].submit();
        return false;
    }
    else{
        return true;
    }
}

function showContentsOfTab(show_div, hide_div, hide_div1,size_check)
{
    if (size_check && size_check == 0)
    {
        if (show_div == "buy"){
            $(show_div).innerHTML="There are no records to display";
        }
        else
        {
            $(show_div).innerHTML="There are no records to display"
        }
    }
    $(show_div).style.display = '';
    $(hide_div).style.display = 'none';    
    if ($(hide_div1))
    {
        $(hide_div1).style.display = 'none';
    }
}

function showContentAndHighlight3(idshow,idhide1,idhide2,idhide3,idhide4){
    $(idshow).style.display = '';
    document.getElementById(idshow+'Tab').className = 'current';
    document.getElementById(idhide1).style.display = 'none';
    document.getElementById(idhide1+'Tab').className = '';
    document.getElementById(idhide2).style.display = 'none';
    document.getElementById(idhide2+'Tab').className = '';
    document.getElementById(idhide3).style.display = 'none';
    document.getElementById(idhide3+'Tab').className = '';
    document.getElementById(idhide4).style.display = 'none';
    document.getElementById(idhide4+'Tab').className = '';
}

function showContentAndHighlight2(idshow,idhide1){
    $(idshow).style.display = '';
    $(idshow+'Tab').className = 'current';

    $(idhide1).style.display = 'none';
    $(idhide1+'Tab').className = '';
}

function highlightTab(tab1,tab2,tab3)
{
    
    $(tab1).style.backgroundColor = '#e5e5e5';
    if(tab1 == "editProfileTab"){
        $('profile_firstname').select();
    }
    /*
    $(tab1).style.color = '#000000';
     */
    $(tab2).style.backgroundColor = '#fff';
    /*
$(tab2).style.color = '#ECB23C';
     */
    if ($(tab3)){
        $(tab3).style.backgroundColor = '#fff';
    /*
 $(tab3).style.color = '#ECB23C';
         */
    }
}

function notify(flash_message)
{
    // jQuery: reference div, load in message, and fade in
    var flash_div = $("#flash");
    flash_div.html(flash_message);
    flash_div.fadeIn(400);
    // use Javascript timeout function to delay calling
    // our jQuery fadeOut, and hide
    setTimeout(function(){
        flash_div.fadeOut(500,
            function(){
                flash_div.html("");
                flash_div.hide()
            })
    },
    1400);
}

function update_mailing_list(secondary_id){
    pars = '&id='+ secondary_id;
    new Ajax.Request ('/secondaries/secondary_mail',
    {
        method:'post',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function update_mailing_list1(company_id){
    pars = '&id='+ company_id;
    new Ajax.Request ('/companies/company_mail',
    {
        method:'post',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function show_loading(){
    $('loading').style.display='';
    $('loading_top').style.display='';
    $('loading_bottom').style.display='';
}

function hide_loading(){
    $('loading').style.display='none';
    $('loading_top').style.display='none';
    $('loading_bottom').style.display='none';
}

function fireEvent(obj,evt){

    var fireOnThis = obj;
    if( document.createEvent ) {
        var evObj = document.createEvent('MouseEvents');
        evObj.initEvent( evt, true, false );
        fireOnThis.dispatchEvent(evObj);
    } else if( document.createEventObject ) {
        fireOnThis.fireEvent('on'+evt);
    }
}

function closeIframe() {
    parent.document.location = parent.document.location;
}


function get_name(url)
{  
    pars ='&url='+url+ '&sector='+$('sector').value;
    new Ajax.Updater('filterText', '/managers/filter_results', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

//function get_companies(){
//    get_sorted_companies('')
//}
//function get_sorted_companies(sort_by)
//{
//    pars='&type='+$('type').value;
//    pars =pars+'&orderby='+$('orderby').value;
//    if ($('company_geography_id').value!='' && $('company_geography_id').value!='All' ){
//        pars = pars+'&geography='+$('company_geography_id').value;
//    }
//    if ($('company_desired_size').value!=''&& $('company_desired_size').value!='All'){
//        pars =pars+'&size='+$('company_desired_size').value;
//    }
//    if ($('company_asset_id').value!=''&& $('company_asset_id').value!='All'){
//        pars =pars+'&asset='+$('company_asset_id').value;
//    }
//    if ($('company_type_of_financing').value!=''&& $('company_type_of_financing').value!='All'){
//        pars =pars+'&financing='+$('company_type_of_financing').value;
//    }
//    if ($('company_sector_id').value!=''&& $('company_sector_id').value!='All'){
//        pars =pars+'&sector='+$('company_sector_id').value;
//    }
//    if ((sort_by!=null) && (sort_by!=''))
//    {
//        pars =pars+'&sort_by='+sort_by;
//    }
//    new Ajax.Request('/companies/index_results', {
//        method:'put',
//        asynchronous:true,
//        evalScripts:true,
//        parameters:pars
//    });
//}
function populate_organization_type(user_id, plan_id){
    pars='?plan_id='+plan_id+'&user_id='+user_id;
    new Ajax.Request('/admin/organization_types_for_plan', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function hide_div(id){
    $(id).hide();

}

function show_div(id){
    $(id).show();
}
function get_plan_id(user_id, plan_id){
    pars='?plan_id='+plan_id+'&id='+user_id;
    new Ajax.Request('/admin/change_user_profile', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function read_status(id){
    pars='?message_id='+id;
    new Ajax.Request('/users/read_status', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function mark_read(id){
    document.getElementById(id).style.fontWeight='normal';
}
function mark_unread(id){
    document.getElementById(id).style.fontWeight='bold';
}

function mark_deleted(id){
    document.getElementById(id).style.display='none';
}

function search_string(value){
    
    pars='?value='+value;
    new Ajax.Request('/messages/search_string', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function showtab(tab1,tab2){
    if(tab1=="inbox")
    {
        pars='?type='+tab1;
        $("inbox_selected").className += " selected_tab";
        $('sent_selected').className -= " selected_tab";
        document.getElementById('sent_messages').style.display='none';
        //        $('sent_messages').style.display='none';
        $('received_messages').style.display='';
    }
    else
    {
        pars='?type='+tab1;
        $('sent_selected').className += " selected_tab";
        $('inbox_selected').className -= " selected_tab";

        $('received_messages').style.display='none';
        $('sent_messages').style.display='';
    }
    
}

function show_checked(){

    var c_value = "";
    var type
    if ($('inbox_link').className=="selected")
    {
        type="inbox"
    }
    else{
        type="sent"
    }
    for (var i=0; i < document.getElementsByName('meassagecheckbox').length; i++)
    {
        if (document.getElementsByName('meassagecheckbox')[i].checked)
        {
            c_value = c_value + document.getElementsByName('meassagecheckbox')[i].value + ",";
        }
    }
    pars='type='+type+'&message_id='+c_value;
    new Ajax.Request('/users/read_status', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function show_checked_unread(){
    var c_value = "";
    var type
    if ($('inbox_link').className=="selected")
    {
        type="inbox"
    }
    else{
        type="sent"
    }
    for (var i=0; i < document.getElementsByName('meassagecheckbox').length; i++)
    {
        if (document.getElementsByName('meassagecheckbox')[i].checked)
        {
            c_value = c_value + document.getElementsByName('meassagecheckbox')[i].value + ",";
        }
    }
    pars='type='+type+'&message_id='+c_value;
    new Ajax.Request('/users/mark_unread', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function check_all(){
    if ( $('checkall').checked==true){
        for (var i=0; i < document.getElementsByName('meassagecheckbox').length; i++)
        {
            if (!(document.getElementsByName('meassagecheckbox')[i].checked))
            {
                $('check_box'+ document.getElementsByName('meassagecheckbox')[i].value).checked=true;
            }
        }
    }
    else
    {
        for (var j=0; j < document.getElementsByName('meassagecheckbox').length; j++)
        {
            if ((document.getElementsByName('meassagecheckbox')[j].checked))
                $('check_box'+ document.getElementsByName('meassagecheckbox')[j].value).checked=false;
        }
    }
}

function delete_messages(){
    var c_value = "";
    for (var i=0; i < document.getElementsByName('meassagecheckbox').length; i++)
    {
        if (document.getElementsByName('meassagecheckbox')[i].checked)
        {
            c_value = c_value + document.getElementsByName('meassagecheckbox')[i].value + ",";
        }
    }
    var type;
    if ($('inbox_link').className=="selected")
    {
        type="inbox"
    }
    else{
        type="sent"
    }
    pars='type='+type+'&message_id='+c_value;
    new Ajax.Request('/users/delete_messages', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}
function check_all_assets_and_assettypes(id,type){
    var value;
    if($('header_check').checked==true)
    {
        value="check_all"
    }
    else
    {
        value="uncheck_all"
    }
    if (value=="check_all")
    {
        pars='&value='+value+'&id='+id;
    }
    else
    {
        pars='&value='+value+'&id='+id;
    }
    if(type=="classified_funds")
    {
        new Ajax.Request('/classified_funds/check_assets', {
            method:'put',
            asynchronous:true,
            evalScripts:true,
            parameters:pars
        });
    }
    else
    {
        new Ajax.Request('/companies/check_assets', {
            method:'put',
            asynchronous:true,
            evalScripts:true,
            parameters:pars
        });
    }
}


function check_all_assettype(id){
    $(id).checked=true ;
}
function uncheck_all_assettype(id){
    $(id).checked=false ;
}

function add_option(type){
    if (type=="multiple")
        pars='&value='+"multiple";
    else
        pars='&value='+"new_value";
    new Ajax.Request('/questions/add_field', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}
/*function add_radio_option(){
    pars='&value='+"new_value";
    new Ajax.Request('/questions/add_radio_field', {
        method:'put',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}*/

/*function question_type(type){
    pars='&value='+type;
    new Ajax.Request('/questions/question_type', {
        method:'get',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
    
}*/
function change_background(tab1,tab2,tab3,tab4,tab5)
{
    $(tab1).style.color = '#e5e5e5';
    $(tab2).style.backgroundColor = '#fff';
    $(tab3).style.backgroundColor = '#fff';
    $(tab4).style.backgroundColor = '#fff';
    $(tab5).style.backgroundColor = '#fff';



}
function more_options(value){
    pars='&value='+value;
    var len;
    len=document.getElementsByName('add_new_field_div').length;
    if (len==0)
    {
        new Ajax.Request('/questions/more_options', {
            method:'put',
            asynchronous:true,
            evalScripts:true,
            parameters:pars
        });
    }
    else{
        
}
    
}

function hide_more_option(){
    var len;
    len=document.getElementsByName('radio_div').length;
    for (var i = 0; i <len; i++)
    {
        $('radio_div').remove();
    }
    $('add_new_field_div').remove();
}

function hide_options(qid){
    pars='&value='+qid;
    var collection = document.getElementById('radio_option_'+qid).getElementsByTagName('INPUT');
    $('radio_option_'+qid).hide();
    for (var x=0; x<collection.length; x++) {
        if (collection[x].type.toUpperCase()=='CHECKBOX')
            collection[x].checked = false;
    }
}


function show_options(qid){
    pars='&value='+qid;
    var collection = document.getElementById('radio_option_'+qid).getElementsByTagName('INPUT');
    $('radio_option_'+qid).show();
    for (var x=0; x<collection.length; x++) {
        if (collection[x].type.toUpperCase()=='CHECKBOX')
            collection[x].checked = true;
    }
    new Ajax.Request('/questions/show_options', {
        method:'get',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function hide_sectors(id){
    $(id).hide();

}

function select_sectors(id){
    $(id).show();
}

function hide_option(id){
    element_id = id;
    $(element_id).hide();
}

function select_option(id) {
    element_id = id;
    $(element_id).show();
}

function show_descrition(id){
    $(id).show();
}

function hide_description(id){
    $(id).hide();
}

function hide_no(option,qid){
    var collection = document.getElementById('no_div_'+qid).getElementsByTagName('INPUT');
    if(option=="option_no")
    {
        $('no_div_'+qid).hide();
        for (var x=0; x<collection.length; x++) {
            if (collection[x].type.toUpperCase()=='CHECKBOX')
                collection[x].checked = false;
        }
    }
    else
    {
        $('no_div_'+qid).show();
        for (var y=0; y<collection.length; y++){
            if (collection[y].type.toUpperCase()=='CHECKBOX')
                collection[y].checked = true;
        }
    }
}

function edit_add_field(qid){
    pars='&qid='+qid;
    new Ajax.Request('/questions/edit_add_field', {
        method:'get',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });
}

function edit_remove_field(qid,num){
    $('edit_div_'+num).remove();

}
function remove_field(div,num){
    $(div+num).remove();
}

function hide_option_edit(option,qid){
    if(option=="no")
    {
        $('edit_div').hide();
        $('submit_div').hide();
        alert("You cannot update question with option as no.Select option yes. ");
    }
    else
    {
        $('edit_div').show();
        $('submit_div').show();
    }
}
function submitSearchForm(event){
    if ((event.which && event.which == 13) || (event.keyCode && event.keyCode == 13)){
        document.forms[0].submit();
        return true;
    }else
        return false;
}

function show_query(name){
    pars='&name='+name;
    new Ajax.Request('/classified_funds/index_results', {
        method:'get',
        asynchronous:true,
        evalScripts:true,
        parameters:pars
    });

}

function update_rank(ele,old_rank,qid,count){
    var value=ele.options[ele.selectedIndex].text;
    pars='&new_rank='+value+'&id='+qid+'&old_rank='+old_rank;
    new Ajax.Request('/questions/new_rank',{
        method:'get',
        asynchronous:true,
        evalscripts:true,
        parameters:pars
    }
    );

}

function remove_invite(id){
    document.getElementById(id).remove();
  }