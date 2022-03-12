package ThisIsATest.Sort;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.*;

public class Jukebox8 {
    ArrayList<Song> songList = new ArrayList<>();

    public static void main(String[] args) {
        new Jukebox8().go();
    }

    public void go() {
        getSongs();
        print(songList);
        Collections.sort(songList);
        print(songList);
        TreeSet<Song> songSet = new TreeSet<>(songList);
        print(songSet);
    }

    void getSongs() {
        try {
            File file = new File("soutipai_server/src/ThisIsATest/Sort/SongList.txt");
            BufferedReader reader = new BufferedReader(new FileReader(file));
            String line;
            while ((line = reader.readLine()) != null) {
                addSong(line);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    void addSong(String lineToParse) {
        String[] tokens = lineToParse.split("/");

        Song nextSong = new Song(tokens[0], tokens[1], tokens[2], tokens[3]);
        songList.add(nextSong);
    }

    void print(Collection<Song> list){
        System.out.print('[');
        for(Song song:list){
            System.out.print(song.getTitle()+": "+song.getArtist()+", ");
        }
        System.out.println(']');
    }
}
