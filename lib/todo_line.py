import re # regular expressions
from functools import reduce

# TODO TODO TODO TODO: IMPLEMENT
  # TodoLine
    # source location
    # text
    # processed_text
    # replace in original file somehow (perhaps can't use external grep)

# TODO: read up on memoization and lazy evaluation and figure out if that style will serve me well here. Alternately, I can call something like process() in __init__ and just do it all up front, which I think will perform the same in the end

class TodoLine:
    def __init__(self, keyword, ignore_keyword, file_path, line_number, original_text):
        self.keyword, self.ignore_keyword = keyword, ignore_keyword
        self.file_path, self.line_number, self.original_text = file_path, line_number, original_text

        #TODO: call "validate" function to filter out bad lines:
        # filter for ignore keyword, usually 'IGNORE_TODO'
        if re.search(self.ignore_keyword, self.original_text):
            raise Exception("Can't create a TodoLine from this--TODO: change this to avoid using this exception for control flow")
        # TODO filter for Binary files

    def __str__(self): # TODO: implement __repr__ too, for use in exceptions
        return self.file_path + ":" + self.line_number + ":" + self.text

    @property
    def text(self):
        # TODO: store compiled regex at the class level if I go with memoization style, I think.
        find_todo_entry_pattern = re.compile(rf"(?P<todo_entry>({self.keyword}(\^\d)?)( {self.keyword}(\^\d)?)*)")
        def replace_todo_entry(matchobj): # TODO: can I move this method?:
            # TODO: decide about whether to break out todo_entry as a separate object:
            return self.collapse_todo_entry(matchobj.group('todo_entry'))
        # this replaces multiple instances at once:
        return re.sub(find_todo_entry_pattern, replace_todo_entry, self.original_text)

    # inside a todo_line is one or more groups of TODO's and TODO^n's called a todo_entry.# TODO The votecount of the todo_line comes from the max votecount of the todo_entries
    def collapse_todo_entry(self, todo_entry):
        def word_votecount(word):
            return 1 # TODO TODO TODO: IMPLEMENT
        votecount_list = list(map(word_votecount, todo_entry.split(' ')))
        def add(x, y):
            return x + y
        votecount = reduce(add,votecount_list)
        def wordify_number(votes):
            if votes == 1:
                return self.keyword
            else:
                return self.keyword + '^' + str(votes)
        return wordify_number(votecount)

        # TODO: inside a todo_entry is one or more todo_words, such as 'TODO' or "TODO^2. They each have their own votecount, as indicated by the number after the caret. They are summed to make the votecount of the todo_entry.
    # TODO?: @memoized # from python decorator library
    @property
    def votecount():
        return(2) # TODO: IMPLEMENT

    # TODO: replace in original file somehow (perhaps can't use external grep anymore)
    def write():
        raise Exception("TODO: IMPLEMENT")
