#! python3

import re, pyperclip

# Create a regex for phone numbers
phoneRegex = re.compile(r'''
# 415-555-0000, 555-0000, (415) 555-0000, 555-0000 ext 12345, ext.12345, x12345

(
(\d\d\d\)|(\(\d\d\d\\))?        # aread code (optional) 415 or (415) optional
(\s|-)                          # first seperator
\d\d\d                          # first 3 digits
-                               # seperator
\d\d\d\d                        # last 4 digits
((ext(\.)?\s)|x)                # extension word-part(optional)
 (\d{2,5})?                     # extension word-part(optional)
)
''', re.VERBOSE)

# Create a regex for email addresses
emailRegex = re.compile(r'''
# some.+_-thing@something.com

[a-zA-Z0-9_.+-]+                # name part
@                               # @ symbol
[a-zA-Z0-9_.+-]+                # domain name part
''', re.VERBOSE)

# Get the text off the clipboard
text = pyperclip.paste()

# Extract the email/phone from this text
extractedPhone = phoneRegex.findall(text)
extractedEmail = emailRegex.findall(text)

allPhoneNumbers = []
for phoneNumbers in extractedPhone:
    allPhoneNumbers.append(phoneNumber[0])

# Copy the extacted email/phone to the clipboard
results = '\n'.join(allPhoneNumbers) + '\n' + '\n'.join(extractedEmail)
pyperclip.copy(results)
