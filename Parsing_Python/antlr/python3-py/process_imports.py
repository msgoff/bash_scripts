from antlr4 import *

from Python3Lexer import Python3Lexer
from Python3Parser import Python3Parser
from Python3Visitor import Python3Visitor

from pudb import set_trace
# from https://github.com/antlr/antlr4/blob/master/runtime/Python3/bin/pygrun
# this is a python version of TestRig
def beautify_lisp_string(in_string):
    indent_size = 3
    add_indent = ' '*indent_size
    out_string = in_string[0]  # no indent for 1st (
    indent = ''
    for i in range(1, len(in_string)):
        if in_string[i] == '(' and in_string[i+1] != ' ':
            indent += add_indent
            out_string += "\n" + indent + '('
        elif in_string[i] == ')':
            out_string += ')'
            if len(indent) > 0:
                indent = indent.replace(add_indent, '', 1)
        else:
            out_string += in_string[i]
    return out_string
    
    
class Calc(Python3Visitor):
    def __init__(self):
        super().__init__()    
        self.result = ''
        self.id_memory = {}
    def visitImport_stmt(self, ctx):
        from time import sleep
        import re

    def visitReturnValue(self, ctx):
        self.result += str(self.visit(ctx.expr())) + '\n'
        return self.result
        
    def visitInteger(self, ctx):
        return int(ctx.INT().getText()) 
        
    def visitFloat(self, ctx):
        return float(ctx.FLOAT().getText()) 
        
    def visitAdd_sub(self, ctx):        
        left = self.visit(ctx.expr(0))
        right = self.visit(ctx.expr(1))
        if ctx.op.text == '+':
            result = left + right
        else:
            result = left - right
        return result
        
    def visitMul_div(self, ctx):        
        left = self.visit(ctx.expr(0))
        right = self.visit(ctx.expr(1))
        if ctx.op.text == '*':
            result = left * right
        else:
            result = left / right
        return result
        
    def visitExpo(self, ctx):
        left = self.visit(ctx.expr(0))
        right = self.visit(ctx.expr(1))
        result = left ** right
        return result
        
    def visitParen(self, ctx):
        return self.visit(ctx.expr())
        
    def visitAssignment(self, ctx):
        self.id_memory[ctx.ID().getText()] = self.visit(ctx.expr())
        print('id_memory=',self.id_memory)
        
    def visitVar(self, ctx):
        return self.id_memory[ctx.ID().getText()]
        
    def visitPm_integer(self, ctx):
        result = self.visit(ctx.expr())
        if ctx.op.text == '-':
            result = (-1) * result
        return result
        

file_name = 'test.expr'
input_stream = FileStream(file_name)
print('input_stream:')
#print(input_stream)
print()
lexer = Python3Lexer(input_stream)
token_stream = CommonTokenStream(lexer)
token_stream.fill()
#print('tokens:')
for tk in token_stream.tokens:
    pass
    #print(tk)
print()
parser = Python3Parser(token_stream)
tree = parser.file_input()

print('tree:')
lisp_tree_str = tree.toStringTree(recog=parser)
import re

resp = re.split(r'\\n\)\)',lisp_tree_str)
resp = [re.sub('file_input','',x) for x in resp if 'import_stmt' in str(x)]
resp = [re.sub('\(small_stmt \(import_stmt \(import_from from ','( from ',x) for x in resp]
resp = [re.sub('\(stmt \(simple_stmt \(small_stmt \(import_stmt \(import_name','( ',x) for x in resp]
resp = [re.sub('\(dotted_as_names \(dotted_as_name \(dotted_name','( ',x) for x in resp]
resp = [re.sub('\(stmt \(simple_stmt','( ',x) for x in resp]
resp = [re.sub('\(dotted_name','( ',x) for x in resp]
resp = [re.sub('\(import_as_names \(import_as_name','( ',x) for x in resp]
resp = [re.sub('\){2,} ',')',x) for x in resp]
resp = [re.sub('\s*\(\s*',' ( ',x) for x in resp]
resp = [re.sub('(\(\s+\()+','(',x) for x in resp]
resp = [x.strip() for x in resp]
resp = [re.sub('^\(','',str(x)) for x in resp]
resp = [x.strip() for x in resp]
resp = [re.sub('\( ','(',str(x)) for x in resp]
resp = [re.sub('^\(','',str(x)) for x in resp]
resp = [x.strip() for x in resp]
print(resp)

print('calc:')
calc = Calc()
result = calc.visit(tree)
print()
print('result:')
#print(result)


