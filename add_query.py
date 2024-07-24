from dav_tools import argument_parser, messages
import os
import re
import pyperclip


def get_next_filename(directory = '.'):
    max_value = None
    pattern = re.compile(r'q(\d+)\.sql')

    # Walk through all subdirectories and files
    for root, _, files in os.walk(directory):
        for file in files:
            match = pattern.match(file)
            if match:
                value = int(match.group(1))
                if max_value is None or value > max_value:
                    max_value = value

    if max_value is None:
        messages.critical_error('No query files found.')

    return f'q{max_value + 1}.sql'

def add_query(folder, filename, content):
    with open(f'{folder}/{filename}', 'w') as file:
        file.write(content)


if __name__ == '__main__':
    argument_parser.set_description('Small utility to add a new query (copied to clipboard) to a folder')
    argument_parser.add_argument('dir', help='directory where the query is going to be added')
    argument_parser.args

    filename = get_next_filename()
    query = pyperclip.paste()

    add_query(argument_parser.args.dir, filename, query)

    messages.success(f'Created file {argument_parser.args.dir}/{filename}')
    messages.info(query)
