-- from revision 97
alter table feedback
  modify column text longtext not null;

alter table manga 
  modify column description longtext;
