from dav_tools import argument_parser, messages
import pyperclip
import chatgpt


def make_prompt(query: str, tables: str, values=''):
    return f'''Generate the following query in SQL, using the following tables.

-- query --
{query}

-- tables --
{tables}

{values}
'''


if __name__ == '__main__':
    argument_parser.add_argument('query', help='File containing query request in natural language')
    argument_parser.add_argument('tables', help='File containing CREATE TABLE commands')
    argument_parser.add_argument('values', nargs='?', help='File containing INSERT INTO commands')
    argument_parser.add_argument('--model', help='ChatGPT model to use', default=chatgpt.AIModel.GPT4o_mini, choices=[
        chatgpt.AIModel.GPT3,
        chatgpt.AIModel.GPT4o,
        chatgpt.AIModel.GPT4o_mini,
        ])

    argument_parser.args

    with open(argument_parser.args.query) as f:
        query = f.read()

    with open(argument_parser.args.tables) as f:
        tables = f.read()

    if argument_parser.args.values is not None:
        with open(argument_parser.args.values) as f:
            values = f.read()
    else:
        values = ''

    prompt = make_prompt(query, tables, values)

    message = chatgpt.Message()
    message.add_message(chatgpt.MessageRole.USER, prompt)
    # message.print()
    
    messages.progress('Generating answer...')
    answer = message.generate_answer(model=argument_parser.args.model)
    if argument_parser.args.model == chatgpt.AIModel.GPT3:
        chatgpt.print_price(message.usage[-1], .5, 1.5)
    elif argument_parser.args.model == chatgpt.AIModel.GPT4o:
        chatgpt.print_price(message.usage[-1], 5, 15)
    elif argument_parser.args.model == chatgpt.AIModel.GPT4o_mini:
        chatgpt.print_price(message.usage[-1], .15, .6)

    print(answer)
    