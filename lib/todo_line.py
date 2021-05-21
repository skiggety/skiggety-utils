import re # regular expressions

# TODO TODO TODO TODO TODO: IMPLEMENT
  # TodoLine
    # source location
    # text
    # processed_text
    # replace in original file somehow (perhaps can't use external grep)

class TodoLine:
    def __init__(self, grep_output_text):
        self.file_path, self.line_number, self.original_text = '', '', ''
        match = re.search(r'^(.*?):(\d*):(.*)$', grep_output_text)
        if(match):
            self.file_path, self.line_number, self.original_text = match.group(1), match.group(2), match.group(3)
        else:
            raise Exception("Can't create a TodoLine from this--TOOD: change this to avoid using this exception for control flow")
        # TODO filter for Binary files
        # TODO separate into public fileds: file_path, line_number, original_text
        # TODO filter for IGNORE_TODO

    def __str__(self):
        # TODO: print it out with full grep output
        return self.file_path + ":" + self.line_number + ":" + self.text

    @property
    def text(self):
        return(self.original_text) # TODO: IMPLEMENT for real

    @property
    def votecount():
        return(2) # TODO: IMPLEMENT

    def write():
        raise Exception("TODO: IMPLEMENT")
