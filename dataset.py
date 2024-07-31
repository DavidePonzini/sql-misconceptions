#!/usr/bin/env python

from dav_tools import argument_parser, messages, chatgpt
import pyperclip

def make_prompt(tables: str, queries: list[str] = []):
    result = f'''
Generate a dataset for the following tables.
The dataset should be designed with particular values so that it can be used to detect if a query contains errors.
For each query, there should be at least one values that should be included in the result and one value which should not.

--- tables ---
{tables}
'''

    for i, query in enumerate(queries):

        result += f'''
--- query {i + 1} ---
{query}
'''
    return result


if __name__ == '__main__':
    argument_parser.add_argument('tables', help='File containing CREATE TABLE commands')
    argument_parser.add_argument('queries', nargs='+', help='Files containing query requests in natural language')
    argument_parser.add_argument('--model', help='ChatGPT model to use. If not set, print the prompt to screen', choices=[
        chatgpt.AIModel.GPT3,
        chatgpt.AIModel.GPT4o,
        chatgpt.AIModel.GPT4o_mini,
        ])

    argument_parser.args

    with open(argument_parser.args.tables) as f:
        tables = f.read()

    queries = []
    for file in argument_parser.args.queries:
        with open(file) as f:
            queries.append(f.read())

    prompt = make_prompt(tables, queries)

    # if no model is specified, copy the prompt for manual execution
    if argument_parser.args.model is None:
        pyperclip.copy(prompt)
        messages.info(prompt)
        messages.success('Prompt copied to clipboard')
        exit(0)

    # if a model is specified, generate the answer and show it
    message = chatgpt.Message()
    message.add_message(chatgpt.MessageRole.USER, prompt)
    
    messages.progress('Generating answer...')
    answer = message.generate_answer(model=argument_parser.args.model)
    if argument_parser.args.model == chatgpt.AIModel.GPT3:
        chatgpt.print_price(message.usage[-1], .5, 1.5)
    elif argument_parser.args.model == chatgpt.AIModel.GPT4o:
        chatgpt.print_price(message.usage[-1], 5, 15)
    elif argument_parser.args.model == chatgpt.AIModel.GPT4o_mini:
        chatgpt.print_price(message.usage[-1], .15, .6)

    print(answer)
