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

### Dependencies

### Steps to Run


## Automated Analysis

### Directory Structure

### Dependencies

### Steps to Run
