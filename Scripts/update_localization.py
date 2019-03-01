import json
import os
import argparse
import sys


relative_dir_path = '../iAqualink/iAqualink/'
languages_to_update=[]

EN_CODE = "EN"
FR_CODE = "FR"
ES_CODE = "ES"
DE_CODE = "DE"
IT_CODE = "IT"
PT_CODE = "PT"
NL_CODE = "NL"

def formatString(baseLang, targetLang):
    if "\n" in targetLang:
        targetLang = targetLang.replace("\n", "\\n")
    if "\"" in targetLang:
        targetLang = targetLang.replace("\"", "\\\"")
    if "%s" in targetLang:
        targetLang = targetLang.replace("%s", "%@")
    newstr = "\"" + baseLang + "\" = \"" + targetLang + "\";"
    return newstr

parser = argparse.ArgumentParser(description='Updates .strings files in chosen languages')

parser.add_argument("--userpath", help="custom user path for localization directories", default="default")
parser.add_argument("--EN", help="English", action="store_true")
parser.add_argument("--FR", help="French", action="store_true")
parser.add_argument("--ES", help="Spanish", action="store_true")
parser.add_argument("--DE", help="German", action="store_true")
parser.add_argument("--IT", help="Italian", action="store_true")
parser.add_argument("--PT", help="Portuguese", action="store_true")
parser.add_argument("--NL", help="Dutch", action="store_true")
parser.add_argument("--file", help="File name of .json file to be read from", required = True)

update_all = True
args = parser.parse_args()
strings_file = "Localizable.strings"
json_file = args.file

if args.EN:
    languages_to_update.append(EN_CODE)
    update_all = False
if args.FR:
    languages_to_update.append(FR_CODE)
    update_all = False
if args.ES:
    languages_to_update.append(ES_CODE)
    update_all = False
if args.DE:
    languages_to_update.append(DE_CODE)
    update_all = False
if args.IT:
    languages_to_update.append(IT_CODE)
    update_all = False
if args.PT:
    languages_to_update.append(PT_CODE)
    update_all = False
if args.NL:
    languages_to_update.append(NL_CODE)
    update_all = False

if os.path.isfile(json_file):
    localizationFile = open(json_file, "r", encoding="utf-8")
    string = localizationFile.read()
    dictionary = json.loads(string)
    langCode = dictionary["Key"]
    langCode.pop("Primary Language Code")
 ##   langCode.pop("Alternate Keys")
 ##   langCode.pop("Scene")
    dictionaryTermsOnly = dictionary
    dictionaryTermsOnly.pop("Key")
    dictionaryTermsOnly.pop("Default To")
    dictionaryTermsOnly.pop("Language Codes")

    if update_all==True:
        for lang, langCVal in langCode.items():
            languages_to_update.append(lang)

    for key,item in langCode.items():
        print("Attempting to update: " + key)
        if "EN" in key:
            folder = "Base.lproj"
        else:
            folder = key + ".lproj"
        script_dir = os.path.dirname(__file__)
        if args.userpath=="default":
            path_search = os.path.join(script_dir, relative_dir_path+folder)
        else:
            path_search = args.userpath
        if key in languages_to_update:
            if os.path.exists(path_search):
                path=os.path.join(path_search, strings_file)
                currentLocalizable=open(path, "w", encoding='utf-8')
                
                for keyword, phraseTrans in dictionaryTermsOnly.items():
                    baseLang = keyword
                    targetLang = phraseTrans[key]
                    formattedOut = formatString(baseLang, targetLang)
                    currentLocalizable.write(formattedOut + "\n")
                currentLocalizable.close()
                print("Updated: " + key)
            else:
                print("WARNING: Tried to update "+ key +" but this language has not been added to the project or cannot be found.")
            
    localizationFile.close()
else:
    print("The json file was not found")
