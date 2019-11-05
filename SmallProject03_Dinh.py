#################################################################################
## CS 3180 Fall '19
## Small Project 03
## Brian Dinh
#################################################################################


######################################################################
# Scanner generation
######################################################################
tokens = ('ADD', 'MULTIPLY', 'NUM', 'LPAREN', 'RPAREN',)
t_ignore = ' \t\r'

def t_NUM(t):
    r'([0-9]+\.?[0-9]*)|([0-9]*\.?[0-9]+)'
    t.value = float(t.value)
    return t
def t_ADD(t): r'[+]'; return t
def t_SUBTRACT(t): r'[-]'; return t
def t_MULTIPLY(t): r'[*]'; return t
def t_LPAREN(t): r'[(]'; return t
def t_RPAREN(t): r'[)]'; return t

def t_newline(t): r'\n+'; t.lexer.lineno += t.value.count("\n")
def t_comment(dummy_t): r'\#.*'; pass

def t_error(t):
    ''' Prints error messages when scan fails '''
    print("Illegal character at line {} '{}'".format(t.lexer.lineno, \
        t.value[0]))
    t.lexer.skip(1)

import ply.lex as lex
lexer = lex.lex(debug=0)       # Build the lexer

EOF = lex.LexToken()
EOF.type = 'EOF'

###############################################################################
# Classes that define nodes in a tree of nodes constructed by the parser
###############################################################################
class NumNode:
  def __init__(self, num):
    self.num = num
    
  def run(self):
    return self.num
    
  def generate(self):
    return str(self.num)

class AddNode:
  def __init__(self, a, b):
    self.a = a
    self.b = b
    
  def run(self):
    return self.a.run() + self.b.run()
    
  def generate(self):
    return self.a.generate() + ' ' + self.b.generate() + ' + '

class MultiplyNode:
  def __init__(self, a, b):
    self.a = a
    self.b = b
    
  def run(self):
    return self.a.run() * self.b.run()
    
  def generate(self):
    return self.a.generate() + ' ' + self.b.generate() + ' * '
    

###############################################################################
# Expression Grammar in BNF
###############################################################################
# <expression> ::- <term> ADD <expression>
#               | <term>
# <term> ::- <factor> MULTIPLY <term>
#             | <factor>
# <factor> ::- LPAREN <expr> RPAREN
#             | NUM
    
def p_expression_add_binop(p):
   '''expression : term ADD expression '''
   a = p[1]; b = p[3]; p[0] = AddNode(a, b)
                  
def p_expression_term(p):
   '''expression : term '''
   p[0] = p[1]
                  
def p_term_multiply_binop(p):
   '''term : factor MULTIPLY term '''
   a = p[1]; b = p[3]; p[0] = MultiplyNode(a, b)
                  
def p_term_factor(p):
   '''term : factor '''
   p[0] = p[1]
            
def p_factor_parens(p):
   '''factor : LPAREN expression RPAREN '''
   p[0] = p[2]
            
def p_factor_num(p):
   '''factor : NUM '''
   a = p[1]; p[0] = NumNode(a)
             
def p_error(p):
    if p:
        print("Syntax error at '%s'" % p.value)
    else:
        print("Syntax error at EOF")

import ply.yacc as yacc
yacc.yacc()

######################################################################
# Driver program
while 1:
    try:
        s = input('calc > ')
    except EOFError:
        break
    if not s:
        continue
    node = yacc.parse(s,debug=False)
    print(node.run())
    print(node.generate())
