Manog Plugin: idxAmazom
It automatically adds an affiliate link to the Amazon product to the bottom of the page/post, if the ASIN custom field is available directly to the product if not it will just link to the Amazon homepage.
- Sidebar: Adds a Amazon Associate widget to the side bar.


Admin: Settings
Enter AmazonAssociate Id in Settings screen

Post/pages 
- Add a value for the ASIN CustomField for each page or post you'd like to use this feature
- 
Ways to troubleshoot"
Check your skin files:
1)  Make sure, the  "beforePostContentEnd" event is available in the skin files page.cfm & post.cfm.
2) Add layout for the CustomField "ASIN" both skin folders. 

<mango:PostProperty ifHasCustomField="ASIN">
	<someHTML>
		 <mango:PostProperty customField="ASIN">
	</someHTML>
</mango:PostProperty>

Notes while programming.
Add to handler cfc
if event
//code in processEvent function of your plugin:
<cfif arguments.event.name EQ "beforeAdminPostFormDisplay"> 
    <cfset event.item.setCustomField('thumbnail',"Post Thumbnail", '')>
</cfif>

Set variable for 
id = idxAmazon
	<cfset variables.name = "IDX Amazon">
	<cfset variables.id = "com.idxtools.mango.plugins.googleanalytics">
	<cfset variables.package = "com/idxtools/mango/plugins/googleanalytics"/>