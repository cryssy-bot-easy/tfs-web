package com.ucpb.tfsweb.admin

import java.util.Map;

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

class IncuventureAdminController {


//    def documentUploadingService
    def coreAPIService
	def cifService

    def index() {
        println "Incuventure index"
        //render (view: "/admin/incuventure",model:chainModel ?: [:])
        redirect(action: 'view')
    }
    def view() {
        println "Incuventure view"
        render (view: "/admin/incuventure",model:chainModel ?: [:])
    }
    def accountingUploadView(){
        println "accountingUploadView"
        redirect(action: 'view')
    }


    def uploadDocument() {
		
        println "uploadDocument"

        try{
            //handle uploaded file
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request
            MultipartFile uploadedFile = multiRequest.getFile("fileLocation")

            List<String> sqlList = new LinkedList<String>();
            uploadedFile.getInputStream().eachLine { line ->
//                println "line:::::"+ line
                sqlList.add(line)
            }


            sqlList.each { lined ->
//                println "line line:" + lined
                def serverReply = coreAPIService.dummySendQuery([sql:lined],
                        "tradeservice/getUpdateSql",
                        "")

            }


//            params.filename = documentUploadingService.saveFile( uploadedFile, servletContext.getRealPath("/") )

        } catch(Exception e){
            e.printStackTrace()
            ////printlne.message
        }

        //NOTE: We do this because of a conflict between FileUpload and MultipartHttpSevletRequest that is causing an error in the Spring Remoting
        redirect(controller:'incuventureAdmin', action:'accountingUploadView',params:params)
    }
	
	def generateCifList(){
		StringBuilder sb =  new StringBuilder()
		
		String cifToBeSearched = params.cifToBeSearched
		
		Map<String, Object> temp = (cifService.findCifsByCifNameAndNumber(10, 0, 1, [cifNumber: cifToBeSearched, unitcode: '909']).display)[0]
		
		String branchUnitCode = temp.BRANCH_UNIT_CODE
		
		
		
		sb.append("INSERT INTO TEMP_TABLE(col1,col2) VALUES(\'"+ cifToBeSearched +"\',\'" + branchUnitCode +"\');\n")
		
		
		render sb.toString();
		
		}

}
