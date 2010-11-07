					<h2><g:message code="result.wiktionary.headline"/></h2>
					<g:if test="${wiktionaryResult}">
						<%
						clean =
						  { str -> str
						    .replaceAll(":\\[(\\d+[a-z]?\\.?\\d*)\\]", "__\$1__")
						    .replaceAll("\\[\\[([^\\]]*?)\\|([^\\]]*?)\\]\\]", "\$2")
                            .replaceAll("\\[\\[(.*?)\\]\\]", "\$1")
                            .replaceAll("^:", "")
                            .replaceAll("&lt;/?small&gt;", "")
						    .replaceAll("__(\\d+[a-z]?\\.?\\d*)__", "<span class='wiktionaryItem'>\$1.</span>")
						  };
						%>
						<g:if test="${wiktionaryResult.size() == 0}">
    						<span class="light"><g:message code="result.no.wiktionary.matches"/></span>
						</g:if>
						<g:else>
							<%
							String wiktionaryWord = wiktionaryResult.get(0);
							String meanings = wiktionaryResult.get(1).encodeAsHTML();
							meanings = clean(meanings);
							%>
								<p><b><g:message code="result.wiktionary.meanings"/></b><br/>
									<g:if test="${wiktionaryResult.get(1).trim().equals('')}">
										<span class="light"><g:message code="result.none"/></span>
										<g:set var="emptyMeanings" value="${true}"/>
									</g:if>
									<g:else>
										${meanings}
									</g:else>
                                </p>

								<p style="margin-top:10px"><b><g:message code="result.wiktionary.synonyms"/></b><br/>
									<g:if test="${wiktionaryResult.get(2).trim().equals('')}">
										<span class="light"><g:message code="result.none"/></span>
										<g:set var="emptySynonyms" value="${true}"/>
									</g:if>
									<g:else>
										<%
										String synonyms = wiktionaryResult.get(2).encodeAsHTML();
										synonyms = clean(synonyms);
										// TODO: make words links!
										%>
										${synonyms}
									</g:else>
                                </p>
							<g:if test="${wiktionaryResult.size() > 0 && ! (emptyMeanings && emptySynonyms)}">
								<div class="copyrightInfo">
									<g:message code="result.wiktionary.license" args="${[wiktionaryWord.encodeAsURL(),wiktionaryWord.encodeAsHTML(),wiktionaryWord.encodeAsURL()]}"/>
								</div>
							</g:if>
						</g:else>
					</g:if>
					<g:else>
						<ul>
							<li><span class="light"><g:message code="result.no.matches"/></span></li>
						</ul>
					</g:else>
