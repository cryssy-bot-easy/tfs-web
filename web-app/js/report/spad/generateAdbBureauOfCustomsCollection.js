function generateAdbBureauOfCustomsCollection() {
	var tmpAdbBureauOfCustomsCollectionUrl = adbBureauOfCustomsCollectionUrl;
	
	window.open(tmpAdbBureauOfCustomsCollectionUrl);
}

$(document).ready(function() {
	$("#adbBureauOfCustomsCollectionSpad").click(generateAdbBureauOfCustomsCollection);
});