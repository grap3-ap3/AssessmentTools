
#myEmployeeFile = input('Please enter the path to your employee file: ')
myEmployeeFile = r'J:\Internal\TCL\Work\WNC_FirstInsurance\24604_NetworkPenetrationTest-2020\data\external\recon\OSINT\EmployeesFromLinkedin.txt'
myUserFile = r'J:\Internal\TCL\Work\WNC_FirstInsurance\24604_NetworkPenetrationTest-2020\data\external\recon\OSINT\userNames.txt'
loop=True

employeeList = [line.rstrip('\n') for line in open(myEmployeeFile)]
usersOut = []

def print_menu():       ## Your menu design here
    print(30 * "-" , "MENU" , 30 * "-")
    print("1. First name, last name (samsmith)")
    print("2. First initial, last name (ssmith)")
    print("5. Exit")
    print(67 * "-")

##with open(myEmployeeFile) as employeeFile:
##    for employee in employeeFile:
##        employee = line.split()
##        fName = employee[0]
##        lName = employee[1]
##
while loop:          ## While loop which will keep going until loop = False
    print_menu()    ## Displays menu
    choice = int(input("Please pick a format [1-2]: "))
     
    if choice==1:     
        for employee in employeeList:
            name = employee.split()
            fName = name[0].lower()
            lName = name[1].lower()
            lowName = str(fName+lName)
            usersOut.append(lowName)
            loop=False
    elif choice==2:
        for employee in employeeList:
            name = employee.split()
            fName = list(name[0].lower())
            fInit = fName[0]
            lName = name[1].lower()
            lowName = str(fInit+lName)
            usersOut.append(lowName)
            loop=False
    elif choice==5:
        print("Menu 5 has been selected")
        ## You can add your code or functions here
        loop=False # This will make the while loop to end as not value of loop is set to False
    else:
        # Any integer inputs other than values 1-5 we print an error message
        input("Wrong option selection. Enter any key to try again..")

print('Writing users to file.')
with open(myUserFile, mode='wt', encoding='utf-8') as myfile:
    myfile.write('\n'.join(usersOut))

