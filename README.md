# Exam Mobile App

A Flutter-based mobile application for taking online exams, built with a clean and scalable architecture. The application allows users to create accounts, authenticate, browse subjects and exams, take exams, view scores, and review their results.

---

## 📱 Features

### Authentication

- User registration
- User login
- Password validation
- Forgot password
- Email reset-code verification
- Password reset
- Authentication state handling
- Secure token management

### Subjects

- Display available subjects
- View subject information
- Browse exams related to each subject

### Exams

- Display available exams
- View exam details
- Show exam restrictions before starting
- Display exam duration
- Display number of questions
- Start an exam
- Navigate between questions
- Select answers
- Support single-choice and multiple-choice questions
- Countdown timer
- Automatic handling when the exam time expires
- Submit exam answers

### Exam Results

- Display the final score
- Display percentage
- Display correct answers
- Display incorrect answers
- View detailed exam results
- Start the exam again

### Localization

- English localization
---

## 🛠️ Technologies & Tools

- **Flutter**
- **Dart**
- **BLoC / Cubit**
- **Clean Architecture**
- **MVI**
- **Retrofit**
- **Dio**
- **GetIt**
- **Injectable**
- **Easy Localization**
- **Shared Preferences**
- **Equatable**
- **Build Runner**

---

## 🏗️ Architecture

The project follows **Clean Architecture** principles to keep the application maintainable, scalable, testable, and easy to extend.

The application is divided into three main layers:


### Presentation Layer

Responsible for the UI and application state.

```text
presentation/
├── auth/
├── subjects/
├── exams/
├── exam/
├── forget_password/
└── ...
```

The presentation layer uses **BLoC/Cubit** to manage application state and handle user interactions.

### Domain Layer

Contains the core business logic of the application and is independent of Flutter or external frameworks.

```text
domain/
├── entities/
├── repositories/
└── use_case/
```

This layer contains:

- Entities
- Repository contracts
- Use cases

### Data Layer

Responsible for communication with the backend API and implementation of repositories.

```text
data/
├── api/
├── models/
├── repositories/
└── ...
```

The API layer is implemented using **Retrofit** and **Dio**.

---

## 🔐 Authentication Flow

The authentication system supports the complete user authentication lifecycle.

```text
Sign Up
   ↓
Sign In
   ↓
Authenticated User
```

### Forgot Password Flow

```text
Forgot Password
       ↓
Enter Email
       ↓
Reset Code Sent
       ↓
Verify Reset Code
       ↓
Create New Password
       ↓
Password Reset Successfully
       ↓
Home
```

---

## 📝 Exam Flow

The exam flow is designed to guide the user from selecting an exam to reviewing the final result.

```text
Subjects
   ↓
Subject Details
   ↓
Available Exams
   ↓
Exam Details
   ↓
Exam Restrictions
   ↓
Questions
   ↓
Submit Answers
   ↓
Exam Score
   ↓
Detailed Results
```

### Exam Questions

During an exam, users can:

- Navigate to the next question
- Return to the previous question
- Select or change answers
- Track their progress
- Monitor the remaining time

The application supports both:

- Single-choice questions
- Multiple-choice questions

---

## ⏱️ Exam Timer

Each exam has a predefined duration.

The application displays the remaining time while the user is taking the exam.

When the timer reaches zero, the application automatically handles the timeout flow and allows the user to proceed to the exam score.

---

## 📊 Exam Results

After submitting an exam, the application displays:

- Total correct answers
- Total incorrect answers
- Score percentage
- Detailed results

Users can also choose to start the exam again.

---

## 🌍 Localization

The application supports localization using **Easy Localization**.

Currently supported languages:

- English
Localization files are organized separately from the application logic to make adding additional languages easier.

---

## 🔌 API Integration

The application communicates with the backend through a REST API using **Dio** and **Retrofit**.

The Retrofit API definition is centralized in:

```text
lib/data/api/exam_api_client.dart
```

The API layer is separated from the presentation layer to keep networking concerns isolated and maintain a clean architecture.

---

## 💉 Dependency Injection

Dependency injection is implemented using:

- **GetIt**
- **Injectable**

Dependencies such as:

- Cubits
- Use cases
- Repositories
- API clients
- Data sources

are registered through the dependency injection system.

This makes dependencies easier to manage, replace, and test.

---

## 🧠 State Management

The project uses **BLoC/Cubit** for state management.

Cubits are responsible for:

- Handling user intents
- Calling use cases
- Updating application state
- Managing loading states
- Handling errors
- Triggering one-time UI events such as navigation and SnackBars

A separate UI event stream is used for one-time events such as:

- Navigation
- Showing SnackBars
- Showing dialogs

This helps prevent one-time events from being triggered repeatedly during widget rebuilds.

---

## 📁 Project Structure

A simplified project structure:

```text
lib/
│
├── core/
│   ├── di/
│   ├── network/
│   ├── utils/
│   └── widgets/
│
├── data/
│   ├── api/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── use_case/
│
└── presentation/
    ├── auth/
    ├── subjects/
    ├── exams/
    ├── exam/
    ├── forget_password/
    └── ...
```

---

## 🧩 Core Components

### Network Layer

The network layer handles communication with the backend API and provides common functionality such as:

- HTTP requests
- Authentication headers
- Error handling
- API response handling
- Timeouts

### Repositories

Repositories provide an abstraction between the domain layer and the data layer.

The domain layer depends on repository contracts rather than concrete implementations.

### Use Cases

Use cases represent individual business operations, such as:

- Sign in
- Sign up
- Forgot password
- Verify reset code
- Reset password
- Get subjects
- Get exams
- Get exam details
- Get exam questions
- Submit exam answers

This keeps business logic separated and reusable.

---

## 🧪 Validation

The application contains reusable validation utilities for authentication forms.

Password validation includes:

- Minimum length
- Uppercase letter
- Lowercase letter
- Number
- Special character

Email and other authentication fields are also validated before submitting requests.

---

## 🎨 UI Components

Reusable widgets are used throughout the application to keep the UI consistent.

Examples include:

- Custom buttons
- Custom text form fields
- Answer items
- Timeout dialogs
- Password validation rules
- Common UI components

This reduces duplicated UI code and makes future design changes easier.

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- Flutter SDK
- Dart SDK
- Android Studio or another Flutter-compatible IDE
- Android SDK for Android development


## 🔧 Code Generation

The project uses code generation for some dependencies and API-related functionality.

After changing Retrofit definitions or injectable registrations, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous code generation during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## 🔒 Security

Authentication tokens are handled through the application's authentication/network layer.

Authenticated requests use an authorization header to communicate securely with protected backend endpoints.

Sensitive credentials and tokens should not be committed to the repository.

---

## 📌 Development Principles

The project follows several software development principles:

- Clean Architecture
- Separation of concerns
- Single Responsibility Principle
- Dependency Injection
- Reusable components
- Centralized API communication
- Centralized error handling
- Immutable application state
- Feature-based organization
- Maintainable and scalable code

---

## 📈 Future Improvements

Possible future improvements include:

- Offline exam support
- Improved caching
- More detailed exam analytics
- Question bookmarking
- Exam history enhancements
- Push notifications
- Additional localization languages
- Unit and widget test coverage
- Improved accessibility
- Enhanced UI animations

---

## 👩‍💻 Development

This project was developed as a Flutter mobile application with a focus on:

- Scalable architecture
- Clean code
- Reusable components
- Professional state management
- REST API integration
- Localization
- Dependency injection
- Maintainability

---

## 📄 License

This project is for educational and development purposes.

## Demo 


https://github.com/user-attachments/assets/340dd70a-0b27-431e-9a7c-d7f80693398a

