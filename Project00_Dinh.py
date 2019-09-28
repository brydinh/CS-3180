#################################################################################
## CS 3180 Fall '19
## Project 00
## Brian Dinh
#################################################################################

'''
    CONTRACT: find-words : letters -> String
    PURPOSE: Returns a string of comma delimited dictionary words 7
    letters long and in alphabetical order that can be composed of
    characters in letters. (anagrams of letters) There is no trailing
    comma after the last word in the returned string.
    Each letter in letters may only be used once per match, e.g.
    (find-words '("zymomin" "am")) could return "mammoni, zymomin"
    because "mammoni" is composed of letters in letters including the
    three 'm' characters in letters, and "zymomin" is similarly composed of
    letters in letters. However, "mammomi" could not be
    returned because "mammomi" requires four 'm' characters and
    only three are available in letters.
    CODE:
    '''
#################################################################################
## find_words: Filters out words in words.txt that do not have a string-length of 7
##             or is not an anagram of the letters being passed. Uses helper function
##             isAnagram for main filter.
def find_words(letters):
    allWordsLowerCase = [line.strip().lower() for line in open ("words.txt", 'r')]
    
    allAnagramWords = [word for word in allWordsLowerCase if  (7 == len(word)) and
                       isAnagram(word, "".join(letters))]
    
    print(', '.join(word for word in allAnagramWords))

#################################################################################
## isAnagram: Returns true if words in words.txt are composed of the same characters,
##            and is not greater than the number of characters of the string list
##            being passed. Uses helper function notCharLength for character check.
def isAnagram(word, letters):
    if notCharLength(word, letters):
        return False
    if not letters and not word:
        return True
    if not letters and word:
        return False
    else:
        return isAnagram(list(filter (lambda x: letters[0] != x, word)), letters[1:])

#################################################################################
## notCharLength: Returns true if the number of characters in the word are greater
##                than the number of characters of the string list being passed.
def notCharLength(word, letters):
    if not word:
        return False
    if word.count(word[0]) > letters.count(word[0]):
        return True
    else:
        return notCharLength(word[1:], letters)

## Test-cases
find_words (("zymomin" "omixa"))
find_words (("abcdefg" "abdfg" "abcdefg" "qed"))
