source = "import re\nimport ast"
import ast
class ImportLister(ast.NodeVisitor):
    def __init__(self):
        pass
    def node_information(self, node, node_type,node_name):
        response = (node.lineno, node.col_offset, node_type, node_name)
        return response
    
    def visit_Import(self,node):
        print([x.__dict__ for x in node.names],node.lineno,node.col_offset,node.end_lineno,node.end_col_offset)
        self.generic_visit(node)
        
tree = ast.parse(source)
imports = ImportLister().visit(tree)
print(imports)
