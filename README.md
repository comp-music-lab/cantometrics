# Cantometrics

## Raw Data

```
|- dataset
  |- evaluation_<GROUP_ID><PARTICIPANT_ID>.csv
  |- pairwise_distance_<GROUP_ID><PARTICIPANT_ID>..csv
  |- pairwise_preference_<GROUP_ID><PARTICIPANT_ID>..csv
  |- triple_<GROUP_ID><PARTICIPANT_ID>..csv
  |- triple_distance_<GROUP_ID><PARTICIPANT_ID>..csv
```

The raw data is kept under the `/dataset` directory. The files start with `evaluation` stands for the raw data for feature-wise analysis. For further details on how we collect the data, you may check our [backend implementation](https://github.com/keio-moe/song-test-api) and [frontend implementation](https://github.com/keio-moe/song-test) of our experiment program.

## Inter-Rater Reliability Scripts

### Dependencies

The dependencies are maintained by the `Pipenv` file under the `analysis` folder. Be sure to create a virtual environment with the dependencies installed before running the notebook.

### Steps to Run

1. (optional) For comparing the results with the results collected from other researches, you may need to download their raw data. For the case we use (Mehr, 2019), you may need to download it through [OSF](https://osf.io/utfka/), and copy the `NHSDiscography_Annotate.csv` file to the `thirdparty_data` directory.

2. Have Python 3 installed. All of the code is tested under Python 3.7.3.

3. Install the dependencies with [Pipenv](https://github.com/pypa/pipenv).

4. Run the `Analysis.ipynb` with [jupyter-notebook](https://jupyter.org/).

## Data Visualization

### Directory Structure
```
.
|-- map-plot.ipynb
|-- distance_matrix_comparison.ipynb
|-- Interpretations
|-- figs
|-- full-distances
|-- partial-distances
`-- without-track-20
```

#### Python Notebooks
This directory contains two python notebooks. 

**distance_matrix_comparson.ipynb**
Distance Matrix Comparison creates all heatmaps, pearson correlations and mantel correlations between the varios similarity ratings (Human and automated).

**map_plot.ipynb**
This notebook creates a map based visualization of the recordings.

#### Data
1. full-distances: Full distance matrices for Cantometrics, Cantometrics without N/A values, Musly, Panteli, and Metric Learning
2. partial-distances: Partial distance matrrices for Cantometrics, Pairwise ratings, Musly, Panteli, Triplet and individual 5x5 pairwise matrices

#### MDS plots
Look into the interpretations directory. This directory also contains song descriptions with some notes written by Lomax himself.

#### Cantometrics conversions
Converts and normalizes Lomax's ratings that vary from 3 to 13 point likert scales into a unifiorm 0 to 1 range.
This contains the raw data from Lomax's orginial ratings.

### Dependencies
1. Python v. 3.7
2. Anaconda
3. Pandas
4. Numpy
5. Scipy
6. Skbio
7. Basemap
8. Seaborn
9. Jupyter

### Steps to Run
Once you have navigated to this directory run `jupyter notebook` and use the GUI to navigate to the notebook you wish to run. Cells can be run using Shft+Enter
