package tfs.web

class BatchTagLib {

	static namespace = "batch"
	

	def mmm = {attrs ->
		out << 
		'''
			<div>
					asdf
			</div>
			<span>hi</span>
			<span>hello</span>
		'''.split("\n").collect{it.trim()}.join(" ")
	}
	
	def individualBatch = {attrs,body ->
//		<fieldset id="specialActions">
//		<label class="duration">Special</label>
//		<label id="start" class="time-format"></label>
//		<label id="end" class="time-format"></label>
//		<div id="special" class="duration_category">
//			<label>Special Batch Actions</label>
//			<input type="button" class="batch_button" value="Execute" id="executeCifNormalization"/>
//			<br/>
//			<span>CIF Normalization</span>
//		</div>
//	</fieldset>
//		<fieldset id="${fieldSetId}">
//		<label class="duration">${durationLabel}</label>
//		<label id="start" class="time-format"></label>
//		<label id="end" class="time-format"></label>
//		<div id="${categoryId}" class="duration_category">
//			<label>${categoryTitle}</label>
//			<input type="button" class="batch_button" value="Execute" id="${buttonId}"/>
//			<br/>
//			<span>${categoryLabel}</span>
//		</div>
//	</fieldset>
		
//		out << "<fieldset id=\"" + attrs.fieldSetId + "\">"
//		out << "<label class=\"duration\">" + attrs.durationLabel + "</label>"
//		out << "</fieldset>"
		def x = "xx"
		def y = "yy"
		out << render(template:"/batch/individual_batch",model:[fieldSetId:"fieldId",durationLabel:"Labels",categoryTitle:"rawr",er:"hmmm"])
		out << body(y)
		
	}
}
