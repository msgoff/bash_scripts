
from sys import argv
import re
import ast
f = open(argv[1])
checksum_file = f.readlines()
f.close()
checksum_file =[x.replace('\n','') for x in checksum_file]
checksum_dict ={filepath:cs for cs,filepath in \
    [re.split('\s{2,}',x) for x in checksum_file]  
}
class ImportLister(ast.NodeVisitor):
    def __init__(self):
        self.imports = {}
    
    def node_information(self, node, node_type,node_name):
        response = (node.lineno, node.col_offset, node_type, node_name)
        return response
    
    def visit_Import(self,node):
        self.imports[(node.lineno,node.col_offset,node.end_lineno,node.end_col_offset)] = [x.__dict__ for x in node.names]
        self.generic_visit(node)
        
from pudb import set_trace
#set_trace()


for filepath,cs in checksum_dict.items():
    try:
        f = open(filepath)
        source = f.read()
        f.close()
    except:
        pass
    try:
        tree = ast.parse(source)
        X = ImportLister()
        X.visit(tree)
        print({(cs,filepath):X.imports})
    except:
        pass
