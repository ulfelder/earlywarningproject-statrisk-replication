#!/usr/bin/env python

import smtplib
import os
import ConfigParser

def emailResults():

    config = ConfigParser.SafeConfigParser()

    # traverse root configuration directory
    main_base = os.path.dirname(os.path.abspath(__file__))
    config_directory = main_base + "/../conf"

    for root, dirs, files in os.walk(config_directory):
        path = root.split('/')
        for file in files:
            config.readfp(open(os.path.join(root, file)))

    # Specifying the from and to addresses
    print("Emailing results...")
    from_address = config.get('email_properties', 'from_addr')
    to_address = config.get('email_properties', 'to_addr').split(',')

    # Writing the message (this message will appear in the email)
    msg = "\r\n".join([
      "From: " + from_address,
      "Subject: Early Warning Project Build Complete",
      "",
      "The latest Early Warning Project transformation file is complete"
      ])

    # Gmail Login
    username = os.environ.get('EARLY_WARNING_USERNAME')
    password = os.environ.get('EARLY_WARNING_PASSWORD')

    # Sending the mail
    try:
        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.login(username, password)
        server.sendmail(from_address, to_address, msg)
        server.quit()
        print("Email sent.")

    except smtplib.SMTPAuthenticationError:
        print("Email Error: Authentication failed! Please verify the email username and password. Final build email will not be sent.")

def main():
    emailResults()

if __name__ == '__main__':
    main()