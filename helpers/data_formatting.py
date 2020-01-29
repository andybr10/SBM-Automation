from collections import OrderedDict


def indent_every_line(the_string: str, indent=1):
    """
    Replaces all '\n' with ('\n' + '\t'*indent) and adds '\t'*indent at the beginning of the string
    :param the_string: the string to be processed
    :param indent: number of tabs (indent level)
    :return: the_string.replace('\n', '\n' + '\t'*indent)
    """
    return '\t'*indent + the_string.replace('\n', '\n' + '\t'*indent)


# region PrettyFormatter
class _PrettyFormatter(object):
    """
    Format objects to pretty multi-line strings

    Not part of a copyright, original by y.petremann
    https://stackoverflow.com/users/1311620/y-petremann
    https://stackoverflow.com/questions/3229419/pretty-printing-nested-dictionaries-in-python
    """
    def __init__(self, htchar='\t', lfchar='\n', indent=0):
        self.types = {}
        self.htchar = htchar
        self.lfchar = lfchar
        self.indent = indent
        self.set_formatter(object, self.__class__.format_object)
        self.set_formatter(OrderedDict, self.__class__.format_dict)
        self.set_formatter(dict, self.__class__.format_dict)
        self.set_formatter(list, self.__class__.format_list)
        self.set_formatter(tuple, self.__class__.format_tuple)

    def set_formatter(self, obj, callback):
        self.types[obj] = callback

    def __call__(self, value, **args):
        for key in args:
            setattr(self, key, args[key])
        formatter = self.types[type(value) if type(value) in self.types else object]
        return formatter(self, value, self.indent)

    def format_object(self, value, indent):
        return repr(value)

    def format_dict(self, value, indent):
        items = [
            self.lfchar + self.htchar * (indent + 1) + repr(key) + ': ' +
            (self.types[type(value[key]) if type(value[key]) in self.types else object])(self, value[key], indent + 1)
            for key in value
        ]
        return '{%s}' % (','.join(items) + self.lfchar + self.htchar * indent)

    def format_list(self, value, indent):
        items = [
            self.lfchar + self.htchar * (indent + 1) + (self.types[type(item) if type(item) in self.types else object])(self, item, indent + 1)
            for item in value
        ]
        return '[%s]' % (','.join(items) + self.lfchar + self.htchar * indent)

    def format_tuple(self, value, indent):
        items = [
            self.lfchar + self.htchar * (indent + 1) + (self.types[type(item) if type(item) in self.types else object])(self, item, indent + 1)
            for item in value
        ]
        return '(%s)' % (','.join(items) + self.lfchar + self.htchar * indent)


pretty = _PrettyFormatter()
# endregion
