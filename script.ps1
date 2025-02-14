#return me access token from my manages identity

$params = @{
Uri = "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F"  
Header = @{Metadata = "true"}
}
$content = Invoke-WebRequest @params
Write-Output $content

#networking should be preconfigured, managed identity is only for local usage on a resource !!!
#npr ja sam mu deo VM Admin i on se meni ulogovao kao admin user na toj masini adminuser
#see how to attach MI to a resource group
#######################################################################################################################################

- hosts: winhosts
  tasks:
   - name: "Check if service exists."
     ansible.windows.win_command: powershell.exe Get-Process -Name cmd -ErrorAction Ignore #bez .exe
     register: output
     ignore_errors: true

   - debug: msg={{ output.rc }} #return code

   - name: "Stop service XSP.Common.CompositeRunner"
     ansible.windows.win_command: powershell.exe Stop-Process -Name cmd
     when: output.rc == 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

- hosts: winhosts
  tasks:
     #   - name: "Stop service XSP.Common.CompositeRunner"
     #ansible.windows.win_command: powershell.exe Stop-Process -Name XSP.Common.CompositeRunner
     #when: output.rc == 0i
   - name: Check...
     ansible.windows.win_powershell:
       script: |
         if((Get-Process "XSP.Common" -ea SilentlyContinue) -eq $Null){
          echo "Process XSP.Common not running."
          } else {
              Stop-Process -Name "XSP.Common"
          }

     register: output
       #- debug: msg = {{ output }}
https://stackoverflow.com/questions/28481811/how-to-correctly-check-if-a-process-is-running-and-stop-it
#########################################################################################################

#arrays

Set-StrictMode -Version latest

$myArray=@() #empty array
$myArrayTwo = @("test1","test2")

$myArray.GetType()
$myArray.IsFixedSize #cant add new elements

$myArrayTwo.Count

$myArray[1] #index out of bounds with strict mode latest version
$myArrayTwo[1]

#add an element to an array
#$myArray.Add("test4")
$myArray=$myArray+"test4"
$myArray.Count

#remove an element from an array
$myArray.RemoveAt(0)
$myArray=$myArray -ne "test4" #reinitialize

# ARRAY LISTS

#cast array to array list
$myArrayList=[System.Collections.ArrayList]@()
$myListTwo=New-Object -TypeName System.Collections.ArrayList

$myArrayList.GetType()
$myListTwo.GetType()

$myArrayList.Add("test1")
[void]$myArrayList.Add("test2")

$myArrayList.AddRange(@("test3","test4","test5"))
$myArrayList.Remove("test2") #removes first instance of item
$myArrayList.RemoveAt(0)
$myArrayList.RemoveRange(0,2)
