#!/usr/bin/env python

from early_warning_project.dataset import Dataset

# This is a sample template for a new dataset
# Simply remove the pass statements and implement the 3 methods below using your configuration file

class Template(Dataset):

    def __init__(self):
        # super(Aut, self).__init__()
        # self.name = self.config.get('aut', 'name')
        # self.url = self.config.get('aut', 'url')

        # You will need to set at least the name and the url for the dataset
        pass

    def download_data(self):
        # Download latest file
        # Here is where you would download a file, unpack it, and set the raw file(s) to the data_in directory
        pass

    def build_data(self):
        # This is the brain of your dataset
        # It controls getting the raw data out of data_in and sending it to data_out
        # You are welcome to make helper classes and methods to handle parsing, slicing, dicing, etc.
        pass


# All you are doing here is making it possible for this dataset to run on it's own
# You can simply change the name of the 'Template' class to the name of your dataset class
def main():
    dataset = Template()
    Template.download_data(dataset)
    Template.build_data(dataset)

if __name__ == '__main__':
    main()