# import json
from github import Github as git
import csv

g = git("username", "password")

lang_code = {}

for repo in g.get_user().get_repos():
    # print(json.dumps(repo.raw_data, separators=(',', ':'), indent=4))
    # print("1", repo.name)
    # print("2", repo.description)
    # print("3", repo.language)
    # print("4", repo.size)
    # print("5", repo.get_languages())
    # print()

    langs = repo.get_languages()

    for lang in langs:
        if lang in lang_code:
            lang_code[lang] += langs[lang]
        else:
            lang_code[lang] = langs[lang]


lang_code["Python"] -= 23746

for lang in ["PHP", "CSS", "JavaScript"]:
    lang_code.pop(lang)

with open("langs.csv", "w", newline="") as f:
    write = csv.writer(
        f, delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)
    write.writerow(["lang", "bytes"])
    for lang in lang_code:
        write.writerow([lang, lang_code[lang]])
