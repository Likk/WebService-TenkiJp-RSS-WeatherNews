use inc::Module::Install;
name 'WebService-TenkiJp-RSS-WeatherNews';
all_from 'lib/WebService/TenkiJp/RSS/WeatherNews.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
