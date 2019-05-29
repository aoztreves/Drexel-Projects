import static org.junit.Assert.*;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;

public class mainTest {

	@Test
	public void test() throws Exception {
		
		Analyzer analyzer = new Analyzer();
		int val1 = 0;
		int val2 = 1;
		int val3= -5;
		
		Connection conn1 = Jsoup.connect("http://www.businessinsider.com/trump-nato-article-5-spending-2017-5");
		Connection conn2 = Jsoup.connect("http://www.businessinsider.com/paul-singers-elliott-hedge-fund-first-quarter-letter-2017-5");
		Connection conn3 = Jsoup.connect("http://www.businessinsider.com/trump-travel-ban-block-4th-circuit-court-supreme-2017-5");
		Connection conn4 = Jsoup.connect("http://www.businessinsider.com/trump-budget-young-people-millennials-2017-5");
		Connection conn5 = Jsoup.connect("http://www.businessinsider.com/manchester-ariana-grande-concert-attack-updatessalman-abedi-victims-named-us-leaks-info-security-2017-5");
		
		
		Document doc1 = JSoupScraper.getWebsiteContent("http://www.businessinsider.com/trump-nato-article-5-spending-2017-5");
		Document doc2 = JSoupScraper.getWebsiteContent("http://www.businessinsider.com/paul-singers-elliott-hedge-fund-first-quarter-letter-2017-5");
		Document doc3 = JSoupScraper.getWebsiteContent("http://www.businessinsider.com/trump-travel-ban-block-4th-circuit-court-supreme-2017-5");
		Document doc4 = JSoupScraper.getWebsiteContent("http://www.businessinsider.com/trump-budget-young-people-millennials-2017-5");
		Document doc5 = JSoupScraper.getWebsiteContent("http://www.businessinsider.com/manchester-ariana-grande-concert-attack-updatessalman-abedi-victims-named-us-leaks-info-security-2017-5");
		
		Elements elements1 = JSoupScraper.selectElementsFromDocument(doc1,"strong");
		Elements elements2 = JSoupScraper.selectElementsFromDocument(doc2,"strong");
		Elements elements3 = JSoupScraper.selectElementsFromDocument(doc3,"strong");
		Elements elements4 = JSoupScraper.selectElementsFromDocument(doc4,"strong");
		Elements elements5 = JSoupScraper.selectElementsFromDocument(doc5,"strong");
		
		int strong_sentiment1 = 0;
		int strong_sentiment2 = 0;
		int strong_sentiment3 = 0;
		int strong_sentiment4 = 0;
		int strong_sentiment5 = 0;
		
		for(Element e : elements1)
            strong_sentiment1 += analyzer.analyzeString(e.text());
		for(Element e : elements2)
            strong_sentiment2 += analyzer.analyzeString(e.text());
		for(Element e : elements3)
            strong_sentiment3 += analyzer.analyzeString(e.text());
		for(Element e : elements4)
            strong_sentiment4 += analyzer.analyzeString(e.text());
		for(Element e : elements5)
            strong_sentiment5 += analyzer.analyzeString(e.text());
		
		assertEquals(0,strong_sentiment1);
		assertEquals(0,strong_sentiment2);
		assertEquals(0,strong_sentiment3);
		assertEquals(1,strong_sentiment4);
		assertEquals(-5,strong_sentiment5);
		
		Connection conn = JSoupScraper.connect("http://www.greattreks.com/");
       
        assertNotNull(conn);
        assertNotNull(doc1);
        assertNotNull(doc2);
        assertNotNull(doc3);
        assertNotNull(doc4);
        assertNotNull(doc5);
	}

}
