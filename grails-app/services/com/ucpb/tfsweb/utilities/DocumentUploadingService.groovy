package com.ucpb.tfsweb.utilities

import org.apache.commons.io.FilenameUtils
import org.springframework.web.multipart.MultipartFile

import java.text.SimpleDateFormat;

class DocumentUploadingService {

    def grailsApplication

	String saveFile(MultipartFile uploadedFile, String tradeServiceId) {
		
		if (!uploadedFile.empty) {

			// def userDir = new File(webRootDir, grailsApplication.config.tfs.web.upload.location.toString())
            StringBuilder rootFolder = new StringBuilder(grailsApplication.config.tfs.web.upload.location.toString())

            rootFolder.append(tradeServiceId)
            println "DocumentUploadingService.saveFile() rootFolder = ${rootFolder}"

            def userDir = new File(rootFolder.toString())
            userDir.mkdirs()

            def tempFile = new File(userDir, uploadedFile.originalFilename)

            // Handle duplicates. The duplicate will be renamed.
            if (tempFile.exists()) {

                String origFileName = uploadedFile.originalFilename
                String origBaseName = FilenameUtils.getBaseName(origFileName)
                String origExt = FilenameUtils.getExtension(origFileName)

                String newBaseName = origBaseName + "_" + (new SimpleDateFormat("yyyy-MM-dd-hhmmssSSS").format(new Date()))
                String newFileName = newBaseName + ((origExt != "") ? ("." + origExt) : origExt)
                tempFile = new File(userDir, newFileName)
            }

            uploadedFile.transferTo(tempFile)

            return tempFile.name

		} else {

			return null
		}
	}

    File retrieveFile(String fileName, String tradeServiceId) {

        // def userDir = new File(webRootDir, grailsApplication.config.tfs.web.upload.location.toString())
        StringBuilder rootFolder = new StringBuilder(grailsApplication.config.tfs.web.upload.location.toString())

        rootFolder.append(tradeServiceId)
        println "DocumentUploadingService.retrieveFile() rootFolder = ${rootFolder}"

        def userDir = new File(rootFolder.toString())
        userDir.mkdirs()

        def tempFile = new File(userDir, fileName)

        return tempFile
    }

    Boolean deleteFile(String fileName, String tradeServiceId) {

        println "FILE TO BE DELETED = ${fileName}"

        StringBuilder rootFolder = new StringBuilder(grailsApplication.config.tfs.web.upload.location.toString())

        rootFolder.append(tradeServiceId)
        println "DocumentUploadingService.deleteFile() rootFolder = ${rootFolder}"

        def userDir = new File(rootFolder.toString())
        userDir.mkdirs()

        def tempFile = new File(userDir, fileName)

        if (tempFile.exists()) {
            println "FILE EXISTS!"
            def isDeleted = tempFile.delete()
            println "isDeleted = ${isDeleted}"
            return isDeleted
        } else {
            println "FILE DOES NOT EXIST"
        }

        return false
    }
}
