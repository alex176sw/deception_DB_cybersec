from time import time

from loguru import logger
from utils import (
    exclude_natural_language,
    execute_in_postgres,
    remove_any_trailing_comma,
    fix_missing_commas
)
from prompts import (
    SYSTEM_PROMPT_FOR_SCHEMA_GENERATION, 
    SYSTEM_PROMPT_FOR_REVIEW, 
    SYSTEM_PROMPT_FOR_ROWS_GENERATION
)
from llama_cpp import Llama


class TableGenerator:
    def __init__(self, max_attempts):
        self.max_attempts = max_attempts
        self.llm = None
        self.init_llama()

    def init_llama(self):
        self.llm = Llama(
            model_path="./llm-models/ggml-model-q8_07b.gguf",
            #model_path="llm-models/llama2/llama-2-7b-chat/ggml-model-f16.gguf",
            #mmodel_path="llm-models/llama2/llama-2-13b-chat/ggml-model-q8_0.gguf",
            #model_path="llm-models/codellama/CodeLlama-13b-Instruct/codellama-13b-ggml-model-f16.gguf",
            #chat_format="llama-2",
            n_gpu_layers=43, # 23 layers => 14662MiB allocated,
            n_ctx=2048,
            # random seed
            seed=int(time()),
            #echo=True # to check the prompt
        )

    def call_llama(self, prompt):
        # return "pippo"
        logger.info(f"LLaMa prompt:\n\nvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv\n{prompt}")
        self.llm.reset()
        s = time()
        r = self.llm.create_chat_completion(
            messages = [{"role": "user","content": prompt}],
            #prompt=prompt,
            stop = ["-- Additional rows"],
            #repeat_penalty = 0.8,
            max_tokens=2048
        )
        msg = r["choices"][0]['message']["content"]
        #msg = r["choices"][0]["text"]
        tokens = r["usage"]
        logger.info(f"Took:\n{(time()-s):0.2f})")
        logger.info(f"LLaMa tokens:\n{tokens})")
        logger.info(f"LLaMa response:\n{msg}\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\n")
        return msg
    
    def generate_sql_for_table_schema(self, number_of_tables, name, subject):
        logger.info(f"Generating SQL for {name} about {subject} with {number_of_tables} tables")
        # Call LLaMa to generate the SQL for the table schema
        prompt = SYSTEM_PROMPT_FOR_SCHEMA_GENERATION.format(
            number_of_tables, name, subject 
        )
        return self.call_llama(prompt)
            
    def generate_sql_for_table_rows(self, table_schema_sql):
        logger.info(f"Generating SQL to populate tables")
        # Call LLaMa to generate the SQL for the table schema
        prompt = SYSTEM_PROMPT_FOR_ROWS_GENERATION.format(
            table_schema_sql
        )
        return self.call_llama(prompt)

    def review_sql(self, sql_table_schema, error, review_prompt):
        logger.info("Reviewing SQL for error")
        # Call LLaMa to review the SQL for the table schema given the error
        prompt = review_prompt.format(
            error, sql_table_schema
        )
        return self.call_llama(prompt)
    
    def try_and_review_loop(self, sql_code, schema_name, review_prompt, max_attempts=5, database_name=None):
        if max_attempts is None:
            max_attempts = self.max_attempts
        n_attempt = 0
        while True:
            error = execute_in_postgres(sql_code, schema_name, database_name)
            if error is None:
                logger.info(f"Try&Review loop succeded after {n_attempt} attempts")
                break
            if error and n_attempt == self.max_attempts:
                logger.info(f"Try&Review loop got error! -> {error} \n")
                logger.warning(f"Try&Review loop failed after {n_attempt} attempts")
                return None
            else:
                logger.info(f"Try&Review loop got error! -> {error} \n")
                sql_code = self.review_sql(sql_code, error, review_prompt)
                sql_code = exclude_natural_language(sql_code)
                logger.info(f"After deleting natural language:\n{sql_code}\n\n")
                sql_code = remove_any_trailing_comma(sql_code)
                n_attempt += 1
        return sql_code

    def generate_table_schema(self, number_of_tables, schema_subject, schema_name):
        number_of_generated_tables = 0
        while number_of_generated_tables < number_of_tables:
            sql_table_schema = self.generate_sql_for_table_schema(number_of_tables, schema_subject, schema_name)
            sql_table_schema = exclude_natural_language(sql_table_schema)
            number_of_generated_tables = sql_table_schema.count("CREATE TABLE")
            logger.info(f"Generated {number_of_generated_tables} tables out of {number_of_tables}")

        logger.info(f"After deleting natural language:\n{sql_table_schema}\n\n")
        sql_table_schema = self.try_and_review_loop(sql_table_schema, schema_name, SYSTEM_PROMPT_FOR_REVIEW)
        if sql_table_schema:
            logger.info("Successfully generated SQL for {} with {} tables".format(schema_subject, number_of_tables))
        else:
            logger.warning("Failed to generate SQL for {} with {} tables".format(schema_subject, number_of_tables))
        return sql_table_schema

    def generate_table_rows(self, sql_table_schema, schema_name, database_name):
        table_rows_sql = self.generate_sql_for_table_rows(
            sql_table_schema
        )
        table_rows_sql = exclude_natural_language(table_rows_sql)
        table_rows_sql = fix_missing_commas(table_rows_sql)
        logger.info(f"After deleting natural language:\n{table_rows_sql}\n\n")

        table_rows_sql = self.try_and_review_loop(table_rows_sql, schema_name, SYSTEM_PROMPT_FOR_REVIEW, database_name=database_name)

        if table_rows_sql:
            logger.info("Successfully generated SQL for {}".format(schema_name))
        else:
            logger.warning("Failed to generate SQL for {}".format(schema_name))
        return table_rows_sql
