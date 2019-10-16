import sys

######################################################################
# Scanner generation
tokens = ('ADD', 'MULTIPLY', 'SUBTRACT', 'DIVIDE', 'NUM', 'EOF', 'LPAREN',
          'RPAREN', 'SYM', 'ERROR')
t_ignore = ' \t\r'

def t_ADD(t): r'[+]'; return t
def t_MULTIPLY(t): r'[*]'; return t
def t_SUBTRACT(t): r'[-]'; return t
def t_DIVIDE(t): r'[/]'; return t

def t_NUM(t):
    r'[0-9]+'
    t.value = int(t.value)
    return t

def t_SYM(t):
    r'[a-zA-Z_][a-zA-Z_0-9]*';
    t.value = str(t.value)
    return t

def t_LPAREN(t): r'[(]'; return t
def t_RPAREN(t): r'[)]'; return t

def t_newline(t): r'\n+'; t.lexer.lineno += t.value.count("\n")
def t_comment(dummy_t): r'\#.*'; pass

def t_error(t):
    ''' Prints error messages when scan fails '''
    print ("Illegal character at line {} '{}'".format(t.lexer.lineno, t.value[0]))
    t.lexer.skip(1)
    return t

import ply.lex as lex
lexer = lex.lex(debug=0)       # Build the lexer

######################################################################
######################################################################

if __name__ == "__main__":
    print ("Version: ", 1)
    list = []
    if 1 < len(sys.argv):
        with open(sys.argv[1], 'r') as myfile:
            data = myfile.read()
            # Give the lexer some input
            lexer.input(data+'\n')
            # Tokenize
            while True:
                tok = lexer.token()
                if not tok:
                    break      # No more input
                list.append(str(tok))
    list2 = []
    for x in list:
        list2.append(x.split('(')[1].split(',')[0])
    print (list2)
else:
    while 1:
        try:
            s = raw_input('calc > ')
        except EOFError:
            break
        if not s:
            continue
            lexer.input(s+'\n') # parse returns None upon error
            # Tokenize
            while True:
                tok = lexer.token()
                if not tok:
                    break      # No more input
                print(tok)

