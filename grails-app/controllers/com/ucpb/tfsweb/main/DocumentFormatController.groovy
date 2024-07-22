package com.ucpb.tfsweb.main

import grails.converters.JSON

class DocumentFormatController {

    def documentFormatService

    def displayDocumentFormat() {
        String documentFormat = documentFormatService.findDocumentFormat(params.formatCode, session.dataEntryModel)
        
        render([documentFormat: documentFormat] as JSON)
    }
}
