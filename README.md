# Nutrito

Nutrito is a mobile application designed to help users make informed food choices by analyzing product ingredients and suggesting healthier alternatives. With advanced image recognition technology, the app provides instant nutritional insights, allergen warnings, and personalized recommendations.

## Features

- **Product Scanning**: Scan food packages to get ingredient analysis.
- **Alternative Suggestions**: Get healthier alternatives based on product comparisons.
- **Health Alerts**: Identify harmful ingredients and allergens.
- **Smart Shopping List**: Manage shopping lists with personalized suggestions.
- **User Profiles**: Customize preferences based on dietary needs.
- **Community Engagement**: Share reviews and interact with other users.
- **AI-Based Recommendations**: Get personalized health recommendations.

## Technologies Used

### Frontend

- **Flutter** (Dart) - For mobile app development.

### Backend

- **Node.js** (Express) - For API management.
- **Python** - For machine learning and image processing.
- **MongoDB** - NoSQL database for storing user data and product analysis.
- **Firebase** - Authentication and cloud storage.

## Installation

### Prerequisites

Ensure you have the following installed:

- **Flutter SDK**
- **Node.js** (v14+)
- **Python 3.x**
- **MongoDB** (Cloud or Local Instance)
- **Firebase Console Setup**

### Steps to Run the Project

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/nutrito.git
   cd nutrito
   ```

2. **Set up the frontend**

   ```bash
   cd frontend
   flutter pub get
   flutter run
   ```

3. **Set up the backend**

   ```bash
   cd backend
   npm install
   node server.js
   ```

4. **Set up the AI Model (Python server)**
   ```bash
   cd ai_model
   pip install -r requirements.txt
   python app.py
   ```

## API Endpoints

| Method | Endpoint                | Description              |
| ------ | ----------------------- | ------------------------ |
| POST   | `/api/register`         | Register a new user      |
| POST   | `/api/login`            | Authenticate user        |
| GET    | `/api/products`         | Get all products         |
| POST   | `/api/scan`             | Scan a product           |
| GET    | `/api/alternatives/:id` | Get alternative products |

## Usage

1. Open the app and register/login.
2. Use the scan feature to analyze food products.
3. View alternative recommendations based on product scans.
4. Save and track scanned products.
5. Engage with the community by sharing reviews.

## Contributors

- **Om Manoj Jamnekar** - Frontend, UI, Deployment
- **Shiva Purrhottam Aleti** - Backend, API, Database

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any inquiries, contact:

- Om Jamnekar - omjjamnekar@gmail.com
- Shiva Aleti - aletishiva218@gmail.com
