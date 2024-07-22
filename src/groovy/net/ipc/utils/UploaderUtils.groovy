package net.ipc.utils

import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import org.apache.http.entity.mime.HttpMultipartMode
import org.apache.http.entity.mime.MultipartEntity
import org.apache.http.entity.mime.content.InputStreamBody
import org.apache.http.entity.mime.content.StringBody
import org.springframework.web.multipart.commons.CommonsMultipartFile


/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: UploaderUtils
 */
 
/**
 (revision)
SCR/ER Number:
SCR/ER Description: Add parameter on sendMultiPartFileWithBookCodeAndAlloc()
[Revised by:] Jonh Henry Alabin
[Date deployed:]
Program [Revision] Details: Added parameters (user role, Email and Full name) for formatting of Email Notification
PROJECT: CORE
MEMBER TYPE  : Groovy

*/

class UploaderUtils {

    // http://www.intelligrape.com/blog/2012/08/31/groovy-http-builder-for-sending-multipart-file/



    void sendMultiPartFileWithBookCodeAndAlloc(CommonsMultipartFile multipartImageFile, String fileType, String cdtApiUrl, String cdtBookCode, String allocUnitCode, String userrole, String fullName, String email) {
        def http = new HTTPBuilder(cdtApiUrl)

        http.request(Method.POST) { req ->

            requestContentType: "multipart/form-data"
			println "userrole : " + userrole
            MultipartEntity multiPartContent = new MultipartEntity(HttpMultipartMode.STRICT)

            try {
				println "file: "
                println fileType
                multiPartContent.addPart("uploadedFile", new InputStreamBody(multipartImageFile.inputStream, multipartImageFile.contentType, multipartImageFile.originalFilename))
                multiPartContent.addPart("fileType", new StringBody(fileType))


                multiPartContent.addPart("cdtBookCode", new StringBody(cdtBookCode))
                multiPartContent.addPart("allocUnitCode", new StringBody(allocUnitCode))
				multiPartContent.addPart("userrole", new StringBody(userrole))
				multiPartContent.addPart("email", new StringBody(email))
				multiPartContent.addPart("fullName", new StringBody(fullName))
            }
            catch(Exception e) {
                e.printStackTrace()
            }

            req.setEntity(multiPartContent)

            response.success = { resp ->

                if (resp.statusLine.statusCode == 200) {
                    // response handling
                } else {
                    println "error here"
                }
            }
        }
    }

    void sendMultiPartFileWithBookCode(CommonsMultipartFile multipartImageFile, String fileType, String cdtApiUrl, String cdtBookCode, String confDate) {
        def http = new HTTPBuilder(cdtApiUrl)
		
        http.request(Method.POST) { req ->

            requestContentType: "multipart/form-data"

            MultipartEntity multiPartContent = new MultipartEntity(HttpMultipartMode.STRICT)

            try {
                println fileType
                multiPartContent.addPart("uploadedFile", new InputStreamBody(multipartImageFile.inputStream, multipartImageFile.contentType, multipartImageFile.originalFilename))
                multiPartContent.addPart("fileType", new StringBody(fileType))


                multiPartContent.addPart("cdtBookCode", new StringBody(cdtBookCode))
				multiPartContent.addPart("confDate", new StringBody(confDate))
            }
            catch(Exception e) {
                e.printStackTrace()
            }

            req.setEntity(multiPartContent)

            response.success = { resp ->

                if (resp.statusLine.statusCode == 200) {
                    // response handling
                } else {
                    println "error here"
                }
            }
        }
    }

    void sendMultiPartFile2(CommonsMultipartFile multipartImageFile, String fileType, String cdtApiUrl, String userrole) {
        def http = new HTTPBuilder(cdtApiUrl)

        http.request(Method.POST) { req ->

            requestContentType: "multipart/form-data"

            MultipartEntity multiPartContent = new MultipartEntity(HttpMultipartMode.STRICT)

            try {
                println fileType
                multiPartContent.addPart("uploadedFile", new InputStreamBody(multipartImageFile.inputStream, multipartImageFile.contentType, multipartImageFile.originalFilename))
                multiPartContent.addPart("fileType", new StringBody(fileType))


                multiPartContent.addPart("userrole", new StringBody(userrole))

            }
            catch(Exception e) {
                e.printStackTrace()
            }

            req.setEntity(multiPartContent)

            response.success = { resp ->

                if (resp.statusLine.statusCode == 200) {
                    // response handling
                } else {
                    println "error here"
                }
            }
        }
    }

    void sendMultiPartClient(CommonsMultipartFile multipartImageFile, String fileType, String cdtApiUrl, String userrole, String unitcode) {
        def http = new HTTPBuilder(cdtApiUrl)

        http.request(Method.POST) { req ->

            requestContentType: "multipart/form-data"

            MultipartEntity multiPartContent = new MultipartEntity(HttpMultipartMode.STRICT)

            try {
                println fileType
                multiPartContent.addPart("uploadedFile", new InputStreamBody(multipartImageFile.inputStream, multipartImageFile.contentType, multipartImageFile.originalFilename))
                multiPartContent.addPart("fileType", new StringBody(fileType))


                multiPartContent.addPart("userrole", new StringBody(userrole))

                multiPartContent.addPart("unitCode", new StringBody(unitcode))

            }
            catch(Exception e) {
                e.printStackTrace()
            }

            req.setEntity(multiPartContent)

            response.success = { resp ->

                if (resp.statusLine.statusCode == 200) {
                    // response handling
                } else {
                    println "error here"
                }
            }
        }
    }
	
	void sendMultiPartFile(CommonsMultipartFile multipartImageFile, String fileType, String cdtApiUrl) {
		def http = new HTTPBuilder(cdtApiUrl)

		http.request(Method.POST) { req ->

			requestContentType: "multipart/form-data"

			MultipartEntity multiPartContent = new MultipartEntity(HttpMultipartMode.STRICT)

			try {
				println fileType
				multiPartContent.addPart("uploadedFile", new InputStreamBody(multipartImageFile.inputStream, multipartImageFile.contentType, multipartImageFile.originalFilename))
				multiPartContent.addPart("fileType", new StringBody(fileType))

			}
			catch(Exception e) {
				e.printStackTrace()
			}

			req.setEntity(multiPartContent)

			response.success = { resp ->

				if (resp.statusLine.statusCode == 200) {
					// response handling
				} else {
					println "error here"
				}
			}
		}
	}
	
	def sendMultiPartFile(CommonsMultipartFile multipartImageFile, String destinationUrl) {
		def http = new HTTPBuilder(destinationUrl)

		http.request(Method.POST) { req ->

			requestContentType: "multipart/form-data"

			MultipartEntity multiPartContent = new MultipartEntity(HttpMultipartMode.STRICT)

			try {
				multiPartContent.addPart("uploadedFile", new InputStreamBody(multipartImageFile.inputStream, multipartImageFile.contentType, multipartImageFile.originalFilename))
			}
			catch(Exception e) {
				e.printStackTrace()
			}

			req.setEntity(multiPartContent)

			response.success = { resp,json ->
				return json
			}
			response.failure = { resp,json ->
				println "ERROR IN UPLOADING MULTI PART : ${resp.statusLine.statusCode} : ${resp.statusLine.reasonPhrase}"
				return json
			}
		}
	}
}
