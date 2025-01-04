# Bill Split App

## Overview
The **Bill Split App** is a Flutter-based mobile application that simplifies splitting bills among multiple people. It allows users to input individual budgets, offers options for custom and normal bill splits, and provides visualizations of expenses using pie charts with the `fl_chart` package.

## Features

### 1. Budget Input
- Each person can input their individual budget upfront.

### 2. Split Modes
- **Normal Split**: The total bill is divided equally among all participants.
- **Custom Split**: Users can specify how much each participant contributes to the bill.

### 3. Visualization
- Interactive pie charts (powered by `fl_chart`) display the contribution of each participant.

## Technologies Used
- **Flutter**: Frontend framework for building the app.
- **Dart**: Programming language for Flutter.
- **fl_chart**: For rendering dynamic pie charts.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/bill-split-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd bill-split-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Usage

1. **Enter Budgets**: Add the budget for each participant.
2. **Select Split Mode**:
   - Normal Split: Divides the bill equally.
   - Custom Split: Enter specific amounts for each person.
3. **Visualize Contributions**:
   - View the breakdown of contributions via a pie chart.

## Screenshots

### 1. Budget Input Screen
![IMG-20241214-WA0016](https://github.com/user-attachments/assets/b4037155-e581-4871-aff6-037d9fc9f874)

![IMG-20241214-WA0014](https://github.com/user-attachments/assets/13aec616-4d2a-4f81-965c-61aa9cb6358f)

### 2. Split Selection Screen
![IMG-20241214-WA0013](https://github.com/user-attachments/assets/8cd1e388-64aa-4c23-9504-f5c78c418b29)

### 3. Pie Chart Visualization
![IMG-20241214-WA0015](https://github.com/user-attachments/assets/9887c275-56ac-44de-9b51-36b53ab33509)

## Future Enhancements
- Export split details as PDF.
- Enable saving and sharing splits.

## Contributing
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature description"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Submit a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
For any inquiries, feel free to reach out to me at vishruth555@gmail.com
