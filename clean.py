import os
import re

def remove_comments_from_lua(code):
    # Remove multi-line comments: --[[ ... ]]
    code = re.sub(r'--\[\[.*?\]\]', '', code, flags=re.DOTALL)

    # Remove single-line comments: -- ...
    code = re.sub(r'--.*', '', code)

    return code

def clean_lua_files_in_current_directory():
    for filename in os.listdir('.'):
        if filename.endswith('.lua'):
            with open(filename, 'r', encoding='utf-8') as f:
                original_code = f.read()

            cleaned_code = remove_comments_from_lua(original_code)

            with open(filename, 'w', encoding='utf-8') as f:
                f.write(cleaned_code)

            print(f"Cleaned comments from: {filename}")

if __name__ == "__main__":
    clean_lua_files_in_current_directory()
