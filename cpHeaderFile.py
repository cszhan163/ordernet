import os;
import platform;
import sys;
import subprocess;
targetPath = "./include"
def runCommand(cmd):
    sysstr = platform.system()
    if(sysstr == 'Windows'):
      ps = subprocess.Popen(cmd)
      ps.wait()
    else:
      ps = subprocess.Popen(cmd, shell=True)
      ps.wait()
def recurCopyFiles(path):
    if(path == -1):
        return
    if(path.find(".DS_Store")!=-1):
        return
    #if(os.path.isdir)
    pathList = os.listdir(path); 
    for item in pathList:
        print(item)
        fullPath = path+"/"+item
        if(item.find(".DS_Store")!=-1 or (item.find(".svn")!=-1)):
            continue
        if(os.path.isfile(fullPath)):#weather is a folder
            if((item.find(".h")!=-1)):
                pathArray = item.split("/")
                pathLen = len(pathArray);
                fileName = pathArray[pathLen-1];
                print(fileName)
                cmd = "cp -r "+path+"/"+item+"   "+targetPath+"/"+item
                print(cmd)
                runCommand(cmd)
            else:
                print("not copy file:"+fullPath)
                continue
        else:
            newPath = path+"/"+item
            print("path:"+newPath)
            recurCopyFiles(newPath)          
if __name__ == "__main__":
    pathSet = os.listdir(".")
    #print(pathSet)
    cppath = sys.argv[1]
    #print(cppath)
    recurCopyFiles(cppath) 
