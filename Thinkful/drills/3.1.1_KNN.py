import numpy as np
import pandas as pd

class TwoKNN():
    '''
    Creates a KNN classifier based
    '''
    def __init__(self, x1_list, x2_list, y_list, k):
        self.x_tuples = [(x1_list[i], x2_list[i], y_list[i]) for i in range(len(x1_list))]
        self.k = k

    def classify(self, coordinates):
        '''
        Args:
            coordinates: a tuple of the two coordinates of the data point to be
            classified

        Returns:
            0 if the point at [coordinates] is classified as negative, 1 if positive
        '''
        x1 = coordinates[0]
        x2 = coordinates[1]
        k = self.k
        nearest = []
        i = 0
        while len(nearest) < k:
            for tup in self.x_tuples:
                if x1-i <= tup[0] <= x1+i and x2-i <= tup[1] <= x2+i:
                    distance = ( abs(x1-tup[0])**2 + abs(x2-tup[1])**2 )**.5
                    categorization = tup[2]
                    if (distance, tup[0], tup[1], categorization) not in nearest:
                        nearest.append((distance, tup[0], tup[1], categorization))
            i += 1

        nearest.sort()
        nearest = nearest[:k]
        positives = sum([tup[3] for tup in nearest])
        if positives > k/2:
            return 1
        else:
            return 0

    def change_k(self, new_k):
        self.k = new_k



# DRIVER:
music = pd.DataFrame()

# Some data to play with.
music['duration'] = [184, 134, 243, 186, 122, 197, 294, 382, 102, 264,
                     205, 110, 307, 110, 397, 153, 190, 192, 210, 403,
                     164, 198, 204, 253, 234, 190, 182, 401, 376, 102]
music['loudness'] = [18, 34, 43, 36, 22, 9, 29, 22, 10, 24,
                     20, 10, 17, 51, 7, 13, 19, 12, 21, 22,
                     16, 18, 4, 23, 34, 19, 14, 11, 37, 42]

# We know whether the songs in our training data are jazz or not.
music['jazz'] = [ 1, 0, 0, 0, 1, 1, 0, 1, 1, 0,
                  0, 1, 1, 0, 1, 1, 0, 1, 1, 1,
                  1, 1, 1, 1, 0, 0, 1, 1, 0, 0]

classifier = TwoKNN(music['loudness'], music['duration'], music['jazz'], 5)
print(classifier.classify((14,100)))
