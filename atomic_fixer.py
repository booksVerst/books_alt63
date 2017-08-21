import re
import os

def replace(filepath, replaceList):
	with open(filepath, 'r', encoding='utf-8') as handler:
		data = handler.read()

	for pattern, replace in replaceList:
		data = re.sub(pattern, replace, data)
	
	with open(filepath, 'w', encoding='utf-8') as handler:
		handler.write(data)

def fixfile(filepath):
	replace(filepath, [
		(r'<atomic_object[^>]*>', r''),
		(r'</atomic_object>', r''),
	])

def getseparatefiles(root):
	result = []

	for root, dirs, files in os.walk(root):
		for file in files:
			if '.xml' in file: result.append(os.path.join(root, file))

	return result

def main():
	for separate in getseparatefiles('./Articles'):
		fixfile(separate)

if __name__ == '__main__':
	main()
