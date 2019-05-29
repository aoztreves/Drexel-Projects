import org.jsoup.Connection;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by orion on 5/21/17.
 */
public class AnalyzerTest {
    @Test
    public void exampleTest() throws Exception{
        Analyzer analyzer = new Analyzer();
        int val = analyzer.analyzeString("wise men bleed after a crime");
        int val2 = analyzer.analyzeString("Abolish crime so men do not bleed, bleed, bleed");
        int val3 = analyzer.analyzeString("Wise people rule fairly and are supreme leaders. " +
                "Hopefully wise people will rule");

        assertEquals(-1, val);
        assertEquals(-5, val2);
        assertEquals(4, val3);

        Document doc = JSoupScraper.getWebsiteContent("http://www.greattreks.com/");
        Elements elements = JSoupScraper.selectElementsFromDocument(doc, "h1, h2, strong");
        int strong_sentiment = 0;
        Connection conn = JSoupScraper.connect("http://www.greattreks.com/");
        Document doc2 = JSoupScraper.getDocumentFromConnection(conn);
        for(Element e : elements)
            strong_sentiment += analyzer.analyzeString(e.text());
        assertEquals(3, strong_sentiment);
        assertEquals("Neutral", analyzer.getSentiment(strong_sentiment));
        assertNotEquals("Positive", analyzer.getSentiment(strong_sentiment));
        assertNotEquals("Negative", analyzer.getSentiment(strong_sentiment));
        strong_sentiment++;
        assertEquals(4, strong_sentiment);
        assertEquals("Positive", analyzer.getSentiment(strong_sentiment));
        assertNotEquals("Neutral", analyzer.getSentiment(strong_sentiment));
        assertNotEquals("Negative", analyzer.getSentiment(strong_sentiment));
        strong_sentiment= -12;
        assertNotEquals("Positive", analyzer.getSentiment(strong_sentiment));
        assertNotEquals("Neutral", analyzer.getSentiment(strong_sentiment));
        assertEquals("Negative", analyzer.getSentiment(strong_sentiment));
    }
}