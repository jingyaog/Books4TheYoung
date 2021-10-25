#For some reason there's not really any functionality
#in R to put more than one text file into a single
#corpus, so I have to do this wtf...

def getFilenames(path):
    L = []
    with open(path, 'r') as file:
        for line in file:
            L.append(line.rstrip())
    return(L)

def writeFile(path, stuff):
    #given path to write to, write stuff txt file there
     with open(path, 'w', encoding="utf-8") as file:
        file.write(stuff)
        file.close

fnamesPath = "F:\\f21\\490\\chicagotexts\\texts_public\\whichfiles.txt"
#fnamesPath = "F:\\f21\\applied ml\\eggleston\\names.txt"
fileList = getFilenames(fnamesPath)
total = ""
for i in range(len(fileList)):
    #print(i)
    name = fileList[i]
    readPath = "F:\\f21\\490\\chicagotexts\\texts_public\\modified\\" + name
    f = open(readPath, 'r', encoding="utf-8")
    content = f.read()
    f.close
    total = total + content + "\n"

writeFile("F:\\f21\\490\\chicagotexts\\texts_public\\modified\\corpusMerged.txt", total)
print("done")