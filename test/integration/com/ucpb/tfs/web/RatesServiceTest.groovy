package com.ucpb.tfs.web

import com.ucpb.tfsweb.main.RatesService

/**
 */
class RatesServiceTest extends GroovyTestCase{

    def RatesService ratesService;


    void testGetDailyRates(){
        assert ratesService != null;
        def rates = ratesService.getRatesByBaseCurrency();
        assert rates != null;

    }

    void testGetUrrConversionFromEurToPhp(){
        def rates = ratesService.getUrrConversionRate("EUR","PHP");
        assertNotNull(rates);
//        assertEquals("PHP",rates.CURRENCY_CODE);
        assertEquals(new BigDecimal("56.3027280"),rates.CONVERSION_RATE);
    }



}

