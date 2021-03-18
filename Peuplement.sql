drop procedure Peupler;
create procedure Peupler(n in number) deterministic as
    VTaille number;
    VPoids number;
begin
    for i in 1..n loop
        select
	    round(160+50*DBMS_Random.Value()),
	    round(40+100*DBMS_Random.Value())
	into
	    VTaille,
	    VPoids
	from dual;
        insert into maTable values(
	    null, -- Id
	    VTaille, -- Taille
	    VPoids, -- Poids
        null
	);
    end loop;
end;
/

call Peupler(20);
select count(*) from maTable;

commit;