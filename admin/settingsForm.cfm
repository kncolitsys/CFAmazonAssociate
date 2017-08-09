<!--- I collect the information for idxAmazon Associates code
		 
		v.1 add choices for standard book code.
		 --->
<cfoutput>
	<img src="#getAssetPath()#amazonassociates-logo.jpg">
<form method="post" action="#cgi.script_name#">
	<p>
		<label for="idxAmazonId">Enter Your Amazon Associate Id</label>
		<span class="hint">Please review your Associate account at Amazon</span>
		<span class="field"><input type="text" id="idxAmazonId" name="idxAmazonId" value="#variables.idxAmazonid#" size="20" class="required"/></span>
	</p>
	
	
	<div class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showIDXAmazonSettings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="idxAmazon" name="selected" />
	</div>

</form>



</cfoutput>