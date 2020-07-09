//%attributes = {}
C_OBJECT:C1216($repoInfo)
$repoInfo:=GIT_GetRepoInformation ("dbeaubien";"4D-Github-API-Component")
SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($repoInfo;*))
TRACE:C157

C_COLLECTION:C1488($repoContent)
$repoContent:=GIT_GetRepoContent ("dbeaubien";"4D-Github-API-Component";"")
SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($repoContent;*))
TRACE:C157

$repoContent:=GIT_GetRepoContent ("dbeaubien";"4D-Github-API-Component";"README.md")
SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($repoContent;*))
TRACE:C157

C_OBJECT:C1216($fileRepoContents)
$fileRepoContents:=GIT_GetFileFromRepo ("dbeaubien";"4D-Github-API-Component";"README.md")
SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($fileRepoContents;*))
TRACE:C157
