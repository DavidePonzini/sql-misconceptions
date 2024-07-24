from dav_tools import argument_parser, messages
import os
import re
import pyperclip


def find_max_id(directory):
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

    return max_value

def create_file(file_name, content):
    with open(file_name, 'w') as file:
        file.write(content)


if __name__ == '__main__':
    argument_parser.set_description('Small utility to add a new query (copied to clipboard) to a folder')
    argument_parser.add_argument('dir', help='directory where the query is going to be added')
    argument_parser.args


    max_id = find_max_id('.')
    if max_id is None:
        messages.critical_error('No query files found.')

    filename = f'{argument_parser.args.dir}/q{max_id + 1}.sql'
    query = pyperclip.paste()

    create_file(filename, query)

    messages.success(f'Created file {filename}')
    messages.info(query)
