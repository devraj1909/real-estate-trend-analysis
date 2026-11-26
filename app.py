
from flask import Flask, jsonify, send_from_directory
import re, pandas as pd, numpy as np
from sklearn.linear_model import LinearRegression
import os

app = Flask(__name__, static_folder='frontend', static_url_path='')

SQL_FILE = os.path.join(os.path.dirname(__file__), 'real_estate_with_more_data.sql')

def load_data():
    with open(SQL_FILE, 'r', encoding='utf-8') as f:
        sql = f.read()
    values = re.findall(r"INSERT INTO properties .*? VALUES\s*(\([\s\S]+?)\);", sql, flags=re.DOTALL)
    tuples = []
    for block in values:
        parts = re.split(r"\),\s*\(", block.strip())
        for p in parts:
            p = p.strip()
            if not p.startswith('('): p = '('+p
            if not p.endswith(')'): p = p + ')'
            tuples.append(p)
    rows = []
    for t in tuples:
        inner = t[1:-1]
        parts = re.findall(r"'([^']*)'|([^,]+)", inner)
        parsed = []
        for a,b in parts:
            parsed.append(a if a!='' and a is not None else b.strip())
        rows.append(parsed)
    cols = ["Location","Area","Price","Bedrooms","Bathrooms","Distance","YearBuilt","Category","Temperature","Humidity","Rainfall","pH"]
    df = pd.DataFrame(rows, columns=cols)
    num_cols = ["Area","Price","Bedrooms","Bathrooms","Distance","YearBuilt","Temperature","Humidity","Rainfall","pH"]
    for c in num_cols:
        df[c] = pd.to_numeric(df[c], errors='coerce')
    return df

def summary_by_location_year(df):
    summary = df.groupby(["Location","YearBuilt"], as_index=False).agg(
        AvgPrice=("Price","mean"),
        Count=("Price","size"),
        AvgArea=("Area","mean")
    ).sort_values(["Location","YearBuilt"])
    return summary

def prediction_by_location(df, next_year=None):
    if next_year is None:
        next_year = int(df['YearBuilt'].max()) + 1
    preds = []
    for loc, g in df.groupby('Location'):
        X = g[['YearBuilt']].values
        y = g['Price'].values
        if len(g) >= 2 and np.std(X.flatten()) > 0:
            model = LinearRegression().fit(X, y)
            pred = float(model.predict([[next_year]])[0])
            r2 = float(model.score(X, y))
            slope = float(model.coef_[0])
        else:
            pred = float(y.mean()) if len(y)>0 else None
            r2 = 0.0
            slope = 0.0
        current_avg = float(g['Price'].mean())
        pct_change = ((pred - current_avg) / current_avg * 100) if current_avg>0 and pred is not None else None
        rec = 'Hold'
        if pct_change is not None:
            if pct_change > 6:
                rec = 'Buy - High growth potential'
            elif pct_change > 2:
                rec = 'Buy - Moderate growth'
            elif pct_change > -1:
                rec = 'Hold'
            else:
                rec = 'Avoid - Negative outlook'
        preds.append({
            'Location': loc,
            'CurrentAvgPrice': round(current_avg,2) if current_avg is not None else None,
            'PredictedPrice_nextYear': round(pred,2) if pred is not None else None,
            'PctChange_nextYear': round(pct_change,2) if pct_change is not None else None,
            'Slope': round(slope,2),
            'R2': round(r2,3),
            'Recommendation': rec,
            'DataPoints': len(g)
        })
    return preds

@app.route('/api/summary')
def api_summary():
    df = load_data()
    summary = summary_by_location_year(df)
    return jsonify(summary.to_dict(orient='records'))

@app.route('/api/predictions')
def api_predictions():
    df = load_data()
    preds = prediction_by_location(df)
    # sort by pct change desc
    preds_sorted = sorted(preds, key=lambda x: (x['PctChange_nextYear'] if x['PctChange_nextYear'] is not None else -999), reverse=True)
    return jsonify(preds_sorted)

# Serve frontend
@app.route('/')
def index():
    return send_from_directory('frontend', 'index.html')

@app.route('/<path:path>')
def static_proxy(path):
    return send_from_directory('frontend', path)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
