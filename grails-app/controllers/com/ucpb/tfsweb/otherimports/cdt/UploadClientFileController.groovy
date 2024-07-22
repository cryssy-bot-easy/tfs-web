package com.ucpb.tfsweb.otherimports.cdt

import net.ipc.utils.UploaderUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

// this is no longer used!
class UploadClientFileController {

     def headerService
		
	// sets service type
	//protected String SERVICE_TYPE = "Monitoring Setup"
	
	
	//render page
	def viewCdt() {
		// if accessed from create transaction
		if(chainModel) {
			session.otherImportsModel = chainModel
		}
		
		if(session.otherImportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/imports/cdt/upload_client_files/content", model: chainModel ? chainModel : session.otherImportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}

    def uploadDocument() {
        // http://www.intelligrape.com/blog/2012/08/31/groovy-http-builder-for-sending-multipart-file/

        try{
            //handle uploaded file
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request
            MultipartFile uploadedFile = multiRequest.getFile("fileLocation")

//            UploaderUtils uploaderUtils = new UploaderUtils();
            UploaderUtils uploaderUtils = new UploaderUtils();
            uploaderUtils.sendMultiPartFile((CommonsMultipartFile) uploadedFile, uploadedFile.originalFilename)


        } catch(Exception e){
            e.printStackTrace()
        }

        //NOTE: We do this because of a conflict between FileUpload and MultipartHttpSevletRequest that is causing an error in the Spring Remoting
//        redirect(controller:'lcEtsOpening', action:'invokeUploadCommand',params:params)
    }
	
	// trigger viewing of page
	def viewUploadClientFilesCdt() {
		// get lc class and type
		String serviceType = params.serviceType
		String documentType = params.documentType
		String referenceType= params.referenceType
		String username= params.username
		
		// construct header title
		String headerTitle = headerService.getOtherImportsTitleWithConjunction(referenceType,serviceType,documentType)
		
		// keep session model
		session.otherImportsModel = [documentType: documentType, referenceType: referenceType, title: headerTitle, serviceType: serviceType, username: username]
		
		// chain to render page
		chain(action:"viewCdt", model: session.otherImportsModel)
	}
}
