package com.ucpb.tfsweb.main

import org.springframework.transaction.annotation.Transactional

class TransmittalLetterService {

    def queryService

    def transmittalLetterFinder = com.ucpb.tfs.application.query.letter.ITransmittalLetterFinder.class

    @Transactional(readOnly=true)
    Map<String, Object> getAllTransmittalLetter(dataEntryModel, maxRows, rowOffset, currentPage) {
        String methodName = "findAllDefaultTransmittalLetter"

        Map<String, Object> param = [tradeServiceId: dataEntryModel.tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(transmittalLetterFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def constructTransmittalLettersGridDisplay(display) {
        display.collect {
            String originalCopy = it.ORIGINALCOPY ? 0 : ''
            String duplicateCopy = it.DUPLICATECOPY ? 0 : ''

            [ id: it.TRANSMITTALLETTERCODE,
                    cell:[
                            it.LETTERDESCRIPTION?.toUpperCase(),
                            it.ORIGINALCOPY, //"<input type='text' name='originalCopy' class='defCopy' value='"+originalCopy+"' />",
                            it.DUPLICATECOPY, //"<input type='text' name='duplicateCopy' class='defCopy' value='"+duplicateCopy+"' />",
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRANSMITTALLETTERCODE + "'; editTransmittalLetter(id);\">edit</a>"
                    ]
            ]
        }



//        display.collect {
//
//            UUID token = UUID.randomUUID()
//            String tokenValue = String.valueOf(token)
//
//            String originalCopy = "originalCopy"+tokenValue
//            String duplicateCopy = "originalCopy"+tokenValue
//
//            [ id: it.TRANSMITTALLETTERCODE,
//                    cell:[
//                            it.LETTERDESCRIPTION,
//                            "<input type='text' name='"+originalCopy+"' class='defCopy' value='"+it.ORIGINALCOPY+"' />",
//                            "<input type='text' name='"+duplicateCopy+"' class='defCopy' value='"+it.DUPLICATECOPY+"' />",
//                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRANSMITTALLETTERCODE + "'; editTransmittalLetter(id);\">edit</a>"
//                    ]
//            ]
//
////            ctr++
//        }
    }

    @Transactional(readOnly=true)
    List<String> getAllSavedTransmittalLetters(tradeServiceId) {
        String methodName = "findAllSavedTransmittalLetter"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(transmittalLetterFinder, methodName, param)

        if(queryResult) {
            if(queryResult.size() == 0) return []
        }else{
            return []
        }

        return queryResult['TRANSMITTALLETTERCODE']
    }

    def constructAddedTransmittalLetter(display) {
        display.collect {
            [id: it.id,
                    cell: [
                            it.letterDescription?.toUpperCase(),
                            it.originalCopy, //"<input type='text' name='originalCopy' class='newCopy' value='"+it.originalCopy+"' />",
                            it.duplicateCopy, //"<input type='text' name='duplicateCopy' class='newCopy' value='"+it.duplicateCopy+"' />",
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id=\'" + it.id + "\'; editAddedTransmittalLetter(id);\">edit</a>",
                            "<a href=\"javascript:void(0)\" style=\"color:red\" onclick=\"var id=\'" + it.id + "\'; deleteAddedTransmittalLetter(id);\">delete</a>"
                    ]
            ]
        }
    }

    @Transactional(readOnly=true)
    Map<String, Object> getAllSavedNewTransmittalLetter(tradeServiceId) {
        String methodName = "findAllNewTransmittalLetter"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(transmittalLetterFinder, methodName, param)

        def list = []

        queryResult.each {
            Map<String,Object> m = new HashMap<String, Object>()
            m.put("id", it.ID)
            m.put("letterDescription", it.LETTERDESCRIPTION)
            m.put("originalCopy", it.ORIGINALCOPY)
            m.put("duplicateCopy", it.DUPLICATECOPY)

            list << m
        }
        return [display: list]
    }
}
