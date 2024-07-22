//setup jqgrid editable without pager
function setupJqGridWithEditable(id, userParams, colModel, urlView,
		editableCols, editableRows, edittype) {
	var grid_id = '#' + id;

	var lastselected;
	var rowIndex;

	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 110,
		scrollOffset : 0,
		onSelectRow : function(id) {
			var id = $(grid_id).jqGrid('getGridParam', 'selrow');
			rowIndex = $(grid_id).jqGrid('getInd', id);

			if (id && id !== lastselected) {
				var setEditRows = false;

				$.each(editableRows, function(idx, val) {
					if (rowIndex == val) {
						setEditRows = true;
					}
				});

				if (setEditRows == true) {
					jQuery(grid_id).restoreRow(lastselected);
					jQuery(grid_id).editRow(id, true);
					lastselected = id;
				} else {
					jQuery(grid_id).restoreRow(lastselected);
					lastselected = id;
				}
			}
		},
		editurl : '#'
	};

	if (userParams)
		$.extend(params, userParams);

	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var setEdit = false;
			var setFormatter = null;
			var setFormatOptions = null;

			var col = colModel[i];

			$.each(editableCols, function(idx, val) {
				if (i == val) {
					setEdit = true;
					setFormatter = 'number';
					setFormatOptions = {
						decimalSeparator : ".",
						thousandsSeparator : ",",
						decimalPlaces : 4
					};
				}
			})

			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					align : col[2],
					editable : setEdit,
					edittype : edittype,
					formatter : setFormatter,
					formatoptions : setFormatOptions
				});
			} catch (e) {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					editable : true
				});
			}
		}
		params.colModel = _colModel;
	}
	return jQuery('#' + id).jqGrid(params);
}

function setupJqGridPagerNotSortable(id, userParams, colModel, grid_pager_id,
		urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 780,
		height : 250,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					sortable : false
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						sortable : false
					});
				} catch (e2) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						sortable : false
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid with pager
function setupJqGridPager(id, userParams, colModel, grid_pager_id, urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 780,
		height : 250,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2]
					});
				} catch (e2) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1]
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

function setupJqGridPagerTest(id, userParams, colModel, grid_pager_id, urlView) {
	var params = {
		url : urlView, // "local",
		datatype : "local",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 780,
		height : 250,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2]
					});
				} catch (e2) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1]
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid w/o pager
function setupJqGridNoPager(id, userParams, colModel, grid_pager_id, urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 780,
		height : 250,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					align : col[2]
				});
			} catch (e) {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1]
				});
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid with pager and summary
function setupJqGridPagerSummary(id, userParams, colModel, grid_pager_id,
		urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : jQuery('#' + grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 250,
		footerrow : true,
		userDataOnFooter : true
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			_colModel.push({
				name : col[0],
				index : col[0],
				label : col[1]
			});
		}
		params.colModel = _colModel;
	}
	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid that can hide columns
function setupJqGridPagerWithHidden(id, userParams, colModel, grid_pager_id,
		urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : jQuery('#' + grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 250
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];

			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					align : col[2],
					hidden : col[3],
					width : col[4]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						align : col[2],
						hidden : col[3]
					});
				} catch (e2) {
					try {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1],
							width : col[2]
						});
					} catch (e3) {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1]
						});
					}
				}
			}
		}
		params.colModel = _colModel;
	}
	return jQuery('#' + id).jqGrid(params);
}

function setupJqGridPagerWithHiddenTest(id, userParams, colModel,
		grid_pager_id, urlView) {
	var params = {
		url : urlView,
		// datatype : "json",
		datatype : "local",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : jQuery('#' + grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 250
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];

			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					align : col[2],
					hidden : col[3],
					width : col[4]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						align : col[2],
						hidden : col[3]
					});
				} catch (e2) {
					try {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1],
							width : col[2]
						});
					} catch (e3) {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1]
						});
					}
				}
			}
		}
		params.colModel = _colModel;
	}
	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid with pager with mouseover
function setupJqGridHiddenMouseOver(id, userParams, colModel, grid_pager_id,
		urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 250,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					hidden : col[2]
				});
			} catch (e) {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1]
				});
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params, {
		gridComplete : function() {

			$(".jqgrow").mouseover(function() {
				var rowId = $(this).attr("id");
				var rowData = $('#' + id).jqGrid("getRowData", rowId)
				// var rowData = $(id).jqGrid("getRowData", rowId) -- Syntax
				// Error, unrecognized expression: #..?
				updateRowData(rowData);
			});
		}
	})

	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid with varying width
function setupJqGridWidth(id, userParams, colModel, urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		// pager: '#'+grid_pager_id,//jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : "auto",
		shrinkToFit : true,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2]
					});
				} catch (e2) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1]
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

function setupJqGridWidthTest(id, userParams, colModel, urlView) {
	var params = {
		url : urlView,
		datatype : "local",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		// pager: '#'+grid_pager_id,//jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : "auto",
		shrinkToFit : true,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2]
					});
				} catch (e2) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1]
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

function setupAccountingEntriesGrid(id, userParams, colModel, grid_pager_id) {
	var params = {
		datatype : "local",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : "auto",
		shrinkToFit : true,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2]
					});
				} catch (e2) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1]
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

function setupJqGridWidthNoPagerHiddenNotSortable(id, userParams, colModel,
		urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 100,
		rowList : [ 10, 20, 30 ],
		viewrecords : true,
		width : 800,
		height : 250,
		shrinkToFit : true,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					hidden : col[4],
					sortable : false
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						align : col[3],
						sortable : false
					});
				} catch (e2) {
					try {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1],
							width : col[2],
							sortable : false
						});
					} catch (e3) {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1],
							sortable : false
						});
					}
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

function setupJqGridWidthNoPagerHidden(id, userParams, colModel, urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 250,
		shrinkToFit : true,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					hidden : col[4]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						align : col[3]
					});
				} catch (e2) {
					try {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1],
							width : col[2]
						});
					} catch (e3) {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1]
						});
					}
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

function setupJqGridWidthNoPagerHiddenShort(id, userParams, colModel, urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 330,
		height : 250,
		shrinkToFit : true,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					hidden : col[4]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						align : col[3]
					});
				} catch (e2) {
					try {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1],
							width : col[2]
						});
					} catch (e3) {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1]
						});
					}
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

// refund
function setupJqGridWidthPagerHiddenRefund(id, userParams, colModel,
		grid_pager_id, urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 250,
		shrinkToFit : true,
		scrollOffset : 0,
		footerrow : true,
		userDataOnFooter : true
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					hidden : col[4]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						align : col[3]
					});
				} catch (e2) {
					try {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1],
							width : col[2]
						});
					} catch (e3) {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1]
						});
					}
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid with varying width and pager
function setupJqGridWidthPagerHidden(id, userParams, colModel, grid_pager_id,
		urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 250,
		shrinkToFit : true,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					hidden : col[4]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						align : col[3]
					});
				} catch (e2) {
					try {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1],
							width : col[2]
						});
					} catch (e3) {
						_colModel.push({
							name : col[0],
							index : col[0],
							label : col[1]
						});
					}
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid with varying width and edittable columns
function setupJqGridWidthEditable(id, userParams, colModel, urlView,
		editableCols, editableRows, edittype) {
	var grid_id = '#' + id;

	var lastselected;
	var rowIndex;

	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : "auto",
		shrinkToFit : true,
		scrollOffset : 0,
		onSelectRow : function(id) {
			var id = $(grid_id).jqGrid('getGridParam', 'selrow');
			rowIndex = $(grid_id).jqGrid('getInd', id);

			if (id && id !== lastselected) {
				var setEditRows = false;

				$.each(editableRows, function(idx, val) {
					if (rowIndex == val) {
						setEditRows = true;
					}
				});

				if (setEditRows == true) {
					jQuery(grid_id).restoreRow(lastselected);
					jQuery(grid_id).editRow(id, true);
					lastselected = id;
				} else {
					jQuery(grid_id).restoreRow(lastselected);
					lastselected = id;
				}
			}
		},
		editurl : '#'
	};

	if (userParams)
		$.extend(params, userParams);

	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var setEdit = false;
			var setFormatter = null;
			var setFormatOptions = null;

			var col = colModel[i];

			$.each(editableCols, function(idx, val) {
				if (i == val) {
					setEdit = true;
					setFormatter = 'number';
					setFormatOptions = {
						decimalSeparator : ".",
						thousandsSeparator : ",",
						decimalPlaces : 4
					};
				}
			})

			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					editable : setEdit,
					edittype : edittype,
					formatter : setFormatter,
					formatoptions : setFormatOptions
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						editable : true
					});
				} catch (f) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						editable : true
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid with pager, varying width and edittable columns
function setupJqGridWidthPagerEditable(id, userParams, colModel, grid_pager_id,
		urlView, editableCols, editableRows, edittype) {
	var grid_id = '#' + id;

	var lastselected;
	var rowIndex;

	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : "auto",
		shrinkToFit : true,
		scrollOffset : 0,
		onSelectRow : function(id) {
			var id = $(grid_id).jqGrid('getGridParam', 'selrow');
			rowIndex = $(grid_id).jqGrid('getInd', id);

			if (id && id !== lastselected) {
				var setEditRows = false;

				$.each(editableRows, function(idx, val) {
					if (rowIndex == val) {
						setEditRows = true;
					} else if (val == 0) { // Workaround for editable rows.
						// Enables all rows to be edited.
						setEditRows = true;
					}
				});

				if (setEditRows == true) {
					jQuery(grid_id).restoreRow(lastselected);
					jQuery(grid_id).editRow(id, true);
					lastselected = id;
				} else {
					jQuery(grid_id).restoreRow(lastselected);
					lastselected = id;
				}
			}
		},
		editurl : '#'
	};

	if (userParams)
		$.extend(params, userParams);

	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var setEdit = false;
			var setFormatter = null;
			var setFormatOptions = null;

			var col = colModel[i];

			$.each(editableCols, function(idx, val) {
				if (i == val) {
					setEdit = true;
					// setFormatter = 'text';
					// setFormatOptions = {decimalSeparator:".",
					// thousandsSeparator: ",", decimalPlaces: 4};
				}
			})

			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					editable : setEdit,
					edittype : edittype,
					formatter : setFormatter,
					formatoptions : setFormatOptions
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						editable : true
					});
				} catch (f) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						editable : true
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	return jQuery('#' + id).jqGrid(params);
}

function setupEnclosedDocs(id, userParams, colModel, grid_pager_id, urlView,
		editableCols, editableRows, edittype) {
	var grid_id = '#' + id;

	var lastselected;
	var rowIndex;

	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		// via Ton, show data in one page
		// rowNum : 10,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 250,
		shrinkToFit : true,
		scrollOffset : 0,
		onSelectRow : function(id) {
			var id = $(grid_id).jqGrid('getGridParam', 'selrow');
			rowIndex = $(grid_id).jqGrid('getInd', id);

			if (id && id !== lastselected) {
				var setEditRows = false;

				$.each(editableRows, function(idx, val) {
					if (rowIndex == val) {
						setEditRows = true;
					} else if (val == 0) { // Workaround for editable rows.
						// Enables all rows to be edited.
						setEditRows = true;
					}
				});

				if (setEditRows == true) {
					jQuery(grid_id).restoreRow(lastselected);
					// jQuery("#grid_id").editRow(rowid, keys, oneditfunc,
					// succesfunc, url, extraparam, aftersavefunc, errorfunc,
					// afterrestorefunc);
					jQuery(grid_id).editRow(id, true, null, null, urlView,
							null, function(id) {
								// alert(id)
								// setupAddedTransmittalLetters();
								lastselected = null;
							}, null, null);
					// lastselected = id;
				} else {
					jQuery(grid_id).restoreRow(lastselected);
					lastselected = id;
				}
			}
		}
	};

	if (userParams)
		$.extend(params, userParams);

	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var setEdit = false;
			var setFormatter = null;
			var setFormatOptions = null;

			var col = colModel[i];

			$.each(editableCols, function(idx, val) {
				if (i == val) {
					setEdit = true;
					// setFormatter = 'number';
					// setFormatOptions = {
					// decimalSeparator : ".",
					// thousandsSeparator : ",",
					// decimalPlaces : 0
					// };
				}
			})

			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					editable : setEdit,
					edittype : edittype,
				// formatter : setFormatter,
				// formatoptions : setFormatOptions
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						editable : true
					});
				} catch (f) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						editable : true
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	return jQuery('#' + id).jqGrid(params);
}

/*******************************************************************************
 * 
 * 
 * The following will be the same functions but uses class attribute as
 * identifier instead of id.
 * 
 * 
 */

// setup jqgrid with varying width using class
function setupJqGridWidthClass(id, userParams, colModel, urlView) {
	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		// pager: '#'+grid_pager_id,//jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : "auto",
		shrinkToFit : true,
		scrollOffset : 0
	};

	if (userParams)
		$.extend(params, userParams);
	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var col = colModel[i];
			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3]
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2]
					});
				} catch (e2) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1]
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	$.extend(params);

	return jQuery('.' + id).jqGrid(params);
}

// setup jqgrid with varying width and edittable columns
function setupJqGridWidthEditableClass(id, userParams, colModel, urlView,
		editableCols, editableRows, edittype) {
	var grid_id = '.' + id;

	var lastselected;
	var rowIndex;

	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 10,
		rowList : [ 10, 20, 30 ],
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : "auto",
		shrinkToFit : true,
		scrollOffset : 0,
		onSelectRow : function(id) {
			var id = $(grid_id).jqGrid('getGridParam', 'selrow');
			rowIndex = $(grid_id).jqGrid('getInd', id);

			if (id && id !== lastselected) {
				var setEditRows = false;

				$.each(editableRows, function(idx, val) {
					if (rowIndex == val) {
						setEditRows = true;
					}
				});

				if (setEditRows == true) {
					jQuery(grid_id).restoreRow(lastselected);
					jQuery(grid_id).editRow(id, true);
					lastselected = id;
				} else {
					jQuery(grid_id).restoreRow(lastselected);
					lastselected = id;
				}
			}
		},
		editurl : 'javascript:void(0)'
	};

	if (userParams)
		$.extend(params, userParams);

	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var setEdit = false;
			var setFormatter = null;
			var setFormatOptions = null;

			var col = colModel[i];

			$.each(editableCols, function(idx, val) {
				if (i == val) {
					setEdit = true;
					setFormatter = 'number';
					setFormatOptions = {
						decimalSeparator : ".",
						thousandsSeparator : ",",
						decimalPlaces : 4
					};
				}
			})

			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					editable : setEdit,
					edittype : edittype,
					formatter : setFormatter,
					formatoptions : setFormatOptions
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						editable : true
					});
				} catch (f) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						editable : true
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	return jQuery('.' + id).jqGrid(params);
}

// setup jqgrid with varying width and edittable columns
function setupClientsDocumentsGrid(id, userParams, colModel, urlView,
		editableCols, editableRows, edittype) {
	var grid_id = '#' + id;

	var lastselected;
	var rowIndex;

	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 100,
		rowList : [ 10, 20, 30 ],
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : "auto",
		shrinkToFit : true,
		scrollOffset : 0,
		onSelectRow : function(id) {
			rowIndex = $(grid_id).jqGrid('getInd', id);

			var selectedRows = $(grid_id).jqGrid("getGridParam", "selarrrow");

			var exist = 0;

			for (i = 0; i < selectedRows.length; i++) {
				if (selectedRows[i] == id) {
					exist++;
				}
			}

			if (exist > 0) {

				var setEditRows = false;

				$.each(editableRows, function(idx, val) {
					if (rowIndex == val) {
						setEditRows = true;
					}
				});

				if (setEditRows == true) {
					jQuery(grid_id).restoreRow(lastselected);
					// jQuery(grid_id).editRow(id, true);
					jQuery(grid_id)
							.editRow(
									id,
									true,
									null,
									null,
									urlView,
									null,
									function() {
										formChanged = "#detailsTransmittalLetterTabForm";
										formIsChanged = true;
									}, null, null);
				} else {
					jQuery(grid_id).restoreRow(id);
				}
			} else {
				jQuery(grid_id).restoreRow(id);
			}
		}
	// editurl : '#'
	};

	if (userParams)
		$.extend(params, userParams);

	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var setEdit = false;
			var setFormatter = null;
			var setFormatOptions = null;

			var col = colModel[i];

			$.each(editableCols, function(idx, val) {
				if (i == val) {
					setEdit = true;
//					setFormatter = 'number';
//					setFormatOptions = {
//						decimalSeparator : ".",
//						thousandsSeparator : ",",
//						decimalPlaces : 0
//					};
				}
			})

			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					editable : setEdit,
					edittype : edittype,
//					formatter : setFormatter,
//					formatoptions : setFormatOptions
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						editable : true
					});
				} catch (f) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						editable : true
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	return jQuery('#' + id).jqGrid(params);
}

// setup jqgrid with varying width and edittable columns
function setupTransmittalLetterGrid(id, userParams, colModel, grid_pager_id,
		urlView, editableCols, editableRows, edittype) {
	var grid_id = '#' + id;

	var lastselected;
	var rowIndex;

	var params = {
		url : urlView,
		datatype : "json",
		altRows : true,
		rowNum : 1000,
		rowList : [ 10, 20, 30 ],
		pager : '#' + grid_pager_id,// jQuery('#'+grid_pager_id),
		viewrecords : true,
		sortname : 'id',
		sortorder : "desc",
		width : 800,
		height : 250,
		shrinkToFit : true,
		scrollOffset : 0,
		onSelectRow : function(id) {
			var id = $(grid_id).jqGrid('getGridParam', 'selrow');
			rowIndex = $(grid_id).jqGrid('getInd', id);

			if (id && id !== lastselected) {
				var setEditRows = false;

				$.each(editableRows, function(idx, val) {
					if (rowIndex == val) {
						setEditRows = true;
					}
				});

				if (setEditRows == true) {
					jQuery(grid_id).restoreRow(lastselected);
					// jQuery("#grid_id").editRow(rowid, keys, oneditfunc,
					// succesfunc, url, extraparam, aftersavefunc, errorfunc,
					// afterrestorefunc);
					jQuery(grid_id)
							.editRow(
									id,
									true,
									null,
									null,
									urlView,
									null,
									function(id) {
										setupAddedTransmittalLetters();
										lastselected = null;
										formChanged = "#detailsTransmittalLetterTabForm";
										formIsChanged = true;
									}, null, null);
					// lastselected = id;
				} else {
					jQuery(grid_id).restoreRow(lastselected);
					lastselected = id;
				}
			}
		}
	};

	if (userParams)
		$.extend(params, userParams);

	if (colModel) {
		var _colModel = [];
		for ( var i = 0; i < colModel.length; i++) {
			var setEdit = false;
			var setFormatter = null;
			var setFormatOptions = null;

			var col = colModel[i];

			$.each(editableCols, function(idx, val) {
				if (i == val) {
					setEdit = true;
					// setFormatter = 'number';
					// setFormatOptions = {
					// decimalSeparator : ".",
					// thousandsSeparator : ",",
					// decimalPlaces : 0
					// };
				}
			})

			try {
				_colModel.push({
					name : col[0],
					index : col[0],
					label : col[1],
					width : col[2],
					align : col[3],
					editable : setEdit,
					edittype : edittype,
				// formatter : setFormatter,
				// formatoptions : setFormatOptions
				});
			} catch (e) {
				try {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						width : col[2],
						editable : true
					});
				} catch (f) {
					_colModel.push({
						name : col[0],
						index : col[0],
						label : col[1],
						editable : true
					});
				}
			}
		}
		params.colModel = _colModel;
	}
	return jQuery('#' + id).jqGrid(params);
}