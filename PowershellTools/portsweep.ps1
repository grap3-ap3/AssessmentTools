#A simple port sweeper, which scans list of hosts for an open port.

#It retains results in a file in the current working directory, so it can be interrupted and resumed (it will not scan already scanned hosts again).

#Import-Module .\portsweep.ps1

## Usage:
#portsweep <list.txt> <port>

## Example:
#portsweep ips.txt 445

## Check results (find open ports):
#gc portsweep.*.txt | select-string True

Function portsweep {
  param($list,$port) 

  if (!$port) {
    Write-Host "usage: portsweep <list.txt> <port>"
    Write-Host " e.g.: portsweep ips.txt 445`n"
    return
  }
  $results = ".\portsweep.$port.txt"
   
  foreach($line in Get-Content $list) {
    $x = (gc $results -EA SilentlyContinue | select-string "^$line,$port,")
    if ($x) {
      gc $results | select-string "^$line,$port,"
      continue
    }
    $output = "$line,$port,"
   
    $c = new-object system.net.sockets.tcpclient
    $c.SendTimeout = 500
    try {
      $c.Connect($line,$port)
    } catch {}
    if ($c.Connected) {
      $output += "True"
    } else {
      $output += "False"
    }
    Write-Host "$output"
    echo $output >>$results
  }
}