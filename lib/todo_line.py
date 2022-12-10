"""This class represents a line of code or text that has a todo on it, and knows about how many
votes it has"""
import re # regular expressions
from functools import reduce

# TODO: traditional unit tests for this library

class TodoLine:
    """One line of text from a file with a keyword (usually 'TODO') on it.""" #IGNORE_TODO
    def __init__(self, keyword, file_path, line_number, original_text):
        self.keyword = keyword
        self.file_path, self.line_number, self.original_text = file_path, line_number, original_text
        self.votecount = 0

        find_todo_entry_pattern = re.compile(rf"(?P<todo_entry>({self.keyword}(\^\d+)?)( {self.keyword}(\^\d+)?)*)")
        def replace_todo_entry(matchobj): # TODO: can I move this method?:
            # TODO: decide about whether to break out todo_entry as a separate object:
            return self.collapse_todo_entry(matchobj.group('todo_entry'))
        # this replaces multiple instances at once:
        self.text = re.sub(find_todo_entry_pattern, replace_todo_entry, self.original_text)

        #TODO: call "validate" function to filter out bad lines:

    def __str__(self): # TODO: implement __repr__ too, for use in exceptions
        return self.file_path + ":" + str(self.line_number) + ":" + self.text

    # inside a todo_line is one or more groups of TODO's and TODO^n's (IGNORE_TODO) called a
    # todo_entry. The votecount of the todo_line comes from the max votecount of the todo_entries.

    # inside a todo_entry is one or more todo_words, such as 'TODO' or "TODO^2. They each have their
    # own votecount, as indicated by the number after the caret. They are summed to make the
    # votecount of the todo_entry. # IGNORE_TODO

    def collapse_todo_entry(self, todo_entry):
        """
        Simplify the part of the string with a keyword and votecount, as in
        'TXDX^2 TXDX TXDX' --> 'TXDX^4'.
        """

        def word_votecount(word):
            match_obj = re.search(r'(?P<votecount>\d+)$', word)
            if match_obj:
                return int(match_obj.group('votecount'))
            return 1
        # TODO: maybe use a list comprehension instead of map, as it's more pythonic:
        votecount_list = map(word_votecount, todo_entry.split(' '))
        def add(x_int, y_int):
            return x_int + y_int
        votecount = reduce(add,votecount_list)
        self.record_todo_entry_votecount(votecount)
        def wordify_number(votes):
            if votes == 1:
                return self.keyword
            return self.keyword + '^' + str(votes)
        return wordify_number(votecount)

    def record_todo_entry_votecount(self, entry_votecount):
        """Keep track of the TodoLine votecount based on the votecount for an entry."""
        self.votecount = max(entry_votecount, self.votecount)

    def has_changes_to_write(self):
        return self.text != self.original_text

    # TODO: make this more efficient. Writing a file once per line is silly.
    def write(self):
        """write the TodoLine back to the original file with simplifying changes"""
        with open(self.file_path, 'r') as file:
            data = file.readlines()

        data[self.line_number - 1]  = self.text + '\n' # watch out for off-by-one errors

        with open(self.file_path, 'w') as file:
            file.writelines( data )
