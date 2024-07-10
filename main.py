from dav_tools import argument_parser, messages, database


db = database.PostgreSQL(
    database='postgres',
    host='127.0.0.1',
    user='sql_misconceptions_admin',
    password='sql'
)

schema = 'sql_misconceptions'

def get_result(tables: str, values: str, query: str, correct_query: str):
    with db.connect() as c:
        # setup schema
        c.delete_schema(schema)
        c.create_schema(schema)
        messages.info(f'Created schema "{schema}"')

        c.set_schema(schema)

        c.execute(tables)
        messages.info('Created tables')

        try:
            c.execute(query)
            messages.success('Query can run on empty dataset (no syntax errors)')
        except database._psycopg2.Error as e:
            messages.error(f'Syntax error: {type(e)} {e}')
            return

        c.execute(values)
        messages.info('Added values')

        c.execute(correct_query)
        correct_result = c.fetch_all()
        correct_result_rows = len(correct_result)

        c.execute(query)
        result = c.fetch_all()
        result_rows = len(result)

        if result_rows == correct_result_rows:
            messages.success(f'Query returned correct amount of rows ({result_rows})')
        else:
            messages.error(f'Query should have returned {correct_result_rows} but returned {result_rows}')

        c.commit()


if __name__ == '__main__':
    argument_parser.set_developer_info('Davide Ponzini', 'davide.ponzini@edu.unige.it')
    argument_parser.set_description('Helper tool to check query errors')
    argument_parser.add_argument('tables', help='CREATE TABLE commands')
    argument_parser.add_argument('values', help='INSERT INTO commands')
    argument_parser.add_argument('query', help='Query to check')
    argument_parser.add_argument('correct_query', help='Correct query to compare results to')

    with open(argument_parser.args.tables) as f:
        tables = f.read()

    with open(argument_parser.args.values) as f:
        values = f.read()

    with open(argument_parser.args.query) as f:
        query = f.read()

    with open(argument_parser.args.correct_query) as f:
        correct_query = f.read()


    get_result(
        tables=tables,
        values=values,
        query=query,
        correct_query=correct_query
        )