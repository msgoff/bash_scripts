import re
def get_bash_functions(file_name):
    with open(file_name) as f:
        data = f.read()
        for ix in re.findall('[A-Za-z_]+\(\).*?}\n',data,re.DOTALL):
                print(ix)

#get_bash_functions('../manuscript/chapter2.txt')
