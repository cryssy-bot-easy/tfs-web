function setSelectedEnclosedDocs() {
    var selectedList = $("#documentsEnclosedList").val().split(",");

    $.each(selectedList, function(idx, val) {
        var id = val.toString().replace(/\s+/g, "");
        if (id) {
            $("#grid_list_documents_enclosed").jqGrid("setSelection", id);
            $("#grid_list_documents_enclosed").jqGrid("restoreRow", id);
        }
    });
}

function setSelectedEnclosedInstr() {
    var selectedList = $("#enclosedInstructionList").val().split(",");
    $.each(selectedList, function(idx, val) {
        var id = val.toString().replace(/\s+/g, "");
        if (id) {
            $("#grid_list_instructions").jqGrid("setSelection", id);
        }
    });
}

function editNewInstruction(id) {
    $("#newInstructionId").val(id);

    var data = $("#grid_list_additional_conditions").jqGrid("getRowData", id);

    $("#newInstruction").val(data.instruction);

    loadPopup("popup_addNewInstruction", "addNewInstruction_bg");
    centerPopup("popup_addNewInstruction", "addNewInstruction_bg");
}

function deleteNewInstruction(id) {
    var instruction = $("#grid_list_additional_conditions").jqGrid("getRowData", id).instruction;

    var params = {
        page: 1,
        postData: {
            id: id,
            instruction: instruction,
            add: false
        }
    }

    $("#grid_list_additional_conditions").jqGrid('setGridParam', params).trigger("reloadGrid");
}

function editEnclosedInstruction(id) {
    $("#enclosedInstructionId").val(id);

    var data = $("#grid_list_instructions").jqGrid("getRowData", id);

    $("#enclosedInstruction").val(data.instruction);

    loadPopup("popup_enclosedInstruction", "enclosedInstruction_bg");
    centerPopup("popup_enclosedInstruction", "enclosedInstruction_bg");
}

function setupDocumentsEnclosedInstructionsGrids(){
	var documents_enclosed_url = documentsEnclosedUrl;
	var instructions_url = enclosedInstructionsUrl;
	var additional_conditions_url = additionalInstructionsUrl;

	if($("#documentType").val() == 'DOMESTIC'){
		setupEnclosedDocs('grid_list_documents_enclosed', {width: 780, loadui: "disable", multiselect: true,
	    	gridComplete: setSelectedEnclosedDocs, shrinkToFit: false},
				[['documentName', 'Documents Enclosed', 402, 'left'],
				 ['original1', 'Original', 166, 'right'],
				 ['duplicate1', 'Duplicate', 166, 'right']],
	        'grid_pager_documents_enclosed', documents_enclosed_url, [1,2], [0], 'text');
	} else {
	    setupEnclosedDocs('grid_list_documents_enclosed', {width: 780, loadui: "disable", multiselect: true,
	    	gridComplete: setSelectedEnclosedDocs, shrinkToFit: false},
				[['documentName', 'Documents Enclosed', 405, 'left'],
				 ['original1', '1st lot', 75, 'right'],
				 ['original2', '2nd lot', 75, 'right'],
				 ['duplicate1', '1st lot', 75, 'right'],
				 ['duplicate2', '2nd lot', 75, 'right']],
	        'grid_pager_documents_enclosed', documents_enclosed_url, [1,2,3,4], [0], 'text');
	    
		insertColumnGroupHeaders($("#grid_list_documents_enclosed"), false, [
			{startColumnName: 'original1', numberOfColumns: 2, titleText: 'Original'},
			{startColumnName: 'duplicate1', numberOfColumns: 2, titleText: 'Duplicate'}
		]);
	}

	setupJqGridWidth('grid_list_instructions', {width: 780, loadui: "disable", multiselect: true, gridComplete: setSelectedEnclosedInstr},
			[['instruction', 'Instructions', 11, 'left'],
			 ['edit', 'Edit', 1, 'center']], instructions_url);
	
	setupJqGridWidth('grid_list_additional_conditions', {width: 780, loadui: "disable"},
			[['instruction', 'Additional Instructions', 10, 'left'],
			 ['edit', 'Edit', 1, 'center'],
			 ['del', 'Delete', 1, 'center']], additional_conditions_url);
}

function initDocumentsEnclosedInstructionsGrid(){
	setupDocumentsEnclosedInstructionsGrids();
}

//functions needed to create header columns with sub columns
//TODO: move to more general javascript file.
function denySelectionOnDoubleClick ($el) {
    if ($.browser.mozilla) {//Firefox
        $el.css('MozUserSelect', 'none');
    } else if ($.browser.msie) {//IE
        $el.bind('selectstart', function () {
            return false;
        });
    } else {//Opera, etc.
        $el.mousedown(function () {
            return false;
        });
    }
}

function inColumnHeader (text, columnHeaders) {
    var i = 0, length = columnHeaders.length;
    for (; i < length; i++) {
        if (columnHeaders[i].startColumnName === text) {
            return i;
        }
    }

    return -1;
}

function insertColumnGroupHeaders ($mygrid, useColSpanStyle, columnGroupHeaders) {
    var ts = $mygrid[0], p = ts.p, i, cmi, skip = 0, $tr, $colHeader, th, $th, thStyle,
        iCol,
        cghi,
        startColumnName,
        numberOfColumns,
        titleText,
        cVisibleColumns,
        colModel = p.colModel,
        cml = colModel.length,
        ths = ts.grid.headers,
        $gview = $mygrid.closest("div.ui-jqgrid-view"),
        $gbox = $gview.parent(),
        $bdiv = $gview.children("div.ui-jqgrid-bdiv"),
        $hdiv = $gview.children("div.ui-jqgrid-hdiv"),
        $htable = $hdiv.children("div.ui-jqgrid-hbox").children("table.ui-jqgrid-htable"),
        $trLabels = $htable.children("thead").children("tr.ui-jqgrid-labels:last"),
        $thead = $htable.children("thead"),
        $theadInTable,
        originalResizeStop,
        $firstHeaderRow = $('<tr>', {role: "row", "aria-hidden": "true"}).addClass("jqg-first-row-header").css("height", "auto"),
        $firstRow;

    $mygrid.prepend($thead);
    $tr = $('<tr>', {role: "rowheader"}).addClass("ui-jqgrid-labels");
    for (i = 0; i < cml; i++) {
        th = ths[i].el;
        $th = $(th);
        denySelectionOnDoubleClick($th); // needed for Firefox to prevent selection on doubleclick
        cmi = colModel[i];

        // build the next cell for the first header row
        thStyle = {height: '0px', width: ths[i].width + 'px', display: (cmi.hidden ? 'none' : '')};
        $("<th>", {role: 'gridcell'}).css(thStyle).appendTo($firstHeaderRow);

        th.style.width = ""; // remove unneeded style
        iCol = inColumnHeader(cmi.name, columnGroupHeaders);
        if (iCol >= 0) {
            cghi = columnGroupHeaders[iCol];
            startColumnName = cghi.startColumnName;
            numberOfColumns = cghi.numberOfColumns;
            titleText = cghi.titleText;

            // caclulate the number of visible columns from the next numberOfColumns columns
            for (cVisibleColumns = 0, iCol = 0; iCol < numberOfColumns && (i + iCol < cml); iCol++) {
                if (!colModel[i + iCol].hidden) {
                    cVisibleColumns++;
                }
            }

            // The next numberOfColumns headers will be moved in the next row
            // in the current row will be placed the new column header with the titleText.
            // The text will be over the cVisibleColumns columns
            $colHeader = $('<th>', {colspan: String(cVisibleColumns), role: "columnheader"})
                .addClass("ui-state-default ui-th-column-header ui-th-ltr")
                .html(titleText);
            if (p.headertitles) {
                $colHeader.attr("title", $colHeader.text());
            }
            denySelectionOnDoubleClick($colHeader);

            $th.before($colHeader); // insert new column header before the current
            $tr.append(th);         // move the current header in the next row

            // set the coumter of headers which will be moved in the next row
            skip = numberOfColumns - 1;
        } else {
            if (skip === 0) {
                if (useColSpanStyle) {
                    // expand the header height to two rows
                    $th.attr("rowspan", "2");
                } else {
                    $('<th>', {role: "columnheader"})
                        .addClass("ui-state-default ui-th-column-header")
                        .css("display", cmi.hidden ? 'none' : '')
                        .insertBefore($th);
                    $tr.append(th);
                }
            } else {
                // move the header to the next row
                $th.css({"padding-top": "2px", height: "19px"});
                $tr.append(th);
                skip--;
            }
        }
    }
    $theadInTable = $mygrid.children("thead");
    $theadInTable.prepend($firstHeaderRow);
    $tr.insertAfter($trLabels);
    $htable.append($theadInTable);

    if (useColSpanStyle) {
        // Increase the height of resizing span of visible headers
        $htable.find("span.ui-jqgrid-resize").each(function () {
            var $parent = $(this).parent();
            if ($parent.is(":visible")) {
                this.style.cssText = 'height: ' + $parent.height() + 'px !important; cursor: col-resize;';
            }
        });

        // Set position of the sortable div (the main lable)
        // with the column header text to the middle of the cell.
        // One should not do this for hidden headers.
        $htable.find("div.ui-jqgrid-sortable").each(function () {
            var $ts = $(this), $parent = $ts.parent();
            if ($parent.is(":visible")) {
                $ts.css('top', ($parent.height() - $ts.outerHeight()) / 2 + 'px');
            }
        });
    }

    // Preserve original resizeStop event if any defined
    if ($.isFunction(p.resizeStop)) {
        originalResizeStop = p.resizeStop;
    }
    $firstRow = $theadInTable.find("tr.jqg-first-row-header");
    p.resizeStop = function (nw, idx) {
        var newWidth = this.newWidth;

        $firstRow.find("th:nth-child(" + (idx + 1) + ")").width(nw);

        // ajust the size of gview, gbox and the pager base on the width of htable
        $gview.width(newWidth);
        $gbox.width(newWidth);
        $bdiv.width(newWidth);
        $hdiv.width(newWidth);
        $gbox.children("div.ui-jqgrid-pager").width(newWidth);     // set pager width
        $gview.children("div.ui-jqgrid-toppager").width(newWidth); // set toppager width
        $gview.children("div.ui-jqgrid-sdiv").width(newWidth);     // set footer width

        if ($.isFunction(originalResizeStop)) {
            originalResizeStop.call(ts, nw, idx);
        }
    };
}

//method that returns array range for numbers and letters
//TODO: move script to separate file.
Array.range = function(a, b, step){
    var A = [];
    if(typeof a == 'number'){
        A[0] = a;
        step = step || 1;
        while(a + step <= b){
            A[A.length] = a += step;
        }
    }
    else{
        var s = 'abcdefghijklmnopqrstuvwxyz';
        if(a === a.toUpperCase()){
            b = b.toUpperCase();
            s = s.toUpperCase();
        }
        s = s.substring(s.indexOf(a), s.indexOf(b) + 1);
        A = s.split('');        
    }
    return A;
}


$(initDocumentsEnclosedInstructionsGrid);