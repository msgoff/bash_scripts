source /media/data/Github/user_defined_functions 
postgres "drop table temp_test"
postgres "update  hn_stories set url_domain=(regexp_split_to_array(url,'/'))[3]"
postgres "create table temp_test as select distinct(url_domain),count(url_domain) over (partition by url_domain) as url_domain_count from hn_stories "
postgres "update hn_stories set url_domain_count=(select url_domain_count from temp_test  where hn_stories.url_domain=temp_test.url_domain)"
postgres "select distinct(url_domain),url_domain_count from hn_stories  where url_domain_count > 0 order by url_domain_count desc"
