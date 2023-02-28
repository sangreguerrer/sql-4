--Количество исполнителей в каждом жанре.
SELECT count(artist_id),genre_name FROM genre_artist ga 
JOIN genre g ON ga.genre_id = g.id
JOIN artist a ON ga.artist_id=a.id 
GROUP BY genre_name;

--Количество песен за период 2018-2020.
SELECT count(song_name) FROM songs s
JOIN album a ON s.album_id = album_id
WHERE a.release_year BETWEEN 2018 AND 2020;

--Средняя продолжительность треков в альбоме
SELECT avg(duration),album_name  FROM songs s
JOIN album a ON s.album_id = a.id 
GROUP BY album_name ;

--Исполнители,не выпустившие альбомы в 2020.
SELECT DISTINCT  artist_name FROM artist a
JOIN album_artist aa ON a.id=aa.artist_id
JOIN album al ON aa.album_id=al.id
WHERE al.release_year<>2020;

--Сборники с определённым исполнителем.
SELECT compilation_name FROM Compilation c
JOIN comp_song cs ON c.id=cs.comp_id
JOIN songs s ON cs.song_id=s.id
JOIN album al ON s.album_id=al.id
JOIN album_artist aa ON al.id=aa.album_id 
JOIN artist a ON aa.artist_id=a.id
WHERE artist_name = '21 savage';

--Альбомы исполнителей, играющих в разных жанрах.
SELECT album_name FROM album a
JOIN album_artist aa ON a.id=aa.album_id
JOIN artist ar ON aa.artist_id=ar.id 
JOIN genre_artist ga ON ar.id=ga.artist_id 
JOIN genre g ON ga.genre_id = g.id
GROUP BY album_name 
HAVING count(genre_name)>1;

--Треки,не входящие в сборники.
SELECT song_name FROM songs s 
LEFT JOIN comp_song cs ON s.id=cs.song_id
LEFT JOIN compilation c ON cs.comp_id =c.id 
WHERE cs.comp_id IS NULL;

--Название исполнителей,написавших самый короткий трек
SELECT artist_name FROM artist a 
JOIN album_artist aa ON a.id=aa.artist_id 
JOIN album al ON aa.album_id=al.id
JOIN songs s ON al.id=s.album_id 
WHERE s.duration = (SELECT min(s.duration) FROM songs s)
;
--Названия альбомов, содержащих наименьшее количество треков.
SELECT album_name,count(song_name) FROM album a
JOIN songs s ON a.id=s.album_id
GROUP BY album_name
HAVING count(s.id)=(SELECT count(s2.id) FROM songs s2
                       JOIN album a2 ON s2.album_id=a2.id
                       GROUP BY album_name
                       LIMIT 1);