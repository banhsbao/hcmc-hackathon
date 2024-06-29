import argparse
import pandas as pd
import numpy as np
from sklearn.ensemble import IsolationForest
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import make_scorer, f1_score
import joblib
import os

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--data_path', type=str, default='/opt/ml/input/data/training')
    parser.add_argument('--model_dir', type=str, default='/opt/ml/model')
    return parser.parse_args()

def isolation_forest_scorer(estimator, X):
    y_pred = estimator.predict(X)
    y_true = np.ones(len(X))
    return f1_score(y_true, y_pred == -1)

def main():
    args = parse_args()
    # Load data from the specified path
    data_files = [os.path.join(args.data_path, file) for file in os.listdir(args.data_path) if file.endswith('.csv')]
    dataframes = [pd.read_csv(file) for file in data_files]
    df = pd.concat(dataframes, ignore_index=True)
    # Print unique node_ids for verification
    print(f"Unique node_ids in the dataset: {df['node_id'].unique()}")

    param_grid = {
        'n_estimators': [100, 200, 300],
        'max_samples': ['auto', 0.5, 0.75],
        'contamination': [0.05, 0.1, 0.15],
        'max_features': [1.0, 0.75, 0.5]
    }
    iso_forest = IsolationForest(random_state=42)
    grid_search = GridSearchCV(
        estimator=iso_forest, 
        param_grid=param_grid, 
        cv=3, 
        n_jobs=-1, 
        scoring=make_scorer(isolation_forest_scorer),
        verbose=2
    )
    grid_search.fit(df[['ph', 'tds']])
    best_params = grid_search.best_params_
    optimized_clf = IsolationForest(
        n_estimators=best_params['n_estimators'],
        max_samples=best_params['max_samples'],
        contamination=best_params['contamination'],
        max_features=best_params['max_features'],
        random_state=42
    )
    optimized_clf.fit(df[['ph', 'tds']])
    joblib.dump(optimized_clf, f"{args.model_dir}/model.joblib")

def model_fn(model_dir):
    model_path = os.path.join(model_dir, "model.joblib")
    model = joblib.load(model_path)
    return model

def input_fn(request_body, request_content_type):
    import numpy as np
    from io import StringIO, BytesIO

    if request_content_type == 'text/csv':
        data = StringIO(request_body)
        return np.loadtxt(data, delimiter=',')
    elif request_content_type == 'application/x-npy':
        stream = BytesIO(request_body)
        return np.load(stream)
    else:
        raise ValueError(f"Unsupported content type: {request_content_type}")

def predict_fn(input_data, model):
    predictions = model.predict(input_data)
    return predictions

def output_fn(prediction, content_type):
    import numpy as np
    from io import StringIO, BytesIO
    if content_type == 'text/csv':
        output = StringIO()
        np.savetxt(output, prediction, delimiter=',')
        return output.getvalue()
    elif content_type == 'application/x-npy':
        output = BytesIO()
        np.save(output, prediction)
        output.seek(0)
        return output.read()
    else:
        raise ValueError(f"Unsupported content type: {content_type}")

if __name__ == '__main__':
    main()
