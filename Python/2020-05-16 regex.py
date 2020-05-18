import re # Regular Expression/RegEx

# Search for phone number
message = 'Call me @ 260-425-0075 or shoot a text at 510-428-5678.'

phoneNumRegex = re.compile(r'\d\d\d-\d\d\d-\d\d\d\d') # specify the pattern
mo = phoneNumRegex.search(message) # match object
mo1 =  phoneNumRegex.findall(message)

print(mo.group())   # 260-425-0075 as first phone number
print(mo1)      # ['260-425-0075', '510-428-5678'] a list of all phone numbers

# Search for area code
codeNumRegex = re.compile(r'(\d\d\d)-(\d\d\d)-(\d\d\d\d)')
mo2 = codeNumRegex.search(message)
print(mo2.group(1))     # 260. group(1) is the 1st group.
# group() or group(0) is the full matching string

# Batch regex (Pipe)
batRegex = re.compile(r'Bat(man|mobile|copter|bat)') # specify the pattern with re.compile
mo = batRegex.search('Batmobile lost a wheel') # Search
print(mo.group()) # Print result

# Match a specific number of references
batRegex = re.compile(r'Bat(wo)?man') # Either Batman or Batwoman. wo once or zeo times
mo = batRegex.search('The Adventures of Batman')
print(mo.group())
mo = batRegex.search('The Adventures of Batwoman')
print(mo.group())

print()

batRegex = re.compile(r'Bat(wo)*man') # Either Batman or Batwoman. many times
mo = batRegex.search('The Adventures of Batwowowowowoman')
print(mo.group())

print()

batRegex = re.compile(r'Bat(wo)+man') # Either Batman or Batwoman. Must be wo at least once
mo = batRegex.search('The Adventures of Batwowowowowoman')
print(mo.group())

print()

# Substitution Regex
namesRegex = re.compile(r'Agent \w+')
namesRegex.findall('Agent Alice gave the secrete documents to Agent Bob.')
mo = namesRegex.sub('REDACTED', 'Agent Alice gave the secrete documents to Agent Bob.')
print(mo)   # REDACTED gave the secrete documents to REDACTED.
namesRegex = re.compile(r'Agent (\w)\w*')
mo = namesRegex.findall('Agent Alice gave the secrete documents to Agent Bob.')
print(mo)   # ['A', 'B']
mo = namesRegex.sub(r'Agent \1****', 'Agent Alice gave the secrete documents to Agent Bob.')
print(mo)   # Agent A**** gave the secrete documents to Agent B****.

