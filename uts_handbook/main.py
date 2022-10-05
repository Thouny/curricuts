import enum
from bs4 import BeautifulSoup
import requests
import json

with open('/Users/anthonyvu/Projects/uni/curricuts/uts_handbook/subject_map_2021.json', 'r+') as json_file:
    subjects = json.load(json_file)
    print("Type:", type(subjects))
    # Iterate through each subject
    for subjectCode in subjects:
        currentSubjectCode = subjectCode
        url = "https://handbook.uts.edu.au/subjects/%s.html" % currentSubjectCode
        availabilities = []
        r = requests.get(url)
        soup = BeautifulSoup(r.content)
        for e in soup.stripped_strings:
            if "Autumn session" in e or "Spring session" in e or "Summer session" in e:
                print(e)
                availabilities.append(e)
        subjects[currentSubjectCode]['availabilities'] = availabilities
        print(subjects[currentSubjectCode])

    json_object = json.dumps(subjects, indent=4)
    json_file.write(json_object)
