package com.soutipai.utils;

import org.apdplat.word.WordSegmenter;
import org.apdplat.word.segmentation.Word;

import java.util.List;

public class FenCiUtil {
    public List<Word> run(String s){
        List<Word> words = WordSegmenter.segWithStopWords(s);
        return words;
    }
}
