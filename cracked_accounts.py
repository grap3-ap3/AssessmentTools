myHashDict = {}
myPassDict = {}
lstOfHashes = []
lstForAnalysis = []

with open(r'K:\Internal\TCL\Work\GLCU\23837_PenetrationTest-2019\nt-out.txt') as f:
    for line in f:
        lstLine = line.split(':')
        myUser = lstLine[0]
        myHash = lstLine[3]
        myHashDict[myUser] = myHash

with open(r'K:\Internal\TCL\Work\GLCU\23837_PenetrationTest-2019\captured_hashes.txt') as f:
    for line in f:
        lstLine = line.split(':')
        myHash = lstLine[0]
        myPass = lstLine[1]
        myPassDict[myHash] = myPass


for i in myHashDict.items():
    thisUser = i[0]
    thisHash = i[1]
    if thisHash in myPassDict.keys():
        thisPass = myPassDict[thisHash].strip("\n")
        thisListItem = str(thisUser + ':' + thisPass)
        if thisListItem in lstForAnalysis:
            pass
        else:
            lstForAnalysis.append(thisListItem)
    else:
        pass

with open(r'K:\Internal\TCL\Work\GLCU\23837_PenetrationTest-2019\pwned.txt', mode='wt', encoding='utf-8') as myfile:
    myfile.write('\n'.join(lstForAnalysis))
