import org.jsoup.nodes.Document

/**
 * Created by orion on 5/23/17.
 */

/**
 * This driver isn't for use in the lab. It's not written in Java to try to make that point clear.
 * To see example usage of JSoup and the Analyzer see the file AnalyzerTest.java
 */
fun main(args : Array<String>) {
    // Website to grab data from
    val website = "https://seanpgrimes.com/"

    /* Basic demonstration of using JSoup */

    // Grab the content from the website
    val doc = JSoupScraper.getWebsiteContent(website)

    // Grab all of the content in <strong></strong> tags and print it, line by line
    val all_strong = JSoupScraper.selectElementsFromDocument(doc, "strong")
    println("\nAll Strong:")
    for(e in all_strong)
        println(e.text())

    // Grab all of the content in <h1>, <h2>, <h3> tags and print line by line
    val all_h123 = JSoupScraper.selectElementsFromDocument(doc, "h1, h2, h3")
    println("\nAll H1, H2, H3")
    for(e in all_h123)
        println(e.text())
}