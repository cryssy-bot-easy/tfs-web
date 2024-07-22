package com.ucpb.tfsweb.admin

import java.util.Currency;
import java.util.Date;
import java.util.regex.Pattern
import net.ipc.utils.UploaderUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import net.ipc.utils.UploaderUtils
import com.ibm.icu.text.StringSearch;

/**
 * 
 * @author itdcon8
 * 
 * @deprecated<br/>
 * Relocated to Batch Processing
 */
@Deprecated
class UploadRmaController {

	def coreAPIService
	def uploadRmaService
	def grailsApplication
	
    def index() {
//		render(view:"/admin/rma/view")
//		Comment out since the URL is accessible during login using copy-paste of URL link.
//		thus this functionis no longer being used by TFS.
		
		forward controller: "login", action: "login"
	}
	
	def uploadFile(){
		// http://www.intelligrape.com/blog/2012/08/31/groovy-http-builder-for-sending-multipart-file/
		try{
			//handle uploaded file
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request
			MultipartFile uploadedFile = multiRequest.getFile("inputFile")
			String fileName = uploadedFile.getOriginalFilename()
			String fileSuffix = fileName.substring(fileName.lastIndexOf("."), fileName.length())?.toLowerCase()
			
			switch(fileSuffix){
				case ".txt":
					UploaderUtils uploaderUtils = new UploaderUtils();
					String destinationUrl = grailsApplication.config.tfs.core.api.webapi.url + "refBank/bankDetails/processRefBanks"
					def result=uploaderUtils.sendMultiPartFile((CommonsMultipartFile) uploadedFile,  destinationUrl)
					switch(result?.responseType){
						case "success":
							flash.message="SUCCESSFULLY PROCESSED $result.successRows ROWS OUT OF $result.totalRows ROWS"
							break;
						case "error":
							flash.message="FAILED TO PROCESS $result.failRows ROWS OUT OF $result.totalRows ROWS"
							break;
						case "exception":
							flash.message="CRITICAL ERROR: $result.errorCode -> $result.description"
							break;
					}
					break; 
				case ".xml":
					UploaderUtils uploaderUtils = new UploaderUtils();
					String destinationUrl = grailsApplication.config.tfs.core.api.webapi.url + "refBank/bankDetails/processRmaDocument"
							def result=uploaderUtils.sendMultiPartFile((CommonsMultipartFile) uploadedFile,  destinationUrl)
							switch(result?.responseType){
							case "success":
								flash.message="TOTAL BANK IDS TO PROCESS: $result.totalBanks ||" +
											"BANK IDS NOT FOUND IN DB: $result.emptyBanks ||"+
											"SUCCESSFUL BANK ID PROCESSED: $result.successBanks ||"+ 
											"FAILED BANK ID PROCESSED: $result.failBanks ||"+
											"TOTAL BANKS UPDATED: $result.processedBanks" 
								break;
							case "exception":
								flash.message="CRITICAL ERROR: $result.errorCode -> $result.description"
								break;
							}
					break; 
				default:
					flash.message = "FILE NOT ACCEPTED"
			}
		} catch(Exception e) {
			if(!e.printStackTrace()){
				println "ERROR: "+e
			}
			flash.message = "CRITICAL ERROR: $e"				
		}
//		render (view:"/admin/rma/view")		
		//		Comment out since the URL is accessible during login using copy-paste of URL link.
		//		thus this functionis no longer being used by TFS.
		forward controller: "login", action: "login"
	}
}