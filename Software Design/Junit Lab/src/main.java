import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class main {

	public static void main(String[] args) throws Exception{
		Analyzer analyzer = new Analyzer();
		
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
		
		//System.out.println(strong_sentiment1 +strong_sentiment2+strong_sentiment3+strong_sentiment4+strong_sentiment5);
		
		System.out.println((strong_sentiment1));
		System.out.println((strong_sentiment2));
		System.out.println((strong_sentiment3));
		System.out.println((strong_sentiment4));
		System.out.println((strong_sentiment5));
		
		
		
	}

}
