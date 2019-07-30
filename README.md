# DemographySpawnR

The premise of DemographySpawnR is simple: input a dataset and based on the distributions of the variables in that dataset, create a new/simulated one that is distributionally similar. It could allow users to de-identify data if they wanted to share the data but keep confidential data, well, confidential.

The package is intended to take an input dataset and be able to simulate a new dataset based on the distributions of the variables in the input dataset. It reads each variable 1 at a time and determines its type: categorical (how many levels?), continuous (rounded/decimal), addresses/names/sensitive information, dates that are in the “yyyymmdd,” or the user is able to specify the format of dates (also possible to allow for multiple date formats – still working on this. Proving to be a little trickier than before). 

After reading the variable type, the idea is to be able to take the distributions of those variables and output a dataset that is virtually the same as the original dataset but with potentially sensitive information such as PII removed. For example, if a variable is a categorical variable, we compute the frequencies/percentages of each level (including missing and NA values) and use those as sampling weights in the output simulated dataset. If a variable is continuous, for simplicity, we assume a normal distribution (knowing fully well this is not always the case) with the mean equal to the mean of the variable in the input dataset, and respective standard deviation (excluding missing and NA values). If missing data are present, we calculate the proportion of missing/NA values per column, and and after populating the entire variable with values from a normal distribution, we either keep the value or insert a missing/NA into each row with a probability of [the proportion of column that is missing]. 
s
Another functionality is the ability to list all possible variable combinations that may be correlated or associated – continuous with continuous and categorical with categorical. Moreover, the user is able to calculate the respective correlations and p-values for each pair of variables. In addition to getting all variable pairs and their correlations, a user is also able to input categorical variables that they already know to be correlated and sample into the output dataset given the bivariate distribution of those 2 variables. 
In addition to different types of categorical and continuous variables, ideally Demography SpawnR is able to recognize any standard date format and sample random dates given the range of the input dates. However, that is proving extremely tricky because manipulating dates in R is hard.
The functions are scalable up-to virtually any size input and output dataset, but the runtime depends on how patient you are :) 



*This repository was created for use by CDC programs to collaborate on public health surveillance related projects in support of the CDC Surveillance Strategy.  Github is not hosted by the CDC, but is used by CDC and its partners to share information and collaborate on software.*

## Public Domain

This repository constitutes a work of the United States Government and is not
subject to domestic copyright protection under 17 USC § 105. This repository is in
the public domain within the United States, and copyright and related rights in
the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
All contributions to this repository will be released under the CC0 dedication. By
submitting a pull request you are agreeing to comply with this waiver of
copyright interest.

## License

The repository utilizes code licensed under the terms of the Apache Software
License and therefore is licensed under ASL v2 or later.

This source code in this repository is free: you can redistribute it and/or modify it under
the terms of the Apache Software License version 2, or (at your option) any
later version.

This source code in this repository is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the Apache Software License for more details.

You should have received a copy of the Apache Software License along with this
program. If not, see http://www.apache.org/licenses/LICENSE-2.0.html

The source code forked from other open source projects will inherit its license.

## Privacy

This repository contains only non-sensitive, publicly available data and
information. All material and community participation is covered by the
Surveillance Platform [Disclaimer](https://github.com/CDCgov/template/blob/master/DISCLAIMER.md)
and [Code of Conduct](https://github.com/CDCgov/template/blob/master/code-of-conduct.md).
For more information about CDC's privacy policy, please visit [http://www.cdc.gov/privacy.html](http://www.cdc.gov/privacy.html).

## Contributing

Anyone is encouraged to contribute to the repository by [forking](https://help.github.com/articles/fork-a-repo)
and submitting a pull request. (If you are new to GitHub, you might start with a
[basic tutorial](https://help.github.com/articles/set-up-git).) By contributing
to this project, you grant a world-wide, royalty-free, perpetual, irrevocable,
non-exclusive, transferable license to all users under the terms of the
[Apache Software License v2](http://www.apache.org/licenses/LICENSE-2.0.html) or
later.

All comments, messages, pull requests, and other submissions received through
CDC including this GitHub page are subject to the [Presidential Records Act](http://www.archives.gov/about/laws/presidential-records.html)
and may be archived. Learn more at [http://www.cdc.gov/other/privacy.html](http://www.cdc.gov/other/privacy.html).

## Records

This repository is not a source of government records, but is a copy to increase
collaboration and collaborative potential. All government records will be
published through the [CDC web site](http://www.cdc.gov).

## Notices

Please refer to [CDC's Template Repository](https://github.com/CDCgov/template)
for more information about [contributing to this repository](https://github.com/CDCgov/template/blob/master/CONTRIBUTING.md),
[public domain notices and disclaimers](https://github.com/CDCgov/template/blob/master/DISCLAIMER.md),
and [code of conduct](https://github.com/CDCgov/template/blob/master/code-of-conduct.md).
