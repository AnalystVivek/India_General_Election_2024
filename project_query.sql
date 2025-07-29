use election_analysis;

select * from constituencywise_details;

select * from constituencywise_results;

select * from statewise_results;

select * from partywise_results;

select * from states;

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
-- Total Seats
                select 
       distinct count(Parliament_Constituency) as Total_seats 
       from constituencywise_results;


-- What is the total number of seats available for elections in each state?

select 
s.State as State_Name, count(cr.Parliament_Constituency) as Total_Seats
from constituencywise_results cr
inner join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
inner join states s on s.State_ID = sr.State_ID
group by s.State
order by count(cr.Parliament_Constituency) desc;


-- Total Seats Won by NDA Alliance

select
sum(case when party in ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
) then [won] else 0
end) as NDA_Total_Seats_Won
from partywise_results;

                                        -- OR --

select sum(won) as NDA_Total_Seats_Won from partywise_results where party in 
               ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM');


-- Seats Won by NDA Alliance Parties

select Party as NDA_Alliance_Party_Name, Won as Seats_Won
from partywise_results
where Party in 
                ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
order by Seats_Won desc;


--  Total Seats Won by I.N.D.I.A. Alliance

select sum(won) as INDIA_Alliance_Total_Seats_Won from partywise_results where party in 
('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK');

-- Seats Won by I.N.D.I.A. Alliance Parties

select Party as INDIA_Alliance_Party_Name, Won as Seats_Won
from partywise_results
where Party in 
                ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
order by Seats_Won desc;


-- Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER.

alter table partywise_results
add party_alliance varchar(100);

update partywise_results set party_alliance = CASE 
     when Party in 
                ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK') then 'I.N.D.I.A'
    when party in 
                 ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') then 'NDA'
    else 'OTHERS'
END;


-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

select party_alliance as Party_Alliance, sum(won) as Total_Seats
from partywise_results
group by party_alliance
order by sum(won) desc;


-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

select top 10
cr.Winning_Candidate as "Candidate's Name",
pr.Party as 'Party Name',
cr.Total_Votes as 'Total votes',
cr.Margin as 'Margin of Victory',
s.State,
cr.Constituency_Name as 'Constituency Name'
from constituencywise_results cr
inner join partywise_results pr on pr.party_id = cr.party_id
inner join statewise_results sr on cr.parliament_constituency = sr.parliament_constituency
inner join states s on s.state_id = sr.state_id
order by cr.Total_Votes desc ;


-- What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

select
cd.candidate,
cd.evm_votes,
cd.postal_votes,
cr.constituency_name,
pr.party_alliance
from constituencywise_results cr
inner join constituencywise_details cd on cr.constituency_id = cd.constituency_id
inner join partywise_results pr on pr.Party_ID = cr.Party_ID
order by cr.constituency_name;


-- Which parties won the most seats in a State, and how many seats did each party win?

select 
pr.party as 'Party Name',
sum(pr.won) as 'Seats Won'
from partywise_results pr
inner join constituencywise_results cr on pr.Party_ID = cr.Party_ID
inner join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
inner join states s on sr.State_ID = s.State_ID
where s.State = 'Bihar'
group by pr.party
order by sum(pr.won) desc;


-- What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) 
-- in each state for the India Elections 2024

select
s.state as 'State Name',
sum(case when pr.party_alliance = 'NDA' then 1 else 0 end) as 'NDA Seats',
sum(case when pr.party_alliance = 'I.N.D.I.A' then 1 else 0 end) as 'I.N.D.I.A Seats',
sum(case when pr.party_alliance = 'OTHERS' then 1 else 0 end) as 'OTHER Seats'
from partywise_results pr
inner join constituencywise_results cr on pr.Party_ID = cr.Party_ID
inner join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
inner join states s on sr.State_ID = s.State_ID
group by s.state
order by s.state ;


-- Which candidate received the highest number of EVM votes in each constituency (Top 10)?

select top 10
cr.Constituency_Name,
cd.Constituency_ID,
cd.Candidate,
cd.EVM_Votes
from constituencywise_details cd
inner join constituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID
where 
    cd.EVM_Votes = ( select MAX(cd1.evm_votes) from constituencywise_details cd1
                    where cd1.Constituency_ID = cd.Constituency_ID )
order by cd.EVM_Votes desc;


-- Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?

with RankedCandidate as
(
select
    cd.Constituency_ID,
    cd.Candidate,
    cd.Party,
    cd.EVM_Votes,
    cd.Postal_Votes,
    cd.EVM_Votes + cd.Postal_Votes as Total_votes,
    ROW_NUMBER() over (partition by  cd.Constituency_ID order by cd.EVM_Votes + cd.Postal_Votes desc) as Voter_Ranking
from constituencywise_details cd
inner join constituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID
inner join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
inner join states s on sr.State_ID = s.State_ID
where s.State = 'Odisha'
)
select 
cr.constituency_name,
MAX(case when rc.Voter_Ranking = 1 then rc.candidate end) as 'Winnig candidate',
MAX(case when rc.Voter_Ranking = 2 then rc.candidate end) as 'Runnerup Candidate'
from RankedCandidate rc
inner join constituencywise_results cr on rc.Constituency_ID = cr.Constituency_ID
group by cr.Constituency_Name
order by cr.Constituency_Name;

------------------------------------------------  OR   -----------------------------------------------

select 
state as 'State Name',
constituency_name as 'Constituency Name',
max(case when Voter_Ranking = 1 then candidate end) as 'Winning Candidate',
max(case when Voter_Ranking = 2 then candidate end) as 'Runnerup Candidate'
from
(
select
    cd.Constituency_ID,
    cd.Candidate,
    cd.Party,
    cr.constituency_name,
    s.state,
    cd.EVM_Votes + cd.Postal_Votes as Total_votes,
    ROW_NUMBER() over (partition by  cd.Constituency_ID order by cd.EVM_Votes + cd.Postal_Votes desc) as Voter_Ranking
from constituencywise_details cd
inner join constituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID
inner join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
inner join states s on sr.State_ID = s.State_ID
) as win_data
where  State = 'Odisha'
group by state,constituency_name ;


-- For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties,
-- total votes (including EVM and postal), and the breakdown of EVM and postal votes?
select
    count( distinct cr.Constituency_ID) as 'Total Seats',
    count(distinct cd.Candidate) as 'Total Candidate',
    count(distinct cd.Party) as 'Total Parties',
    sum(cd.EVM_Votes) as 'Total EVM Votes',
    sum(cd.Postal_Votes) as 'Total Postal Votes' ,
    sum(cd.EVM_Votes + cd.Postal_Votes) as 'Total votes'
from constituencywise_details cd
inner join constituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID
inner join partywise_results pr on pr.Party_ID = cr.Party_ID
inner join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
inner join states s on sr.State_ID = s.State_ID
where s.State = 'Maharashtra'
