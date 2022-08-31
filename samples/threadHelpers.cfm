<cfscript>
	function getThreadname(){
		return createObject( "java", "java.lang.Thread" ).currentThread().getName();
	}
</cfscript>