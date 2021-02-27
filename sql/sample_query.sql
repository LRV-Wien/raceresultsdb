root@localhost:5432 [lrvwien_raceresults] # \COPY
  (SELECT count(*) over (partition BY rider_id),
          al.last_name,
          al.first_name,
          rider_id,
          al.club,
          rr.category_national,
          racetypes.name,
          POSITION,
          race_name,
          race_longname
   FROM race_results rr
   JOIN racetypes ON rr.racetype_id=racetypes.id
   JOIN aktive_lizenzen al ON (rr.rider_id=al.uci_id
                               AND rr.category_national=al.category_national
                               AND rr.raceday_year=al.valid_for_year)
   WHERE raceday_year=2019
     AND POSITION < 4
   ORDER BY 1,
            last_name ASC, first_name DESC, POSITION DESC) TO 'wiener_landesmeister_2019.csv' csv;
