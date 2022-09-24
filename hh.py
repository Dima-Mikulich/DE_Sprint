import requests 
import json 
# https://api.dev.hh.ru/vacancies&text='python разработчик'
# https://api.hh.ru/vacancies/69819518

url = 'https://api.hh.ru/vacancies/'
final_list = []

for page_num in range(20):
    par = {'text': 'python разработчик','per_page':'100', 'page':page_num}
    request_list = requests.get(url, params=par)
    result_request_list = request_list.json()['items']
    

    for vacansia in result_request_list:
        request_vacansies = requests.get(url+vacansia['id']).json()
        try:
            
            experience =  request_vacansies['experience']['name'] 
        except KeyError:
            continue
            # experience = "Опыт не указан"
        
        
        if vacansia['salary'] !=None:
            if vacansia['salary']['from'] !=None:
                sal =  vacansia['salary']['from']
            elif vacansia['salary']['to'] !=None:
                sal =  vacansia['salary']['to']
            else:
                continue 
        new_i = {
            "title" : vacansia['name'],
            "work experience" : experience,
            "salary" : sal , 
            "region" : vacansia['area']['name']
        }
        final_list.append(new_i)
        print(new_i)

    # k = json.dumps(request_to.json(),ensure_ascii=False, indent=4)
    # print(k)

itog = {"data" : final_list }

k = json.dumps(itog,ensure_ascii=False, indent=4)

print(k)

