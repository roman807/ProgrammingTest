#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Roman Moser, 12/23/18

"""
PYTHON Programming Test: "JSON to CSV"
run with: python3 main.py 
"""

import json
import pandas as pd
import os
os.chdir('data')

def flatten_json(dict_, key_prior, dict_new):
    for key, val in dict_.items():
        if type(val) == dict:
            key = key_prior + key + '_'
            flatten_json(val, key, dict_new)
        else:
            key = key_prior + key
            dict_new[key] = val
    return dict_new

def main():
    dictionaries = []
    for item in os.listdir():
        try: os.chdir(item)
        except: continue
        for file in os.listdir():
            if file.endswith('.json'):
                dict_new = {'transactionid': file.split('_')[0]}
                json_original = json.loads(open(file).read())
                dict_new = flatten_json(json_original, '', dict_new)
                dictionaries.append(dict_new)
        os.chdir('..')
    os.chdir('..')
    df = pd.DataFrame(dictionaries)
    cols = [df.columns.tolist()[-1]] + df.columns.tolist()[:-1]
    df = df[cols]
    df.to_csv('CSV_data.csv', index=False)
    
if __name__ == '__main__':
    main()