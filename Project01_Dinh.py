#################################################################################
## CS 3180 Fall '19
## Project 01
## Brian Dinh
##
## Pulled directly from ShiftReduceOOWhileIfFunctionRecursionNamedArgsAndClosures.py
## and modified to fit Project 01 requirements.
#################################################################################

import sys
sys.path.insert(0, "../..")

if sys.version_info[0] >= 3:
    raw_input = input

######################################################################
## Scanner
######################################################################
tokens = ('NUMBER', 'SYMBOL', 'PRINT', 'WHILE', 'IF', 'ELSE', 'DEF', 'CALL', 'DO') ## Added do to token list
literals = ['+', '-', '*', '/', '(', ')', '=', '{', '}', ';', ',', ':']

def t_COMMENT(t):
   r'\#.*'
   pass
   # No return value. Token discarded

def t_DEF(t):
   r'@def'
   return t

def t_CALL(t):
   r'@call'
   return t

def t_PRINT(t):
   r'@print'
   return t

def t_IF(t):
   r'@if'
   return t

def t_ELSE(t):
   r'@else'
   return t

def t_WHILE(t):
   r'@while'
   return t

## Added for Do-While loop
def t_DO(t):
    r'@do'
    return t

def t_SYMBOL(t):
    r'[a-zA-Z_]+[a-zA-Z_0-9]*'
    return t
    
def t_NUMBER(t):
    #r'\d+'
    #t.value = int(t.value)
    r'[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?'
    t.value = float(t.value)
    return t

t_ignore = " \t"

def t_newline(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

# Build the lexer
import ply.lex as lex
lex.lex()

######################################################################
## Parser
######################################################################

import operator

globalFunctions = {}
stack = [{}]

class FunctionNode:
   def __init__(self, name, compoundStatement, args = {}):
      self.name = name
      self.functionCompoundStatement = FunctionCompoundStatementNode(
         compoundStatement, args)
             
   def calc(self):
      envcopy = {}
      # Add captured globals to env
      for v in stack[0]:
         envcopy[v] = stack[0][v]
         print("{} <- {}".format(v, envcopy[v] ))
      # Add captured top of stack (replace globals if there is conflict)
      envcopy.update(stack[-1])
      self.functionCompoundStatement.env = envcopy
      globalFunctions[self.name] = self.functionCompoundStatement
      return None
  
class CallNode:
   def __init__(self, name, args = {}):
      self.arguments = args
      self.name = name
    
   def calc(self):
      if not self.name in globalFunctions:
         print("Error: No function named <{}>".format(self.name))
         return None
      
      f = globalFunctions[self.name]
      return f.calc(self.arguments)

class ValueNode:
   def __init__(self, value):
      self.value = value
      
   def calc(self):
      return self.value
      
class BinaryNode:
   def __init__(self, left, right, operation):
      self.left = left
      self.right = right
      self.operation = operation
      
   def calc(self):
      return self.operation(self.left.calc(), self.right.calc())
  
class CompoundStatementNode:
   def __init__(self, listOfStatementNodes):
      self.listOfStatementNodes = listOfStatementNodes[:]
   #print(self.listOfStatementNodes)
      
   def calc(self):
      result = None
      for statement in self.listOfStatementNodes:
         result = statement.calc()
      
      return result

class FunctionCompoundStatementNode:
   def __init__(self, compoundStatement, args = {}):
      self.compoundStatement = compoundStatement
      self.arguments = args
      self.env = None
      
   def calc(self, args = {}):
      stack.append({})   # Push empty dictionary
      
      # Add default values
      for arg in self.arguments:
         stack[-1][arg] = self.arguments[arg].calc()
         
      # Then add captured values from env when function defined
      for envVar in self.env:
         stack[-1][envVar] = self.env[envVar]
         
      # Local variables from calling stack frame trump captured
      # variables
      if 2 < len(stack):
         stack[-1].update(stack[-2])
         
      # Then add arguments to function call
      for arg in args:
         stack[-1][arg] = args[arg].calc()
         
      self.compoundStatement.calc()
      stack.pop() # Pop last dictionary
   
class VarNode:
   def __init__(self, name):
      self.name = name
    
   def calc(self):
      if self.name in stack[-1]:
         return stack[-1][self.name]
      elif self.name in stack[0]:
         return stack[0][self.name]
      else:
         print("Error: Unknown variable name: {0}".format(self.name))
      
class AssignNode:
   def __init__(self, name, rvalue):
      self.name = name
      self.rvalue = rvalue
      
   def calc(self):
      result = self.rvalue.calc()
      if (not self.name in stack[-1]) and (self.name in stack[0]):
         stack[0][self.name] = result
      else:
         stack[-1][self.name] = result
      return result
            
class PrintNode:
   def __init__(self, expr):
      self.expr = expr
      
   def calc(self):
      result = self.expr.calc()
      print(result)
      return result
                    
class IfNode:
   def __init__(self, cond, body, elseBody=None):
      self.cond = cond
      self.body = body
      self.elseBody = elseBody
     
   def calc(self):
      result = None
      condValue = self.cond.calc()
      if(condValue):
         result = self.body.calc()
      elif(None != self.elseBody):
         result = self.elseBody.calc()
     
      return result
          
class WhileNode:
    def __init__(self, cond, body):
       self.cond = cond
       self.body = body
    
    def calc(self):
       result = None
       condValue = self.cond.calc()
       while(condValue):
          result = self.body.calc()
          condValue = self.cond.calc()
       return result

# Implementation for Do-While Loop
class DoNode:
    def __init__ (self, cond, body):
        self.cond = cond
        self.body = body

    def calc(self):
        # execute once
        result = self.body.calc()
        condValue = self.cond.calc()
        
        # loop afterwards
        # since 0 is the only way for it to return false (no implementations for comparison operatos),
        # the only way to break out of these loops is to decrement in our programming language
        if(condValue <= 0):
            result = None
        else:
            while(condValue):
                result = self.body.calc()
                condValue = self.cond.calc()
        return result

######################################################################
# Parsing rules
# program ::- block_list 
# def ::- DEF SYMBOL '(' ')' '{' block_list '}'
#      | DEF SYMBOL '(' arg_list ')' '{' block_list '}'
# arg_list ::= arg
#          | arg_list ',' arg
# arg := SYMBOL ':' expression
# statement :: SYMBOL '=' expression ';'
#             | IF '(' expression ')' statement
#             | IF '(' expression ')' statement ELSE statement
#             | DO '(' expression ')' statement
#             | WHILE '(' expression ')' statement
#             | PRINT '(' expression ')' ';'
#             | '{' block_list '}'
#             | expression ';'
#             | ';'
#             | def
# block_list :: statement
#             | block_list statement
# expression ::= expression '+' expression
#             | expression '-' expression
#             | expression '*' expression
#             | expression '/' expression
#             | '(' expression ')'
#             | NUMBER
#             | SYMBOL
#             | CALL SYMBOL '(' ')'
#             | CALL SYMBOL '(' arg_list ')'
#################################################################################
## INTERPRETER
#################################################################################
precedence = (
    ('left', '+', '-'),
    ('left', '*', '/'),
)

def p_program_statement(p):
   ''' program : block_list '''
   p[0] = p[1]

def p_def_noargs(p):
   ''' def : DEF SYMBOL '(' ')' '{' block_list '}' '''
   p[0] = FunctionNode(p[2], CompoundStatementNode(p[6]))

def p_def_args(p):
   ''' def : DEF SYMBOL '(' arg_list ')' '{' block_list '}' '''
   p[0] = FunctionNode(p[2], CompoundStatementNode(p[7]), p[4])

def p_arg_list_single(p):
   ''' arg_list : arg '''
   p[0] = p[1]

def p_arg_list_multi(p):
   ''' arg_list : arg_list ',' arg '''
   args = {}; args.update(p[1]); args.update(p[3]); p[0] = args

def p_arg(p):
   ''' arg : SYMBOL ':' expression '''
   p[0] = { p[1] : p[3] }

def p_statement_def(p):
   ''' statement : def '''
   p[0] = p[1]

def p_statement_if(p):
   ''' statement : IF '(' expression ')' statement '''
   cond=p[3]; body=p[5]; p[0] = IfNode(cond, body)

def p_statement_ifelse(p):
   ''' statement : IF '(' expression ')' statement ELSE statement'''
   cond=p[3]; ifBody=p[5]; elseBody=p[7]; 
   p[0] = IfNode(cond, ifBody, elseBody)

def p_statement_expression(p):
   ''' statement : expression ';' '''
   p[0] = p[1]

def p_statement_null(p):
   ''' statement : ';' '''
   p[0] = ValueNode(None)

def p_statement_assign(p):
   ''' statement : SYMBOL '=' expression ';' '''
   a= p[1]; b = p[3]; p[0] = AssignNode(a, b)

def p_statement_print(p):
   ''' statement : PRINT '(' expression ')' ';' '''
   expr=p[3]; p[0] = PrintNode(expr)

def p_statement_while(p):
   ''' statement : WHILE '(' expression ')' statement '''
   cond=p[3]; body=p[5]; p[0] = WhileNode(cond, body)

# Added for Do-While
def p_statement_do(p):
    ''' statement : DO '(' expression ')' statement '''
    cond=p[3]; body=p[5]; p[0] = DoNode(cond, body)

def p_statement_compound(p):
   ''' statement : '{' block_list '}' '''
   p[0] = CompoundStatementNode(p[2])
   
# Returns a list of nodes
def p_block_list_single(p):
   ''' block_list : statement '''
   a = p[1]; p[0] = [a]
   
# Returns a list of nodes
def p_block_list_multi(p):
   ''' block_list : block_list statement '''
   a=p[2]; p[0] = p[1] + [a]
 
def p_expression_call(p):
   ''' expression : CALL SYMBOL '(' ')' '''
   p[0] = CallNode(p[2])

def p_expression_callargs(p):
   ''' expression : CALL SYMBOL '(' arg_list ')' '''
   p[0] = CallNode(p[2], p[4])

def p_expression_binop(p):
    '''expression : expression '+' expression
                  | expression '-' expression
                  | expression '*' expression
                  | expression '/' expression'''
    if p[2] == '+':
        a= p[1]; b = p[3]; p[0] = BinaryNode(a, b, operator.add)
    # handles for subtraction
    elif p[2] == '-':
        a= p[1]; b = p[3]; p[0] = BinaryNode(a, b, operator.sub)
    elif p[2] == '*':
        a= p[1]; b = p[3]; p[0] = BinaryNode(a, b, operator.mul)
    # handles for division
    # changed to truediv for python 3
    elif p[2] == '/':
        a= p[1]; b = p[3]; p[0] = BinaryNode(a, b, operator.truediv)

def p_expression_group(p):
    "expression : '(' expression ')'"
    p[0] = p[2]

def p_expression_number(p):
    "expression : NUMBER"
    a = p[1]; p[0] = ValueNode(a)

def p_expression_var(p):
    "expression : SYMBOL"
    a = p[1]; p[0] = VarNode(a)

def p_error(p):
    if p:
        print("Syntax error at '%s'" % p.value)
    else:
        print("Syntax error at EOF")

import ply.yacc as yacc
yacc.yacc()

#################################################################################
## DRIVER PROGRAM
#################################################################################

# Have it be required that the user provides a test case file. In this case we are using my test case file I written (tests.txt).
if 1 < len(sys.argv):
    with open(sys.argv[1], 'r') as myfile:
        data=myfile.read()
    treeRootList = yacc.parse(data+'\n') # parse returns None upon error
    if None != treeRootList:
        realNode = CompoundStatementNode(treeRootList)
        realNode.calc()
else:
    print("You need to pass in a second argument indicating the test file!")
