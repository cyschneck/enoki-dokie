from bs4 import BeautifulSoup
import pandas as pd
from urllib import request, error
import logging
import random
import re
import numpy as np

## Logging set up for .INFO
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
stream_handler = logging.StreamHandler()
logger.addHandler(stream_handler)

def _retrieve_morphbox():
	logger.info("Refreshing: mushroom_morphbox.csv")

	user_agents = [
		'Mozilla/6.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36',
		'Mozilla/6.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36',
		'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
		'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
		'Mozilla/6.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
		'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Safari/605.1.15',
		'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Safari/605.1.15'
	]
	random_agent = random.choice(user_agents)

	# BeautifulSoup web scrapping to find mushrooms for wikipedia
	logger.info(
		"Retrieving observation information from Template:Mycomorphbox...."
	)
	n = 1700 # currently there are 1590 total entries, this captures all of them to filter
	base_url = f"https://en.wikipedia.org/wiki/Special:WhatLinksHere?target=Template%3AMycomorphbox&namespace=0&hidetrans=1&limit={n}"
	req_with_headers = request.Request(url=base_url,
									   headers={'User-Agent': random_agent})
	mycomorphbox_html = request.urlopen(req_with_headers).read()
	soup = BeautifulSoup(mycomorphbox_html, 'html.parser')
	unordered_list = soup.find("ul", {"id": "mw-whatlinkshere-list"})
	wiki_links = []
	for li in unordered_list.find_all("li"):
		stub = li.find("a", href=True)["href"]
		wiki_link = f"https://en.wikipedia.org{stub}"
		wiki_links.append(wiki_link)

	wiki_info = {}
	common_names = []
	science_names = []
	hymenium = []
	cap = []
	gill = []
	stipe = []
	spore_color = []
	ecological_type = []
	edible = []
	wiki_links_relevant = []

	# testing
	#wiki_links = [
	#			"https://en.wikipedia.org/wiki/Hypomyces_lactifluorum",
	#			"https://en.wikipedia.org/wiki/Amanita_phalloides",
	#			"https://en.wikipedia.org/wiki/Calvatia_gigantea",
	#			"https://en.wikipedia.org/wiki/Shiitake",
	#			"https://en.wikipedia.org/wiki/Tremella_fuciformis",
	#			"https://en.wikipedia.org/wiki/Craterellus",
	#			"https://en.wikipedia.org/wiki/Fomitopsis_pinicola",
	#			"https://en.wikipedia.org/wiki/Hericium_erinaceus",
	#			"https://en.wikipedia.org/wiki/Armillaria",
	#			"https://en.wikipedia.org/wiki/Lactarius_rubrilacteus",
	#			"https://en.wikipedia.org/wiki/Calbovista",
	#			"https://en.wikipedia.org/wiki/Mycenastrum",
	#			"https://en.wikipedia.org/wiki/Callistosporium_purpureomarginatum",
	#			"https://en.wikipedia.org/wiki/Leucocoprinus_ianthinus",
	#			"https://en.wikipedia.org/wiki/Leucocoprinus_straminellus",
	#			"https://en.wikipedia.org/wiki/Leucocoprinus_flavescens",
	#			"https://en.wikipedia.org/wiki/Leucocoprinus_brunneoluteus",
	#			"https://en.wikipedia.org/wiki/Leucocoprinus_brunneoluteus",
	#			"https://en.wikipedia.org/wiki/Shaggy_parasol",
	#			"https://en.wikipedia.org/wiki/Tricholoma_magnivelare",
	#			"https://en.wikipedia.org/wiki/Conocybe_mesospora",
	#			"https://en.wikipedia.org/wiki/Pleurotus_euosmus",
	#			"https://en.wikipedia.org/wiki/Lactarius_aurantiacus",
	#			]
	cnt = -1

	for i, mushroom_wiki in enumerate(wiki_links):
		#logger.info(f"[{i+1}/{len(wiki_links)}] Retrieving from {mushroom_wiki}....")
		req_with_headers = request.Request(url=mushroom_wiki,
											headers={'User-Agent': random_agent})
		mushroom_html = request.urlopen(req_with_headers).read()
		soup = BeautifulSoup(mushroom_html, 'html.parser')
		table = soup.find_all('table', {"class": "infobox"})

		# only saves a subset of mushrooms with complete templates
		ignore_genus = False
		if len(table[1].find_all("tr")) == 8: # ignore incomplate templates
			logger.info(f"Retrieving from {mushroom_wiki}...")
			cnt += 1
			wiki_links_relevant.append(mushroom_wiki)
			# return common name: first sentence in bold
			div = soup.find_all("div", {"id": "mw-content-text"})
			paragraphs = div[0].find_all("p")
			found_possible_name = False
			bolded_words = []
			index = 0
			for i, paragraph in enumerate(paragraphs):
				if len(paragraph.find_all("b")) != 0: # dynamically determine the first paragraph with relevant common names
					#print(paragraph.text)
					index = i
					break
			if "is a genus" in paragraphs[index].text:
				ignore_genus = True # ignore entries for entire genus of fungi
			for b in paragraphs[index].find_all("b"):
				bold_text = b.text.lower()
				bold_text = re.sub(r"\[.*?\]", "", bold_text).strip() # removes bolded "[2]"
				bold_text = re.sub(',(?!\\s+)', '', bold_text) # remove trailing commas
				bold_text = bold_text.split(", ")
				if bold_text != [""]:
					bolded_words.append(bold_text)
			bolded_words = sum(bolded_words, []) # flatten list
			if len(bolded_words) >= 2:
				found_possible_name = True
				common_names.append(",".join(bolded_words))
			if not found_possible_name:
				if not ignore_genus:
					common_names.append("none")
				else:
					common_names.append("")

		for i, infobox_row in enumerate(table[1].find_all("tr")):
			if len(table[1].find_all("tr")) == 8: # ignore incomplete templates

				# collect relevant information
				info = [b.text for b in infobox_row.find_all("b")]
				if None not in info:
					info = ", ".join(info)
					if "and" in info: # handles when "and" is included as bold
						info = ",".join(info.split(" and "))
				if len(info) == 0:
					info = "none"
				row_text = re.sub("\\s+", " ", infobox_row.text.strip())

				# scientific names
				if i == 0:
					science_name = row_text.replace("Mycological characteristics", "").lower()
					if science_name == "": # check if science name found in template, otherwise use header
						science_name = mushroom_wiki.split("/")[-1]
						science_name = science_name.replace("_", " ").lower()
					science_names.append(science_name)
					if science_name in common_names[cnt]: # remove duplicate name in common names
						updated_common_name = []
						for common_name in common_names[cnt].split(","):
							if science_name not in common_name:
								updated_common_name.append(common_name)
						updated_common_name = ",".join(updated_common_name)
						updated_common_name = updated_common_name.rstrip(",.")
						updated_common_name = updated_common_name.lstrip(",.")
						common_names[cnt] = updated_common_name
				# hymenium type
				if i == 1: 
					hymenium.append(info.lower())
				# cap shape
				if i == 2: 
					cap.append(info.lower())
				# gill type
				if i == 3: 
					gill.append(info.lower())
				# stipe character
				if i == 4: 
					stipe.append(info.lower())
				# spore color
				if i == 5:
					spore_color.append(info.lower())
				# ecological type
				if i == 6:
					ecological_type.append(info.lower())
				# edible type
				if i == 7:
					edible.append(info.lower())

	# drop any rows with nan
	wiki_info["scientific name"] = [np.nan if x == "" else x for x in science_names]
	wiki_info["common names"] = [np.nan if x == "" else x for x in common_names]
	wiki_info["hymenium type"] = [np.nan if x == "" else x for x in hymenium]
	wiki_info["cap shape"] = [np.nan if x == "" else x for x in cap]
	wiki_info["gill type"] = [np.nan if x == "" else x for x in  gill]
	wiki_info["stipe type"] = [np.nan if x == "" else x for x in stipe]
	wiki_info["spore color"] = [np.nan if x == "" else x for x in spore_color]
	wiki_info["ecological type"] = [np.nan if x == "" else x for x in ecological_type]
	wiki_info["edible"] = [np.nan if x == "" else x for x in edible]
	wiki_info["URL"] = [np.nan if x == "" else x for x in wiki_links_relevant]

	mushroom_df = pd.DataFrame.from_dict(wiki_info, orient="index").transpose()
	mushroom_df = mushroom_df.dropna()
	mushroom_df.to_csv("mushroom_morphbox.csv", index=False, header=True)
	print(f"--> Recorded {mushroom_df.shape[0]} Relevant Mushroom Entries")

if __name__ == '__main__':
	_retrieve_morphbox()  #   updates mushroom_morphbox.csv
