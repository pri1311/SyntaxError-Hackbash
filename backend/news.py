import requests
import sys
import csv
import random 
from bs4 import BeautifulSoup
 
# LIMIT = 10 # Valid values: 10, 20, 30, 40, 50, and 100
USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
]

class news:
    def make_request():
        google_url = 'https://www.google.com/search?q=environment+news+inshorts&rlz=1C1CHBF_enIN921IN921&oq=envi&aqs=chrome.0.69i59l2j69i57j69i59j35i39j0i67i433j69i60j69i61.1843j0j7&sourceid=chrome&ie=UTF-8uact=3'
        response = requests.get(google_url, headers={'User-Agent': random.choice(USER_AGENTS)})
        # print(response.content)
        return response.content

    def parse_content(html):
        count = 0
        soup = BeautifulSoup(html,'html.parser')
        results = []
        # items = soup.find_all("div",class_="")[ 'sh-dgr__gr-auto','sh-pr__grid-result']
        items = soup.findAll("div", {'class':'g'})
        for item in items:  
            if count < 3:# print(item)
                link = item.div.div.a.get('href')
                # print(link)
                title = item.div.div.a.h3.text
                response = requests.get(link, headers={'User-Agent': random.choice(USER_AGENTS)})
                # print(response.content)
                soup = BeautifulSoup(response.content,'html.parser')
                author = soup.find('span', {'class':'author'}).text
                date = soup.find('span', {'class':'date'}).text
                time = soup.find('span', {'class':'time'}).text
                content = soup.find('div', {'itemprop':'articleBody'}).text
                results.append({'title':title, 'content':content, 'author':author, 'date':date, 'time':time})
                count=count+1
        # print(results[0])
        return results