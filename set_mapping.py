import json

class Device:
    def __init__(self, j_data):
        self.name = j_data{}
        self.address = add
        self.sd_id = static
        self.dy_id = dict( {'c0' : dynamic[0], 'c1':dynamic[1], 's0':dynamic[2], 's1':dynamic[3]} )

    def checkValid(self) -> bool:
        if len(self.static) != 6:
            print("st_id not in form!!")
            return False
        return True
        
    def setName(self, name):
        self.name = name
    
    def setStatic(self, static):
        self.sd_id = static

    def setDynamic(self, dynamic):
        self.dy_id = {'c0' : dynamic[0], 'c1':dynamic[1], 's0':dynamic[2], 's1':dynamic[3]}

    def setAddress(self, add):
        self.address = add


class Mapping_table:
    def __init__(self):
        self.device_map = {}
        self.count = 0

    def addDevice(self, dev):
        self.device_map[dev.sd_id] = dev
        self.count +=

    def updateFile(self):
        if bool( self.device_map ):
            with open('./Data/matadata.json', 'w') as j_file:
                data = {}


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
        pass

    elif argv[0] in read_comm:
        if(len(argv == 1)):
            pass

        elif(len(argv == 2)):
            pass

        else:
            print("Wrong usage of 'read'!! Type 'h' or 'help' for more info.")

    else:
        print("Unknown opiont \'", argv[0], "\' !!!" )

    return True



#main flow

#전처리
try:
    with open('./Data/matadata.json', 'r') as j_file:
        j_data = json.load(j_file)
        j_data[files]

except FileNotFoundError:
    print("There is no mapping table!!!")
    print("Creating New file...")
    with open('./Data/matadata.json', 'w') as j_file:
        init_data = {"files" : [], "counter" : 0}
        json.dump(init_data, j_file, indent = 4)

    #파일 읽어오기 / 없으면 빈 파일 생성
#수행 동작 선택

cont = True
while(cont):
    str = input("lestening[=]")
    cont = options(str)
    #추가 / 삭제 / 수정 / 종료 / 출력

