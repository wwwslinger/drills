from nltk import FreqDist, word_tokenize
def best_words(text_1, text_2, diff_count, score_func=None):
    '''
    Args:
        text_1: a text (string) to be differentiated from text_2
        text_2: a text (string)
        diff_count: the number of differentiating words to be returned
    Returns:
        the top #(diff_count) words by which excerpts like text_1 can best
        be differentiated from excerpts like text_2 (e.g., spam vs ham), where
        best is defined as having maximum total frequency * freq-difference.
        Useful for generating the best words for spam filters, etc.

    '''
    # define usefulness score function for selecting words
    if score_func:
        usefulness_score = score_func
    else:
        def usefulness_score(word, fdist_1, fdist_2, len_1, len_2):
            freq_1 = fdist_1[word]
            freq_2 = fdist_2[word]
            total_freq = freq_1 + freq_2

            rel_freq_1 = freq_1/len_1
            rel_freq_2 = freq_2/len_2
            minprob, maxprob = sorted((rel_freq_1, rel_freq_2))
            prob_diff = 1 - minprob/maxprob

            return total_freq * prob_diff

    # tokenize texts and generate frequency distributions
    wordlist_1 = word_tokenize(text_1)
    wordlist_2 = word_tokenize(text_2)
    fdist_1 = FreqDist(wordlist_1)
    fdist_2 = FreqDist(wordlist_2)

    if len(fdist_1) < len(fdist_2):
        small_fdist = fdist_1
        large_fdist = fdist_2
    else:
        small_fdist = fdist_2
        large_fdist = fdist_1

    # create dict of usefulness scores for most frequent num_to_test/2 words from each list
    num_to_test = max(diff_count*3, diff_count + 100)
    # NOTE: determining num_to_test is pretty arbitrary and can be toggled
    word_scores = {}
    tests_remaining = num_to_test
    most_freq_small = small_fdist.most_common(num_to_test)
    most_freq_large = large_fdist.most_common(num_to_test*2)
    # NOTE: most_common returns #input commonest words, or as many as possible
    # (doesn't produce an error if input is too large)

    for i in range(num_to_test//2):
        if i < len(small_fdist):
            word = most_freq_small[i][0]
            word_scores[word] = usefulness_score(word, fdist_1, fdist_2, len(wordlist_1), len(wordlist_2))
            tests_remaining -= 1
    overlap_buffer = 0
    for i in range(tests_remaining):
        try:
            word = most_freq_large[i][0]
        except IndexError:
            print("Texts are too small for the diff_count you submitted.  Try a smaller diff_count value.")
        if word in word_scores:
            tests_remaining += 1
        else:
            word_scores[word] = usefulness_score(word, fdist_1, fdist_2, len(wordlist_1), len(wordlist_2))

    # select the highest-scored #diff_count words from dict
    cutoff = sorted(word_scores.values())[-diff_count]
    best_words = [word for word in word_scores.keys() if word_scores[word] >= cutoff]

    return best_words[:diff_count] # just in case two words had exactly the cutoff value
