<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>jqGrid Sample</title>
</head>

<style>
html, body {
	margin: 10px;			/* Remove body margin/padding */
	padding: 20px;
	overflow: auto;	/* Remove scroll bars on browser window */	
	font: 12px "Lucida Grande", "Lucida Sans Unicode", Tahoma, Verdana;
}
</style>

<script src = "js/jquery-1.10.2.min.js" type = "text/javascript"></script>
<script src = "js/i18n/grid.locale-kr.js" type = "text/javascript"></script>
<script src = "js/jquery.jqGrid.min.js" type = "text/javascript"></script>

<!-- 
<script src="./js/jquery-1.5.2.js"></script>
<script src="./js/jquery.json-2.2.js"></script>

<script src="./js/grid.locale-en.js"></script>
<script src="./js/jquery.jqGrid.min.js"></script>
 -->
<link rel="stylesheet" type="text/css" media="screen" href="./css/sand/grid.css" /> 
<script type="text/javascript">
	/** radioType**/

	function _initGrid(){
		
		/** �ݾ� ���� ���� **/
		var moneyFormat = {decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 0, prefix: "", suffix:"", defaulValue: 0};
		$("#dataTable").jqGrid({
			  datatype: 'local'
		    , colNames: ['����','�� ��', '��ǰ��', '��  ��']
			, colModel: [
					   	{ name: 'select', 	label: 'select', width: 60, 	formatter:radio,		editable:true,	edittype:'custom',	align:'center'} 
					  ,	{ name: 'recSeq', 	index: 'recSeq', width: 60, 	formatter: 'int', 		sorttype:'int', align:'center' }
					  , { name: 'TITLE', 	index: 'TITLE',  width: 130, 	formatter: 'text',		align:'center'}
					  , { name: 'PRICE', 	index: 'PRICE',  width: 130, 	formatter:'currency', 	sorttype:'currency', formatoptions: moneyFormat, align:'right'}	
					  ]
		    , loadui:"disable" 
			, width: 400
		    , height: 100
			, multiselect: false				/** üũ�ڽ� ����  **/
			, footerrow: true					/** �ϴ� ǲ�� ���� **/
	        , userDataOnFooter: true
			, loadComplete: function() {		/** ������ �ε��� �Լ� **/
			}
		    , loadonce: true
			, beforeSelectRow: function (rowid, e) { /** ���� ���ý� �Լ� **/     
				sendCheck(rowid, e);
			} 
		});
	}
	
	function radio(value, options, rowObject){
		var radioHtml = '<input type="radio" name="radioid" />';    
		return radioHtml; 
	} 	
	
	function _callAjax(){
		$("#dataTable").clearGridData(); //������ Ŭ����
		var json_data = [
						 {"TITLE":"���ĸ�",		"PRICE":"1000"},
						 {"TITLE":"�����",		"PRICE":"2000"},
						 {"TITLE":"����",		"PRICE":"1000"},
						 {"TITLE":"�ﰢ���",	"PRICE":"800" },
						 {"TITLE":"�ٳ�������",	"PRICE":"1200"},
						];
		callBack(json_data);
	}
	
	function callBack(json_data){
	    //������ �ε���
	    var recSeq = (Number($("#reqPage").val()) - 1) * Number($("#reqCnt").val());
	    
	    //�ŷ����� Grid Set
	    addData(recSeq, json_data);
	    
	    //Paging
	    $("#pagingView").html(getPaging($("#reqPage").val(), 10)); /** tot count��(10)  **/
	}
	
	function addData(recSeq, mydata){
		/** ������ ����� ó���ϴ°� **/		
		for(var j=0;j<=mydata.length;j++){
		    try {
		    	recSeq = recSeq + 1;
		    	mydata[j].recSeq = recSeq;
		    	
			} catch (e) {
							
			}
			jQuery("#dataTable").addRowData(j+1, mydata[j]);
		}
		$("#acct_tot_cnt").val(mydata.length); //�� ������ �Ǽ�
		var price_sum   = jQuery("#dataTable").getCol('PRICE', false, 'sum');  // �Աݱݾ�
        jQuery("#dataTable").jqGrid('footerData', 'set', { recSeq: '�հ�', PRICE: price_sum});
	}
	
	function sendCheck(rowid, e){
		if ($(e.target).is('input[type="radio"]')) {  
			 var ids = $("#dataTable").jqGrid('getCol', 'select', true);
			 var idx="";
			 for (var i = 0; i < ids.length; i++) {
				 if (ids[i].id != '') { 
					idx = $("#dataTable").jqGrid('getCell', rowid, 'TITLE');  
			 	 }         
			 }
			 alert("TITLE:" + idx);   
		}     
		return true; // allow row selection
	}	
	
	//�ŷ����� ��ȸ
	function uf_gosubmit(){
	    $("#reqPage").val("1");
	    _callAjax();
	}
	
	//����¡ ����    
	function uf_Search(pageIndex) {
	     $("#reqPage").val(pageIndex);        
	     _callAjax();
	}
	
	//Paging(AS-IS JAVA->Script)
	function getPaging(pageIndex, rspn_page){		
		var pagingHtml = ""; 
		pageIndex = Number(pageIndex);
		//Total Page
		rspn_page = Math.ceil(Number(rspn_page) / Number($("#reqCnt").val()));
		
		pagingHtml += "<div id='' class='page fl'>";
		if(rspn_page > 0) {	// �����Ͱ� ������� 
			pagingHtml += "�������� : <select name='TOT_PAGE' onchange='javascript:uf_Search(this.value)'>";
			for(var i=1; i <= rspn_page; i++) {
				pagingHtml += "<option value='"+ i + "' " + (pageIndex == i ? "selected" : "") + ">" + i + "</option>";
			}		
			pagingHtml += "</select> / " + rspn_page;
		}
		pagingHtml += "</div>";
		if(pageIndex < rspn_page) {
			pagingHtml += "<a class='btn_grey03 fr' href='javascript:uf_Search(" + (pageIndex + 1) + ");'><span>����</span></a>";
		}
		return pagingHtml;
	}
	
	/**
	 * ���α׷� ������(entry-point)
	 */
	$(document).ready(function() {
		_initGrid();
		_callAjax();
	});
</script>
<body>
	<table id="dataTable" border="1" bordercolor="#CC6600"></table>
	<!-- Paging -->
	<div id="pagingView"></div>
	
	<input type="hidden" id="reqCnt"       name="reqCnt"  value="5"/><%-- ��û�Ǽ� --%>
    <input type="hidden" id="reqPage"  	   name="reqPage" value="1"/><%-- ��û��������ȣ --%>
    <input type="hidden" id="selectedCount" />						<%-- �׸��� �ο� ���� �Ǽ�  --%>
    
    <!-- Load Image start -->
    <div id="divLoadBody" style="display: none;">
		<img src="" />    		
    </div>
    <!-- Load Image end -->	
</body>