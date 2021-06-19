import re # regular expressions
from functools import reduce

# TODO TODO TODO TODO: IMPLEMENT
  # TodoLine
    # source location
    # text
    # processed_text
    # replace in original file somehow (perhaps can't use external grep)

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
        # TODO: store compiled regex at the class level, right?
        pattern = re.compile(rf"(?P<todo_entry>({self.keyword}(\^\d)?)( {self.keyword}(\^\d)?)*)")
        if pattern.match(self.original_text): # what about matching multiple todo_entries?
            # TODO: can I move/rename this method?:
            def repl(matchobj):
                return self.collapse_todo_entry(matchobj.group('todo_entry'))
            return re.sub(
                    pattern,
                    repl,
                    self.original_text
                    )
        else:
            return self.original_text

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

    @property
    def votecount():
        return(2) # TODO: IMPLEMENT

    def write():
        raise Exception("TODO: IMPLEMENT")
