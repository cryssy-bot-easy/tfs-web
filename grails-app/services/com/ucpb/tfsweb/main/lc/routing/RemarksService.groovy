package com.ucpb.tfsweb.main.lc.routing

import org.springframework.transaction.annotation.Transactional
import net.ipc.utils.DateUtils

/**
 */
class RemarksService {

    def queryService
    def remarksFinder = com.ucpb.tfs.application.query.routing.IRemarksFinder.class

    @Transactional(readOnly=true)
    def Map<String, Object> findAllRemarksByRemarkId(maxRows, rowOffset, currentPage, remarkId) {
        Map<String, Object> param = [remarkId :remarkId ?: null]
		println "hehehe: " + param
        List<Map<String, Object>> queryResult = queryService.executeQuery(remarksFinder, "findAllRemarksByRemarkId", param)
        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    @Transactional(readOnly=true)
    def buildRemarksGrid(display,username) {
        def list = display.collect {

            [id: it.ID,
                    cell:[
//                            it.USER_ID,
                            it.FULLNAME,
                            DateUtils.dateTimeFormat(it.DATE_CREATED),
                            it.MESSAGE?.toUpperCase(),
//                            it.USER_ID.equals(username) ? '<p class="remark" onclick="var id='+ it.ID +';editRemark(id);";>edit</p>' : ' '
                            it.USER_ID?.toUpperCase()?.equals(username?.toUpperCase()) ? "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.ID + "'; editRemark(id);\">edit</a>" : ""
                    ]
            ]
        }

        return list
    }

}
