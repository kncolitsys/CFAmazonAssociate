<cfcomponent extends="BasePlugin">

	<cfset variables.name = "IDXtools Amazon">
	<cfset variables.id = "com.idxtools.mango.plugins.idxAmazon">
	<cfset variables.package = "com/idxtools/plugins/idxAmazon"/>

	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />

		<cfset setManager(arguments.mainManager) />
		<cfset setPreferencesManager(arguments.preferences) />
		<cfset setPackage("com/idxtools/plugins/idxAmazon") />

		<cfset variables.basePath = getManager().getBlog().getBasePath() />
		<cfset variables.idxAmazonId = getPreferencesManager().get(variables.basepath,"idxAmazonid","Your_Amazon_Associate_Id") />
			
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="getName" access="public" output="false" returntype="string">
		<cfreturn variables.name />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setName" access="public" output="false" returntype="void">
		<cfargument name="name" type="string" required="true" />
		<cfset variables.name = arguments.name />
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="getId" access="public" output="false" returntype="any">
		<cfreturn variables.id />
	</cffunction>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setId" access="public" output="false" returntype="void">
		<cfargument name="id" type="any" required="true" />
		<cfset variables.id = arguments.id />
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		<cfreturn "IDXtools Amazon Plugin activated. <br />You can now <a href='generic_settings.cfm?event=showIDXAmazonSettings&amp;owner=idxAmazon&amp;selected=showIDXAmazonSettings'>Configure it</a>" />
	</cffunction>
	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<!--- TODO: Implement Method --->
		<!--- 
			What would it do? remover setting from db?
			Do we remove setting from tables?
			How about removin files from assets/files?
			Do we keep then until "Delete"?
		 --->
		<cfreturn "Plugin IDXtools Amazon deactivated."/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			<cfset var js = "" />
			<cfset var outputData = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			<cfset var data = ""/>
			<cfset var path = "" />
			<cfset var admin = "" />
			<cfset var mycontent = "">
			<cfset var idxAmazonout = "">
			<cfswitch expression="#arguments.event.name#">
			
				
			
				<cfcase value="postGetContent,pageGetContent">
					<cfset data = arguments.event.accessObject />
					
					<cfsavecontent variable="mycontent">
						<cfoutput>
							<cfif StructKeyExists(data.customfields, "amazonproductid")>
								<cfset myid = data.customfields.amazonproductid.value>
								<div style="float:left; margin:4px;"> 
									<iframe src="http://rcm.amazon.com/e/cm?lt1=_blank&bc1=000000&IS2=1&nou=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=#variables.idxAmazonId#&o=1&p=8&l=as4&m=amazon&f=ifr&asins=#myid#" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>
								</div>
							</cfif>
						</cfoutput>
					</cfsavecontent>
				
					<cfset data.content = mycontent & data.content>
				</cfcase>
			
				<cfcase value = "beforePostContentEnd">
					<!---  Bottom of Post (and Page/) --->
						<cfset outputData =  arguments.event.getOutputData() />
						
								<cfsavecontent variable="idxAmazonOut">
									<cfoutput>										
										<cfif arguments.event.contextData.currentPost.customFieldExists('amazonproductid')>
										<div id="idxAmazon-box">
										<a href="http://www.amazon.com/gp/product/#arguments.event.contextData.currentPost.getCustomField('amazonproductid').value#?ie=UTF8&tag=#variables.idxAmazonId#&linkCode=as2&camp=1789&creative=390957&creativeASIN=#arguments.event.contextData.currentPost.getCustomField('amazonproductid').value#">
										#arguments.event.contextData.currentPost.getCustomField("amazonproducttitle").value#</a>
										<img src="http://www.assoc-amazon.com/e/ir?t=#variables.idxAmazonId#&l=as2&o=1&a=#arguments.event.contextData.currentPost.getCustomField('amazonproductid').value#"; width="1" height="1" border="0" alt="" 
										style="border:0 !important; margin:0px !important;" /></div><div class="clear"></div>
										</cfif>
									</cfoutput> 
								</cfsavecontent>
						
						<cfset arguments.event.setOutputData(outputData & idxAmazonOut) />
							
				</cfcase>
				
				<cfcase value = "beforePageContentEnd">
					<!---  Bottom of Post (and Page/) --->
						<cfset outputData =  arguments.event.getOutputData() />
						
								<cfsavecontent variable="idxAmazonOut">
									<cfoutput>										
										<cfif arguments.event.contextData.currentPage.customFieldExists('amazonproductid')>
										<div id="idxAmazon-box">
										<a href="http://www.amazon.com/gp/product/#arguments.event.contextData.currentPage.getCustomField('amazonproductid').value#?ie=UTF8&tag=#variables.idxAmazonId#&linkCode=as2&camp=1789&creative=390957&creativeASIN=#arguments.event.contextData.currentPage.getCustomField('amazonproductid').value#">
										#arguments.event.contextData.currentPage.getCustomField("amazonproducttitle").value#</a>
										<img src="http://www.assoc-amazon.com/e/ir?t=#variables.idxAmazonId#&l=as2&o=1&a=#arguments.event.contextData.currentPage.getCustomField('amazonproductid').value#"; width="1" height="1" border="0" alt="" 
										style="border:0 !important; margin:0px !important;float:left;" /></div><div class="clear"></div>
										</cfif>
									</cfoutput> 
								</cfsavecontent>
						
						<cfset arguments.event.setOutputData(outputData & idxAmazonOut) />
							
				</cfcase>
				
				
				<!--- admin dashboard event --->
				<cfcase value="dashboardPod">
	<!--- 			 <cfif variables.manager.isCurrentUserLoggedIn()>		 --->
					<cfif variables.idxAmazonID EQ "Your_Amazon_Associate_Id">
						<!--- add a pod warning about missin account number --->
					
						<cfsavecontent variable="outputData">
						<cfoutput><p class="error">You activated the plugin IDX Amazon Associates. For it to function properly, 
							you would need to enter your Amazon Associates ID.</p>
								<p><a href="generic_settings.cfm?event=showIDXAmazonSettings&amp;owner=idxAmazon&amp;selected=showIDXAmazonSettings">Go to the Settings page and do it now.</a></p>
						</cfoutput>
						</cfsavecontent>			
						
						<cfset data = structnew() />
						<cfset data.title = "IDXtools Amazon" />
						<cfset data.content = outputData />
						<cfset arguments.event.addPod(data)>
					</cfif>
	<!--- 				</cfif> --->
				</cfcase>	
				<!--- admin nav event --->
				<cfcase value = "settingsNav">
					<cfset link = structnew() />
					<cfset link.owner = "IDXAmazon">
					<cfset link.page = "settings" />
					<cfset link.title = "IDXtools Amazon" />
					<cfset link.eventName = "showIDXAmazonSettings" />
					
					<cfset arguments.event.addLink(link)/>
				</cfcase>
				<!--- admin event --->
				<cfcase value = "showIDXAmazonSettings">

							<cfset data = arguments.event.getData() />				
							<cfif structkeyexists(data.externaldata,"apply")>
								<cfset variables.idxAmazonid = data.externaldata.idxamazonid />
								<cfset path = variables.basePath />
								<cfset getPreferencesManager().put(path,"idxAmazonid",variables.idxAmazonid) />
								
								<cfset data.message.setstatus("success") />
								<cfset data.message.setType("settings") />
								<cfset data.message.settext("Amazon Associates ID saved")/>
							</cfif>
							
							<cfsavecontent variable="page">
								<cfinclude template="admin/settingsForm.cfm"/>
							</cfsavecontent>
								
								<!--- change message --->
								<cfset data.message.setTitle("IDX Tools Amazon settings") />
								<cfset data.message.setData(page) />
					</cfcase>		
					<!--- Post/Page CustomFormFields available: --->
					<cfcase value = "beforeAdminPostFormDisplay,beforeAdminPageFormDisplay">
						<cfif NOT event.item.customFieldExists('amazonproductid')>
						   <cfset event.item.setCustomField('amazonproductid','Amazon Product ID', '')>
						</cfif>	
						<cfif NOT event.item.customFieldExists('amazonproducttitle')>
						   <cfset event.item.setCustomField('amazonproducttitle','Amazon Product Title', '')>
						</cfif>	
					</cfcase>
			
			</cfswitch>
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>