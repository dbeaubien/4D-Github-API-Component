//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // GIT_GetRepoInformation (userName, repo) : responseObj
  // GIT_GetRepoInformation (text, text) : object
  //
  // DESCRIPTION
  //   Returns information on the specified repository.
  //
  //   As per: https://docs.github.com/en/rest/reference/repos#get-a-repository
  //
C_TEXT:C284($1;$userName)
C_TEXT:C284($2;$repo)
C_OBJECT:C1216($0;$responseObj)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (07/08/2020)
  // ----------------------------------------------------

ASSERT:C1129(Count parameters:C259=2)
$userName:=$1
$repo:=$2

C_TEXT:C284($url)
$url:="https://api.github.com/repos/"+$userName+"/"+$repo

C_TEXT:C284($response)
C_LONGINT:C283($statusCode)
ARRAY TEXT:C222($headerNames;0)
ARRAY TEXT:C222($headerValues;0)
APPEND TO ARRAY:C911($headerNames;"accept")
APPEND TO ARRAY:C911($headerValues;"application/vnd.github.v3+json")
$statusCode:=HTTP Get:C1157($url;$response;$headerNames;$headerValues)

C_OBJECT:C1216($responseObj)
If ($response="{@}")  // look like json?
	$responseObj:=JSON Parse:C1218($response)
Else 
	$responseObj:=Null:C1517
End if 

$0:=$responseObj