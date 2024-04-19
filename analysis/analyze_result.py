import plotly.graph_objects as go
import pandas as pd
import sys

# Function to load data
def load_data(directory, file_name):
    file_path = f"{directory}/{file_name}"
    try:
        # Attempt to read the CSV file
        data = pd.read_csv(file_path)

        # Ensure the first row can be used as header
        if data.empty:
            raise ValueError("First row of the file does not contain headers or is not in expected format")
        
        return data
    except Exception as e:
        print(f"Error processing file {file_name}: {str(e)}")
        return pd.DataFrame()

def main(directory):
    # Define file names
    files = {
        'LocalMapTimeStats.txt': 'Local Map Time Stats',
        'TrackingTimeStats.txt': 'Tracking Time Stats',
        'LBA_Stats.txt': 'LBA Stats'
    }
    
    # Create a figure for plotting
    fig = go.Figure()

    # Load and plot data for each file
    for file_name, label in files.items():
        data = load_data(directory, file_name)
        for col in data.columns:
            fig.add_trace(go.Scatter(x=list(range(len(data))), y=data[col], mode='lines+markers', name=f"{label}: {col}"))

    # Update the layout
    fig.update_layout(
        title="ORB SLAM3 Metrics Timeline",
        xaxis_title="Iteration Index",
        yaxis_title="Time (ms)",
        legend_title="Metric",
        hovermode="x"
    )

    fig.show()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python this_script.py <path_to_directory_with_files>")
        sys.exit(1)
    main(sys.argv[1])

