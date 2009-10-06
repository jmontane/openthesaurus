<%@page import="com.vionto.vithesaurus.*" %>  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title><g:message code="edit.term.title" args="${[term.toString()?.encodeAsHTML()]}"/></title>
        <script type="text/javascript" src="${createLinkTo(dir:'js/prototype',file:'prototype.js')}"></script>
        <script type="text/javascript">
        <!--
	        function showNewTermLink() {
    	        document.getElementById('addTermLinkLink').style.display='none';
        	    document.getElementById('addTermLink').style.display='block';
            	document.editForm.q.focus();
            	return false;
            }
	        function doSearchOnReturn(event) {
	            if (event.keyCode == 13) {
	                // start a search on return (copied from the generated code):
	                new Ajax.Updater('termLink','${createLinkTo(dir:"synset/ajaxSearch",file:"")}',{asynchronous:true,evalScripts:true,onLoaded:function(e){loadedSearch()},onLoading:function(e){loadSearch()},parameters:'q='+document.editForm.q.value});return false;
	                // don't send the outer form:
	                return false;
	            }
	        }
        // -->
        </script>
    </head>
    <body>

        <div class="body">
        
            <h1><g:message code="edit.term.headline" args="${[term.toString()?.encodeAsHTML()]}"/></h1>
    
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
    
            <g:hasErrors bean="${term}">
            <div class="errors">
                <g:renderErrors bean="${term}" as="list" />
            </div>
            </g:hasErrors>
            
            <g:if test="${!session.user}">
                <g:set var="disabled" value="disabled='true'"/>
            </g:if>

            <div style="float:right"><g:render template="/ads/termedit_right"/></div>
			 
            <g:form controller="term" method="post" name="editForm">
                <input type="hidden" name="id" value="${id}" />
                <div class="dialog">
                    <table style="width:85%">
                        <tbody>
                        
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='word'><g:message code="edit.term.term"/></label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:term,field:'word','errors')}'>
                                    <input ${disabled} type="text" id='word' name='word' value="${fieldValue(bean:term,field:'word')}"/>
                                </td>
                            </tr> 

                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='synset'><g:message code="edit.term.synset"/></label>
                                </td>
                                <td valign='top' class='value'>
                                    <g:link controller="synset" action="edit" id="${term.synset.id}">${term.synset.toString()?.encodeAsHTML()}</g:link>
                                </td>
                            </tr> 

						    <g:if test="${Language.findAllByIsDisabled(false)?.size() == 1}">
						    	<tr style="display:none">
						    		<td></td>
						    		<td>
						    			<%-- the HTML around the hidden field is for syntax correctness only --%>
									  	<g:hiddenField name="language.id_${i}" value="${Language.findByIsDisabled(false).id}"/>
						    		</td>
						    	</tr>
						    </g:if>
						    <g:else>
	                            <tr class='prop'>
	                                <td valign='top' class='name'>
	                                    <label for='synset'><g:message code="edit.term.language"/></label>
	                                </td>
	                                <td valign='top' class='value ${hasErrors(bean:term,field:'language','errors')}'>
	                                    <g:if test="${session.user}">
	                                        <g:select value="${term.language.id}" name="language.id"
	                                            optionKey="id" from="${Language.list()}" />
	                                    </g:if>
	                                    <g:else>
	                                        ${term.language.longForm.toString()?.encodeAsHTML()}
	                                    </g:else>
	                                </td>
	                            </tr> 
						    </g:else>

							<%-- 
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='wordGrammar'><g:message code="edit.term.word.form"/></label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:term,field:'wordGrammar','errors')}'>
                                    <g:if test="${session.user}">
                                        <g:select value="${term.wordGrammar?.id}" name="wordGrammar.id"
                                            optionKey="id" from="${WordGrammar.list()}" />
                                    </g:if>
                                    <g:else>
                                        ${term.wordGrammar?.toString()?.encodeAsHTML()}
                                    </g:else>
                                </td>
                            </tr>
                            --%>

                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='synset'><g:message code="edit.term.level"/></label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:term,field:'level','errors')}'>
                                    <g:select value="${term.level?.id}" name="level.id" disabled="${!session.user}" 
                                        optionKey="id" from="${TermLevel.list()}" noSelection="['null':message(code:'edit.term.level.none')]" />
                                </td>
                            </tr>

                            <%-- 
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='synset'>Level:</label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:term,field:'level','errors')}'>
                                    <g:select value="${term.level?.id}" name="level.id" 
                                        optionKey="id" from="${TermLevel.list()}" noSelection="['null':'[none]']" />
                                </td>
                            </tr>
                            --%>

							<%--
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                </td>
                                <td valign='top' class='value'>
                                    <label><g:managedRadio disabled="${!session.user}" id="wordFormCommon" name="wordForm"
                                        value="common" checked="${true}" /> common word</label>&nbsp;
                                    <label><g:managedRadio disabled="${!session.user}" id="wordFormAcronym" name="wordForm"
                                        value="acronym" checked="${term.isAcronym}" /> acronym</label>&nbsp;
                                    <label><g:managedRadio disabled="${!session.user}" id="wordFormAbbreviation" name="wordForm"
                                        value="abbreviation" checked="${term.isShortForm}" /> abbreviation</label>
                                </td>
                            </tr>
                            --%> 

                            <tr class='prop'>
                                <td valign='top' class='name'>
                                	<g:message code="edit.term.links"/>
                                </td>
                                <td valign='top' class='value'>
								    <g:if test="${session.user && false}"><%-- FIXME
	                                
								        <div id="addTermLinkLink" style="margin-top:5px">
								            <a href="#" onclick="javascript:showNewTermLink();return false;"><g:message code="edit.add.link"/></a>
								        </div>
								        <div id="addTermLink" style="display:none;margin-top:5px">
									        <g:textField name="q" value="" onkeypress="return doSearchOnReturn(event);"/>
									        <g:select name="linkType.id"
									              optionKey="id" from="${TermLinkType.list().sort()}" />
									
											<%-- we have to use this instead of g:remoteLink to inject the value of the search form, see below:  --%>
											<%-- NOTE: keep in sync with doSearchOnReturn() javascript:--%>
									        <a href="${createLinkTo(dir:'synset/ajaxSearch')}" 
									        	onclick="new Ajax.Updater('termLink','${createLinkTo(dir:'synset/ajaxSearch')}',{asynchronous:true,evalScripts:true,onLoaded:function(e){loadedSearch()},onLoading:function(e){loadSearch()},parameters:'q='+document.editForm.q.value});return false;"
									        	><g:message code="edit.link.lookup"/></a>
									              
									        <!-- see http://jira.codehaus.org/browse/GRAILS-3205 for why we cannot use this:
									        <g:submitToRemote value="${message(code:'edit.link.lookup')}" action="ajaxSearch"
									              update="synsetLink" onLoading="loadSearch()" onLoaded="loadedSearch()" method="get" />
									        -->
									        <span id="addSynsetProgress" style="visibility:hidden;position:absolute">
									            <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner image"
									               title="Searching..."/>
									        </span>
									        <div id="termLink">
									        </div>
								     	</div>
								    
								    </g:if> 
								    <g:else>
						    			<g:if test="${term.termLinks && term.termLinks.size() > 0 || reverseLinks && reverseLinks.size() > 0}">
						    				<ul>
							    				<g:each var="termLink" in="${term.termLinks}">
							    					<li>${termLink.linkType.linkName.encodeAsHTML()}:
							    						<g:link controller="term" action="edit" 
							    						  id="${termLink.targetTerm.id}">${termLink.targetTerm}</g:link>
							    						(<g:link controller="synset" action="edit"
							    						  id="${termLink.targetTerm.synset.id}">${termLink.targetTerm.synset.toShortString(3).encodeAsHTML()}</g:link>)</li>
							    				</g:each>
							    				<%-- show links pointing *to* this term from another term: --%>
							    				<g:each var="termLink" in="${reverseLinks}">
							    					<li>${termLink.linkType.otherDirectionLinkName.encodeAsHTML()}:
							    						<g:link controller="term" action="edit" 
							    						  id="${termLink.term.id}">${termLink.term}</g:link>
							    						(<g:link controller="synset" action="edit"
							    						  id="${termLink.term.synset.id}">${termLink.term.synset.toShortString(3).encodeAsHTML()}</g:link>)</li>
							    				</g:each>
						    				</ul>
						    			</g:if>
						    			<g:else>
						    				<span class="metaInfo"><g:message code='edit.none'/></span>
						    			</g:else>
								    </g:else>
								     
							     </td>
							</tr>

                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='userComment'><g:message code="edit.term.comment"/></label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:term,field:'userComment','errors')}'>
                                    <g:if test="${session.user}">
                                        <g:textArea rows="5" cols="40" id='userComment' name='userComment' value="${term.userComment}"/>
                                    </g:if>
                                    <g:else>
										<g:if test="${term.userComment}">
	                                        ${term.userComment?.toString()?.encodeAsHTML()}
										</g:if>
										<g:else>
											<span class="metaInfo"><g:message code="edit.no.comment"/></span>
										</g:else>
                                    </g:else>
                                </td>
                            </tr>
                            
                            <tr>
                            	<td></td>
                            	<td>
					                <g:if test="${session.user}">
						                <div class="buttons">
						                    <span class="button"><g:actionSubmit class="save" 
						                    	action="update" value="${message(code:'edit.term.submit')}" /></span>
						                </div>
						            </g:if>
                            	</td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </g:form>
            
        </div>
    </body>
</html>
