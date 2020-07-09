//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // GIT_GetFileFromRepo (userName, repo, path) : fileContentObj
  // GIT_GetFileFromRepo (text, text, text) : object
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
C_OBJECT:C1216($0;$fileContentObj)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (07/08/2020)
  // ----------------------------------------------------

ASSERT:C1129(Count parameters:C259=3)
$userName:=$1
$repo:=$2
$path:=$3
$fileContentObj:=New object:C1471

C_COLLECTION:C1488($repoContent)
$repoContent:=GIT_GetRepoContent ($userName;$repo;$path)

Case of 
	: ($repoContent.length=0)
		$fileContentObj.status:="failed"
		$fileContentObj.message:="no file returned by request"
		$fileContentObj.fileInfoPayload:=$repoContent
		
	: ($repoContent.length>1)
		$fileContentObj.status:="failed"
		$fileContentObj.message:="more than one 1 file returned by request"
		$fileContentObj.fileInfoPayload:=$repoContent
		
	Else 
		$fileContentObj.download_url:=$repoContent[0].download_url
		
		C_TEXT:C284($response)
		ARRAY TEXT:C222($headerNames;0)
		ARRAY TEXT:C222($headerValues;0)
		$fileContentObj.requestStatusCode:=HTTP Get:C1157($fileContentObj.download_url;$response;$headerNames;$headerValues)
		$fileContentObj.fileContents:=$response
End case 

$0:=$fileContentObj