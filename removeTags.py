import re
from bs4 import BeautifulSoup as bs
#path = "F:\\f21\\490\\chicagotexts\\texts_public\\test.txt"

def getText(path):
    #input path to txt file, output stuff inside <text></text>
    f = open(path, 'r', encoding="utf-8")
    content = f.read()
    f.close
    soup = bs(content)
    return(soup('text')[0].text.encode("utf-8"))

def writeFile(path, stuff):
    #given path to write to, write stuff txt file there
     with open(path, 'wb') as file:
        file.write(stuff)
        file.close

def getFilenames(path):
    L = []
    with open(path, 'r') as file:
        for line in file:
            L.append(line.rstrip())
    return(L)

fnamesPath = "F:\\f21\\490\\chicagotexts\\texts_public\\whichfiles.txt"
fileList = getFilenames(fnamesPath)
for i in range(len(fileList)):
    #print(i)
    name = fileList[i]
    readPath = "F:\\f21\\490\\chicagotexts\\texts_public\\" + name
    writePath = "F:\\f21\\490\\chicagotexts\\texts_public\\modified\\" + name
    corpus = getText(readPath)
    writeFile(writePath, corpus)
print("done")