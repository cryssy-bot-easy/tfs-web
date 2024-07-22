// this is used for opening only
function onBasicDetailsClick() {
	formId = "#basicDetailsTabForm";
}

function onAttachedDocumentsClick() {
	formId = "#attachedDocumentsTabForm";	
}

function onAdditionalDetailsClick() {
	formId = "#additionalDetailsTabForm";
}

function onImporterExporterDetailsClick() {
	formId = "#importerExporterDetailsTabForm";
}

function onDetailsOfGuaranteeClick() {
	formId = "#detailsOfGuaranteeTabForm";
}

function onShipmentOfGoodsClick() {
	formId = "#shipmentOfGoodsTabForm";
}

function onDocumentsRequiredClick() {
	formId = "#documentsRequiredTabForm";
}

function onOtherDocumentsInstructionsClick() {
	formId = "#otherDocumentsInstructionsTabForm";
}

function onAdditionalCondition1Click() {
	formId = "#additionalCondition1TabForm";
}

function onAdditionalCondition2Click() {
	formId = "#additionalCondition2TabForm";
}

function onInstructionsAndRoutingClick() {
	formId = "#instructionsAndRoutingTabForm";
}

function onDetailsForMT202TabClick(){
	formId = "#detailsForMT202TabForm";
}

function onNarrativeTabClick(){
	formId = "#narrativeTabForm";
}

//function onLoanDetailsTabClick(){
//	formId = "#loanDetailsTabForm";
//}

function onSettlementToBeneficiaryTabClick(){
	formId = "#proceedsDetailsTabForm";
}

function onMt103TabClick(){
	formId = "#mt103TabForm";
}

function onPddtsTabClick(){
	formId = "#pddtsTabForm";
}

function onDetailsForMT799TabClick(){
	formId = "#detailsForMt799TabForm";
}

function onDetailsTransmittalLetterTabClick(){
	formId = "#detailsTransmittalLetterTabForm";
}

function onChargesPaymentTabClick(){
	formId = "#chargesPaymentTabForm"
}

function onDiscrepancyTabClick(){
	formId = "#discrepancyTabForm"
}

function onMt202TabClick(){
	formId = "#mt202TabForm"
}

function onMt752TabClick(){
	formId = "#mt752TabForm"
}

function onCashLcPaymentClick() {
	formId = "#cashLcPaymentTabForm";
}


function initializeForms() {
	// check if element exists
	if($("#basicDetailsTab").length > 0) {
		$("#basicDetailsTab").click(onBasicDetailsClick);		
	}
	// check if element exists	
	if($("#attachedDocumentsTab").length > 0) {
		$("#attachedDocumentsTab").click(onAttachedDocumentsClick);		
	}
	// check if element exists
	if($("#additionalDetailsTab").length > 0) {
		$("#additionalDetailsTab").click(onAdditionalDetailsClick);		
	}
	// check if element exists
	if($("#importerExporterDetailsTab").length > 0) {
		$("#importerExporterDetailsTab").click(onImporterExporterDetailsClick);		
	}
	// check if element exists
	if($("#detailsOfGuaranteeTab").length > 0) {
		// for cash only
		$("#detailsOfGuaranteeTab").click(onDetailsOfGuaranteeClick);		
	}
	// check if element exists
	if($("#shipmentOfGoodsTab").length > 0) {
		$("#shipmentOfGoodsTab").click(onShipmentOfGoodsClick);		
	}
	
	// check if element exists
	if($("#documentsRequiredTab").length > 0) {
		$("#documentsRequiredTab").click(onDocumentsRequiredClick);		
	}
	
	if($("#otherDocumentsInstructionsTab").length > 0) {
		$("#otherDocumentsInstructionsTab").click(onOtherDocumentsInstructionsClick);		
	}
	
	if($("#additionalCondition1Tab").length > 0) {
		$("#additionalCondition1Tab").click(onAdditionalCondition1Click);
	}
	
	if($("#additionalCondition2Tab").length > 0) {
		$("#additionalCondition2Tab").click(onAdditionalCondition2Click);
	}
	
	// check if element exists
	if($("#instructionsRoutingTab").length > 0) {
		$("#instructionsRoutingTab").click(onInstructionsAndRoutingClick);		
	}	
	
	if($("#detailsForMT202Tab").length>0){
		$("#detailsForMT202Tab").click(onDetailsForMT202TabClick);
	}
	
	if($("#narrativeTab").length>0){
		$("#narrativeTab").click(onNarrativeTabClick);
	}
	
	if($("#loanDetailsTab").length>0){
		$("#loanDetailsTab").click(onLoanDetailsTabClick);
	}
	
	if($("#proceedsDetailsTab").length>0){
		$("#proceedsDetailsTab").click(onSettlementToBeneficiaryTabClick);
	}
	
	if($("#mt103Tab").length>0){
		$("#mt103Tab").click(onMt103TabClick);
	}
	
	if($("#pddtsTab").length>0){
		$("#pddtsTab").click(onPddtsTabClick);
	}
	
	if($("#detailsForMT799Tab").length>0){
		$("#detailsForMT799Tab").click(onDetailsForMT799TabClick);
	}
	
	if($("#detailsTransmittalLetterTab").length>0){
		$("#detailsTransmittalLetterTab").click(onDetailsTransmittalLetterTabClick);
	}
	
	if ($("#chargesPaymentTab").length>0){
		$("#chargesPaymentTab").click(onChargesPaymentTabClick);
	}
	
	if ($("#discrepancyTab").length>0){
		$("#discrepancyTab").click(onDiscrepancyTabClick);
	}
	
	if ($("#mt202Tab").length>0){
		$("#mt202Tab").click(onMt202TabClick);
	}

	if ($("#mt752Tab").length>0){
		$("#mt752Tab").click(onMt752TabClick);
	}
	// check if element exists
	if($("#cashLcPaymentTab").length > 0) {
		$("#cashLcPaymentTab").click(onCashLcPaymentClick);
	}

//    //if(!tradeServiceId){
//	if(!tradeServiceIdHolder) {
//        $("#tab_container").tabs({disabled: tabsToDisable})
//    }
}

$(initializeForms);