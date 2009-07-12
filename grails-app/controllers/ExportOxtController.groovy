import java.io.BufferedWriter
 * vithesaurus - web-based thesaurus management tool
 * Copyright (C) 2009 vionto GmbH, www.vionto.com
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */ 

import com.vionto.vithesaurus.*
import java.text.SimpleDateFormat
import java.util.zip.ZipEntry
/**
 * Exports concepts to an OpenOffice.org OXT file.
 */
class ExportOxtController extends BaseController {

  def beforeInterceptor = [action: this.&localHostAuth]

  def run = {

      File tmpFile = File.createTempFile("openthesaurus.dat", "")
      log.info("Writing data export for OXT to " + tmpFile)
      FileWriter fw = new FileWriter(tmpFile)
      BufferedWriter bw = new BufferedWriter(fw);

      File tmpFileIdx = File.createTempFile("openthesaurus.idx", "")
      log.info("Writing index export for OXT to " + tmpFileIdx)
      FileWriter fwIdx = new FileWriter(tmpFileIdx)
      BufferedWriter bwIdx = new BufferedWriter(fwIdx);
      
      int indexPos = 0
      bwIdx.write(encoding + "\n")
      def termList = Term.withCriteria {
        synset {
            eq('isVisible', true)
        }
        order("word", "asc")
      }
      log.info("Exporting " + termList.size() + " terms")
      int count = 0
      SynsetController ctrl = new SynsetController()
      for (word in allWords) {
        log.info(count + ". res = " +result.totalMatches + " " + (System.currentTimeMillis()-t) + "ms")
        bwIdx.write(word.toLowerCase() + "|" + indexPos + "\n")
        for (synset in result.synsetList) {
          List sortedTerms = synset.terms.sort()
          indexPos = dataWrite("-", bw, indexPos);
          for (sortedTerm in sortedTerms) {
            if (sortedTerm.word != word) {
              indexPos = dataWrite("|" + sortedTerm.word, bw, indexPos);
          }
        }
        indexPos = dataWrite("\n", bw, indexPos);
        //  break
        //}
        count++
      }
      
      bw.close()
      fw.close()
      bwIdx.close()
      fwIdx.close()
      log.info("Export done")
      render "OK"
      
      tmpFile.delete()
  
  private dataWrite(String str, BufferedWriter bw, int indexPos) {
    return indexPos + str.getBytes(encoding).length
  }

}