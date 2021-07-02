import re # regular expressions
from functools import reduce

class TodoLine:
    def __init__(self, keyword, file_path, line_number, original_text):
        self.keyword = keyword
        self.file_path, self.line_number, self.original_text = file_path, line_number, original_text
        self.votecount = 0

        find_todo_entry_pattern = re.compile(rf"(?P<todo_entry>({self.keyword}(\^\d)?)( {self.keyword}(\^\d)?)*)")
        def replace_todo_entry(matchobj): # TODO: can I move this method?:
            # TODO: decide about whether to break out todo_entry as a separate object:
            return self.collapse_todo_entry(matchobj.group('todo_entry'))
        # this replaces multiple instances at once:
        self.text = re.sub(find_todo_entry_pattern, replace_todo_entry, self.original_text)

        #TODO: call "validate" function to filter out bad lines:

    def __str__(self): # TODO: implement __repr__ too, for use in exceptions
        return self.file_path + ":" + str(self.line_number) + ":" + self.text

    # inside a todo_line is one or more groups of TODO's and TODO^n's called a todo_entry.# TODO The votecount of the todo_line comes from the max votecount of the todo_entries # IGNORE_TODO
    # inside a todo_entry is one or more todo_words, such as 'TODO' or "TODO^2. They each have their own votecount, as indicated by the number after the caret. They are summed to make the votecount of the todo_entry. # IGNORE_TODO

    def collapse_todo_entry(self, todo_entry):
        def word_votecount(word):
            match_obj = re.search(r'(?P<votecount>\d+)$', word)
            if match_obj:
                return int(match_obj.group('votecount'))
            else:
                return 1
        votecount_list = map(word_votecount, todo_entry.split(' ')) # TODO: maybe use a list comprehension instead of map, as it's more pythonic
        def add(x, y):
            return x + y
        votecount = reduce(add,votecount_list)
        self.record_todo_entry_votecount(votecount)
        def wordify_number(votes):
            if votes == 1:
                return self.keyword
            else:
                return self.keyword + '^' + str(votes)
        return wordify_number(votecount)

    def record_todo_entry_votecount(self, votecount):
        self.votecount = max(votecount, self.votecount)

    # TODO TODO: replace in original file
    def write():
        raise Exception("TODO: IMPLEMENT")
