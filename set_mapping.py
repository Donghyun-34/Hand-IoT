import json
import os

#give d_data:dictionary
class Device:
    def __init__(self,i_list:list):
        if len(i_list) == 1:
            self.name = i_list[0]["name"]
            self.address = i_list[0]["address"]
            self.st_id = i_list[0]["st_id"]
            self.dy_id = i_list[0]["dy_id"]
        if len(i_list) == 4:
            self.name = i_list[0]
            self.address = i_list[1]
            self.st_id = i_list[2]
            self.dy_id = i_list[3]


    def checkValid(self) -> bool:
        if len(self.static) != 6:
            print("st_id not in form!!")
            return False
        return True

    def setName(self, name):
        self.name = name

    def setStatic(self, static):
        self.st_id = static

    def setDynamic(self, i_dy:list):
        if len(i_dy) == 1:
            dynamic = i_dy[0]
            self.dy_id = {'c0' : dynamic[0], 'c1':dynamic[1], 's0':dynamic[2], 's1':dynamic[3]}

        if len(i_dy) == 2:
            self.dy_id[i_dy[0]] = i_dy[1]

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
                temp = Device([d_data])
                self.addDevice(temp)

    def addDevice(self, dev):
        self.device_map[dev.getName()] = dev

    def updateFile(self):
        if bool( self.device_map ):
            #update metadata.json & device file
            with open('./Data/metadata.json', 'w') as m_file:
                file_list = []
                for item in self.device_map.values():
                    file_list.append(item.getName()+".json")
                    with open('./Data/'+item.getName()+".json", 'w') as d_file:
                        json.dump(item.__dict__, d_file, indent = 3)
                data = {"files" : file_list}
                json.dump(data, m_file, indent = 3)

    def getDevice(self, name):
        return self.device_map[name]

    def getDevices(self):
        return self.device_map.keys()

    def removeDevice(self, name):
        del self.device_map[name]


def options(input_arg, map) -> bool:
    exit_comm = ['e', 'exit', 'Exit']
    update_comm = ['u', 'update', 'Update']
    delete_comm = ['d', 'delete', 'Delete']
    add_comm = ['a', 'add', 'Add']
    read_comm = ['r', 'read', 'Read']
    help_comm = ['h', 'help', 'Help']

    argv = input_arg.split(' ')

    if argv[0] in help_comm:
        print("WIP")

    elif argv[0] in exit_comm:
        print("Exiting...")
        return False

    elif argv[0] in update_comm:
        if(len(argv) == 2):
            if argv[1] in map.getDevices():
                done_1 = True
                while done_1:
                    print("Type attribute number willing to change or quit")
                    print("1.<name> | 2.<address> | 3.<static> | 4.<dynamic> | 5.Back")
                    att_num = input("=> ")

                    if int( att_num ) == 1:
                        print("[=] Current name is : ", map.getDevice(argv[1]).getName())
                        i_att = input("[=] Change to ==> ")
                        map.getDevice(argv[1]).setName(i_att)

                    elif int( att_num ) == 2:
                        print("[=] Current address is : ", map.getDevice(argv[1]).getAddress())
                        i_att = input("[=] Change to ==> ")
                        map.getDevice(argv[1]).setAddress(i_att)

                    elif int( att_num ) == 3:
                        print("[=] Current static id is : ", map.getDevice(argv[1]).getStatic())
                        i_att = input("[=] Change to ==> ")
                        map.getDevice(argv[1]).setStatic(i_att)

                    elif int( att_num ) == 4:
                        done_2 = True
                        while done_2:
                            print("[=] Choose dynamic guesture number willing to change")
                            print("[=] 1.<anti-circle> | 2.<circle> | 3.<swipe-left> | 4.<swipe-right> | 5.Back")
                            dy_num = input("[=] => ")

                            if int( dy_num ) == 1:
                                print("[=][=] Current anti-circle code is : ", map.getDevice(argv[1]).getDynamic()['c0'])
                                i_att = input("[=][=] Change to ==> ")
                                map.getDevice(argv[1]).setDynamic(['c0', i_att])

                            elif int( dy_num ) == 2:
                                print("[=][=] Current circle code is : ", map.getDevice(argv[1]).getDynamic()['c1'])
                                i_att = input("[=][=] Change to ==> ")
                                map.getDevice(argv[1]).setDynamic(['c1', i_att])

                            elif int( dy_num ) == 3:
                                print("[=][=] Current swipe-left code is : ", map.getDevice(argv[1]).getDynamic()['s0'])
                                i_att = input("[=][=] Change to ==> ")
                                map.getDevice(argv[1]).setDynamic(['s0', i_att])

                            elif int( dy_num ) == 4:
                                print("[=][=] Current swipe-right code is : ", map.getDevice(argv[1]).getDynamic()['s1'])
                                i_att = input("[=][=] Change to ==> ")
                                map.getDevice(argv[1]).setDynamic(['s1', i_att])

                            elif int( dy_num ) == 5:
                                done_2 = False

                            else:
                                print("Wrong Input!!")

                    elif int( att_num ) == 5:
                        done_1 = False

                    else:
                        print("Wrong Input!!")

            else:
                print("There is no device named ",argv[1])

        else:
            print("Wrong usage of 'update'!! Type 'h' or 'help' for more info.")

    elif argv[0] in delete_comm:
        if(len(argv) == 2):
            if argv[1] in map.getDevices():
                map.removeDevice(argv[1])
                os.remove('./Data/'+argv[1]+'.json')
                print(argv[1]+" is removed")

            else:
                print("There is no device named ",argv[1])

        else:
            print("Wrong usage of 'delete'!! Type 'h' or 'help' for more info.")

    elif argv[0] in add_comm:
        i_name = input("Type device name : ")
        i_add = input("Type device address : ")
        i_stid = input("Type device static id : ")
        i_dyid = {}
        i_dyid['c0'] = input("Type anti-circle gesture code : ")
        i_dyid['c1'] = input("Type circle gesture code : ")
        i_dyid['s0'] = input("Type swipe-left gesture code : ")
        i_dyid['s1'] = input("Type swipe-right gesture code : ")
        temp = Device([i_name, i_add, i_stid, i_dyid])
        map.addDevice(temp)
        print("Finish adding ",temp.getName())

    elif argv[0] in read_comm:
        if(len(argv) == 1):
            print("Total device regi-ed : ")
            cnt = 1
            for it in map.getDevices():
                print(cnt," : ",it)
                cnt += 1

        elif(len(argv) == 2):
            print("wip")

        else:
            print("Wrong usage of 'read'!! Type 'h' or 'help' for more info.")

    else:
        print("Unknown option \'", argv[:], "\' !!!" )

    return True



#main flow

#전처리
try:
    with open('./Data/metadata.json', 'r') as m_file:
        m_data = json.load(m_file)
        map = Mapping_table(m_data["files"])

except FileNotFoundError:
    print("There is no mapping table!!!")
    print("Creating New file...")
    with open('./Data/metadata.json', 'w') as j_file:
        init_data = {"files" : []}
        json.dump(init_data, j_file, indent = 3)

    with open('./Data/metadata.json', 'r') as m_file:
        m_data = json.load(m_file)
        map = Mapping_table(m_data["files"])

    #파일 읽어오기 / 없으면 빈 파일 생성
#수행 동작 선택



cont = True
while(cont):
    op = input("listening[=]")
    cont = options(op, map)
    map.updateFile()
    #추가 / 삭제 / 수정 / 종료 / 출력

#print( map.getDevice('test_device3').getDynamic() )
