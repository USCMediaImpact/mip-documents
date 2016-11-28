CREATE TABLE newqtable 

/*-- For printing headers into CSV
SELECT
	'week', 'title', 'url', 'pageviews', 
	'scrollstart', '25p', '50p', '75p', '100p', 'relatedcontent', 
	'eop', '15s', '30s', '45s', '60s', '75s', '90s', 'comments', 'republish', 
	'email', 'tweet', 'fbrec', 'total', 'sharerate', 'rcclicks', 'rtclicks', 'totalclicks', 'clickthrough'

UNION ALL*/

SELECT 
	
-- week
a.week AS week,

-- title
(SELECT GROUP_CONCAT(b.title) FROM qtable b WHERE b.url = a.url and b.title NOT LIKE '%Page Not Found%') AS title,

-- url
a.url AS url, 

-- pageviews
(SELECT SUM(c.pageviews) FROM qtable c WHERE c.url = a.url and c.title NOT LIKE '%Page Not Found%') AS pageviews,

-- scrollstart
(SELECT SUM(d.scrollstart) FROM qtable d WHERE d.url = a.url and d.title NOT LIKE '%Page Not Found%') AS scrollstart,

-- 25p
(SELECT SUM(ff.25p) FROM qtable ff WHERE ff.url = a.url and ff.title NOT LIKE '%Page Not Found%') AS 25p,

-- 50p
(SELECT SUM(e.50p) FROM qtable e WHERE e.url = a.url and e.title NOT LIKE '%Page Not Found%') AS 50p,

-- 75p
(SELECT SUM(f.75p) FROM qtable f WHERE f.url = a.url and f.title NOT LIKE '%Page Not Found%') AS 75p,

-- 100p
(SELECT SUM(cc.100p) FROM qtable cc WHERE cc.url = a.url and cc.title NOT LIKE '%Page Not Found%') AS 100p,

-- relatedcontent
(SELECT SUM(bb.relatedcontent) FROM qtable bb WHERE bb.url = a.url and bb.title NOT LIKE '%Page Not Found%') AS relatedcontent,

-- eop
(SELECT SUM(g.eop) FROM qtable g WHERE g.url = a.url and g.title NOT LIKE '%Page Not Found%') AS eop,

-- 15s
(SELECT SUM(h.15s) FROM qtable h WHERE h.url = a.url and h.title NOT LIKE '%Page Not Found%') AS 15s,

-- 30s
(SELECT SUM(i.30s) FROM qtable i WHERE i.url = a.url and i.title NOT LIKE '%Page Not Found%') AS 30s,

-- 45s
(SELECT SUM(j.45s) FROM qtable j WHERE j.url = a.url and j.title NOT LIKE '%Page Not Found%') AS 45s,

-- 60s
(SELECT SUM(k.60s) FROM qtable k WHERE k.url = a.url and k.title NOT LIKE '%Page Not Found%') AS 60s,

-- 75s
(SELECT SUM(l.75s) FROM qtable l WHERE l.url = a.url and l.title NOT LIKE '%Page Not Found%') AS 75s,

-- 90s
(SELECT SUM(m.90s) FROM qtable m WHERE m.url = a.url and m.title NOT LIKE '%Page Not Found%') AS 90s,

-- comments
(SELECT SUM(n.comments) FROM qtable n WHERE n.url = a.url and n.title NOT LIKE '%Page Not Found%') AS comments,

-- republish
(SELECT SUM(o.republish) FROM qtable o WHERE o.url = a.url and o.title NOT LIKE '%Page Not Found%') AS republish,

-- email
(SELECT SUM(p.email) FROM qtable p WHERE p.url = a.url and p.title NOT LIKE '%Page Not Found%') AS email,

-- tweet
(SELECT SUM(q.tweet) FROM qtable q WHERE q.url = a.url and q.title NOT LIKE '%Page Not Found%') AS tweet,

-- fbrec
(SELECT SUM(r.fbrec) FROM qtable r WHERE r.url = a.url and r.title NOT LIKE '%Page Not Found%') AS fbrec,

-- total
(SELECT SUM(s.total) FROM qtable s WHERE s.url = a.url and s.title NOT LIKE '%Page Not Found%') AS total,

-- sharerate
100*((SELECT SUM(t.total) FROM qtable t WHERE t.url = a.url and t.title NOT LIKE '%Page Not Found%')/(SELECT SUM(u.pageviews) FROM qtable u WHERE u.url = a.url and u.title NOT LIKE '%Page Not Found%')) AS sharerate,

-- rcclicks
(SELECT SUM(v.rcclicks) FROM qtable v WHERE v.url = a.url and v.title NOT LIKE '%Page Not Found%') AS rcclicks,

-- rtclicks
(SELECT SUM(w.rtclicks) FROM qtable w WHERE w.url = a.url and w.title NOT LIKE '%Page Not Found%') AS rtclicks,

-- totalclicks
((SELECT SUM(x.rcclicks) FROM qtable x WHERE x.url = a.url and x.title NOT LIKE '%Page Not Found%') + (SELECT SUM(y.rtclicks) FROM qtable y WHERE y.url = a.url and y.title NOT LIKE '%Page Not Found%')) AS totalclicks,

-- clickthrough
100*(((SELECT SUM(z.rcclicks) FROM qtable z WHERE z.url = a.url and z.title NOT LIKE '%Page Not Found%') + (SELECT SUM(dd.rtclicks) FROM qtable dd WHERE dd.url = a.url and dd.title NOT LIKE '%Page Not Found%')) / (SELECT SUM(ee.relatedcontent) FROM qtable ee WHERE ee.url = a.url and ee.title NOT LIKE '%Page Not Found%')) AS clickthrough

FROM qtable a

WHERE a.title NOT LIKE '%Page Not Found%'

GROUP BY a.week, a.url 

-- for CSV output
/*INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/TTQReport_combined_removedPNF.csv'
CHARACTER SET binary
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';*/

