import re # regular expressions

# TODO TODO TODO TODO: IMPLEMENT
  # TodoLine
    # source location
    # text
    # processed_text
    # replace in original file somehow (perhaps can't use external grep)

class TodoLine:
    def __init__(self, file_path, line_number, original_text):
        self.file_path, self.line_number, self.original_text = file_path, line_number, original_text

        #TODO: call "validate" function:
        if re.search(r'IGNORE_TODO', self.original_text):
            raise Exception("Can't create a TodoLine from this--TODO: change this to avoid using this exception for control flow")
        # TODO filter for Binary files
        # TODO separate into public fileds: file_path, line_number, original_text
        # TODO filter for IGNORE_TODO

    def __str__(self): # TODO: implement __repr__ too, for use in exceptions
        return self.file_path + ":" + self.line_number + ":" + self.text

    @property
    def text(self):
        return(self.original_text) # TODO: IMPLEMENT for real

    @property
    def votecount():
        return(2) # TODO: IMPLEMENT

    def write():
        raise Exception("TODO: IMPLEMENT")
