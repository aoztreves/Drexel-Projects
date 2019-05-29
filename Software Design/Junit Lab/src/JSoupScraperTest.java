import static org.junit.Assert.*;

import org.jsoup.Connection;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;

public class JSoupScraperTest {

	@Test
	public void test() throws Exception{
		
        Connection conn = JSoupScraper.connect("http://www.greattreks.com/");
        Document doc2 = JSoupScraper.getDocumentFromConnection(conn);
        assertNotNull(conn);
        assertNotNull(doc2);
        
	}

}
