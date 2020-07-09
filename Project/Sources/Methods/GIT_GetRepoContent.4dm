//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // GIT_GetRepoContent (userName, repo, path) : responseObj
  // GIT_GetRepoContent (text, text, text) : object
  //
  // DESCRIPTION
  //   Returns a collection of repository content objects based on the 
  //   repo path passed in.
  //   Leave path empty to return everything.
  //
  //   As per: https://docs.github.com/en/rest/reference/repos#get-repository-content
  //
C_TEXT:C284($1;$userName)
C_TEXT:C284($2;$repo)
C_TEXT:C284($3;$path)
C_COLLECTION:C1488($0;$repoContent)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (07/08/2020)
  // ----------------------------------------------------

ASSERT:C1129(Count parameters:C259=3)
$userName:=$1
$repo:=$2
$path:=$3

C_TEXT:C284($url)
$url:="https://api.github.com/repos/dbeaubien/4D-Github-API-Component"
$url:="https://api.github.com/repos/"+$userName+"/"+$repo+"/contents/"+$path

C_TEXT:C284($response)
C_LONGINT:C283($statusCode)
ARRAY TEXT:C222($headerNames;0)
ARRAY TEXT:C222($headerValues;0)
APPEND TO ARRAY:C911($headerNames;"Accept")
APPEND TO ARRAY:C911($headerValues;"application/vnd.github.v3+json")
$statusCode:=HTTP Get:C1157($url;$response;$headerNames;$headerValues)

Case of 
	: ($response="{@}")  // look like a json object?
		$repoContent:=New collection:C1472(JSON Parse:C1218($response))
		
	: ($response="[@]")  // look like a json array?
		$repoContent:=JSON Parse:C1218($response)
		
	Else 
		$repoContent:=Null:C1517
End case 

$0:=$repoContent