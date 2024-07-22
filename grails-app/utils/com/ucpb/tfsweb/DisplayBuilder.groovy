package com.ucpb.tfsweb

/**
 */
public class DisplayBuilder {


    public static final List<Map<String,Object>> build(sourceList, maxRows, currentPage){
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows;
        return sourceList?.subList(rowOffset, calculateEndingIndex(maxRows,rowOffset,currentPage));
    }

    private static final Integer calculateEndingIndex(maxRows, currentPage, maxSize){
        return (currentPage * maxRows) < maxSize ? (currentPage * maxRows) : maxSize;
    }


}
