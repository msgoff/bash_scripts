import sys
from antlr4 import *
import JavaScriptLexer
import JavaScriptParser

JSL = JavaScriptLexer.JavaScriptLexer
JSP = JavaScriptParser.JavaScriptParser

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


class WriteTreeListener(ParseTreeListener):
    def visitTerminal(self, node:TerminalNode):
        print ( node.parentCtx.__dict__)
        #+ " - " + repr(node))

def main(argv):
    input_stream = FileStream(argv[1])
    print("Test started for: " + argv[1])
    lexer = JSL(input_stream)
    stream = CommonTokenStream(lexer)
    stream.fill()
    parser = JSP(stream)
    #print("Created parsers")
    tree = parser.program()
    lisp_tree_str = tree.toStringTree(recog=parser)
    print(lisp_tree_str)
    from pudb import set_trace
    #set_trace()
    #ParseTreeWalker.DEFAULT.walk(WriteTreeListener(), tree)



if __name__ == '__main__':
    print("Running")
    main(sys.argv)
