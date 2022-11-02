--no of rows in our dataset
select count(*) as no_of_rows from project.dbo.['Table 0$'];

--dataset for jharkhand and bihar
Select * from project..['Table 0$']
where state='Bihar' or state = 'Jharkhand';

--total population
Select Sum(Population) as total_population from project..['Table 0$'];

--avg growth of india
Select avg(growth)*100 as avg_growth_percentage from project..['Table 0$'];

--avg growth state wise 
Select state, avg(growth)*100 as avg_growth_percentage from project..['Table 0$']
group by State;

-- avg sex-ratio state wise
Select state, round(avg([Sex-Ratio]),2) as avg_sex_ratio from project..['Table 0$']
group by State
order by avg_sex_ratio DESC ;

-- avg literacy rate state wise and having >90
Select state, round(avg(literacy),2) as avg_literacy from project..['Table 0$']
group by State
Having avg(literacy)>90

--top 3 states showing highest growth ratio
Select top 3 state, avg(growth)*100 as avg_growth_percentage from project..['Table 0$']
group by State
order by avg_growth_percentage desc

--top 3 states showing lowest sex ratio
Select top 3 state, round(avg([Sex-Ratio]),2) as avg_sex_ratio from project..['Table 0$']
group by State
order by avg_sex_ratio ;


--top and bottom 3 literacy rate state
select * from (Select top 3 state, round(avg(literacy),2) as avg_literacy from project..['Table 0$']
group by State
order by avg_literacy desc) as a
union
select * from (Select top 3 state, round(avg(literacy),2) as avg_literacy from project..['Table 0$']
group by State
order by avg_literacy)
as b

--states  strats with a alphabet
select distinct(state) from project..['Table 0$']
where state like 'A%'

--total literate and illiterate population for each state 
select a.state, round(sum(a.literate_no),0) as literate,round(sum(a.illiterate_no),0) as illiterate from( 
select District, state, (literacy/100)*population as literate_no, Population-(literacy/100*population) as illiterate_no from project..['Table 0$']
) as a
group by State


--population in prev census
select a.state, sum(a.prev_census_population) as total_prev_census_population , sum(a.population) as current_census_population  from (
				select district, state, round(Population/(1+growth),0) as prev_census_population, Population from project..['Table 0$']) as a
group by state

-- top 3 district from each state having highest literacy rate
s