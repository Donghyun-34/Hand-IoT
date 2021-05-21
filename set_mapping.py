import json

#give d_data:dictionary
class Device:
    def __init__(self, d_data):
        self.name = d_data["name"]
        self.address = d_data["address"]
        self.st_id = d_data["st_id"]
        self.dy_id = d_data["dy_id"]

    def __init__(self, name, add, stid, dyid):
        self.name = name
        self.address = add
        self.st_id = stid
        self.dy_id = dyid  

    def checkValid(self) -> bool:
        if len(self.static) != 6:
            print("st_id not in form!!")
            return False
        return True
        
    def setName(self, name):
        self.name = name
    
    def setStatic(self, static):
        self.st_id = static

    def setDynamic(self, dynamic):
        self.dy_id = {'c0' : dynamic[0], 'c1':dynamic[1], 's0':dynamic[2], 's1':dynamic[3]}

    def setAddress(self, add):
        self.address = add

    def getName(self):
        return self.name

    def getAddress(self):
        return self.address

    def getStatic(self):
        return self.st_id

    def getDynamic(self):
        return self.dy_id

#give m_data:dictionary
class Mapping_table:
    def __init__(self, d_list):
        self.device_map = {}
        for it in d_list:
            with open('./Data/'+it, 'r') as d_file:
                d_data = json.load(d_file)
                temp = Device(d_data)
                addDevice(temp)

    def addDevice(self, dev):
        self.device_map[dev.getName()] = dev

    def updateFile(self):
        if bool( self.device_map ):
            #update metadata.json & device file
            with open('./Data/metadata.json', 'w') as m_file:
                file_list = []
                for item in device_map.values():
                    file_list.append(item.getName()+".json")
                    with open('./Data/'+item.getName()+".json", 'w') as d_file:
                        json.dump(item.__dict__, d_file, indent = 3)
                data = {"files" : file_list}
                json.dump(data, m_file, indent = 3)

    def getDevice(self, name):
        return self.device_map[name]

    def getDevices(self):
        return self.device_map.keys()


def options(input) -> bool:
    exit_comm = ['e', 'exit', 'Exit']
    update_comm = ['u', 'update', 'Update']
    delete_comm = ['d', 'delete', 'Delete']
    add_comm = ['a', 'add', 'Add']
    read_comm = ['r', 'read', 'Read']
    help_comm = ['h', 'help', 'Help']

    argv = input.split(' ')
    
    if argv[0] in help_comm:
        print("WIP")

    elif argv[0] in exit_comm:
        print("Exiting...")
        return False

    elif argv[0] in update_comm:
        if(len(argv == 2)):
            
            pass
        else:
            print("Wrong usage of 'update'!! Type 'h' or 'help' for more info.")

    elif argv[0] in delete_comm:
        if(len(argv == 2)):
            pass
        
        else:
            print("Wrong usage of 'delete'!! Type 'h' or 'help' for more info.")

    elif argv[0] in add_comm:
        i_name = str( input("Type device name : ") )
        i_add = str ( input("Type device address : ") )
        i_stid = str( input("Type device static id : "))
        i_dyid = {}
        i_dyid['c0'] = str( input("Type anti-circle gesture code : ") )
        i_dyid['c1'] = str( input("Type circle gesture code : ") )
        i_dyid['s0'] = str( input("Type swipe-left gesture code : ") )
        i_dyid['s1'] = str( input("Type swipe-right gesture code : ") )
        temp = Device(i_name, i_add, i_stid, i_dyid)
        map.addDevice(temp)

    elif argv[0] in read_comm:
        if(len(argv == 1)):
            print("Need more arg for 'read'!! Type 'h' or 'help' for more info.")

        elif(len(argv == 2)):
            print("Total device regi-ed : ")
            cnt = 1
            for it in map.getDevices():
                print(cnt+" : ",it)
                cnt += 1

        else:
            print("Wrong usage of 'read'!! Type 'h' or 'help' for more info.")

    else:
        print("Unknown opiont \'", argv[0], "\' !!!" )

    return True



#main flow

#전처리
map = Mapping_table()
try:
    with open('./Data/metadata.json', 'r') as m_file:
        m_data = json.load(j_file)
        map = Mapping_table(m_data)


except FileNotFoundError:
    print("There is no mapping table!!!")
    print("Creating New file...")
    with open('./Data/metadata.json', 'w') as j_file:
        init_data = {"files" : []}
        json.dump(init_data, j_file, indent = 3)
        map = Mapping_table(init_data)

    #파일 읽어오기 / 없으면 빈 파일 생성
#수행 동작 선택

cont = True
while(cont):
    str = input("listening[=]")
    cont = options(str)
    map.updateFile()
    #추가 / 삭제 / 수정 / 종료 / 출력

