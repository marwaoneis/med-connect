<img src="./readme/title1.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/title2.svg"/>

> A Progressive Healthcare Management System, an application that connects between patients, doctors, and health care providers.
>
> MedConnect is an application designed to benefit patients, doctors, and healthcare providers. Patients enjoy convenience with features like virtual consultations, an AI-assisted symptom checker, and automated medication reminders. Doctors benefit from more efficient workflows and improved communication. Hospitals and medical centers witness increased administrative efficiency, leading to an overall enhancement of patient care effectiveness.

### User Stories

Patient:

- As a patient, I want to effortlessly request medication refills through the app, so I can ensure a smooth process and timely access to my prescriptions.
- As a patient experiencing symptoms, I want to input my symptoms into the app's Symptom Checker, receiving AI-powered assessments and suggestions for appropriate next steps, so I can better understand and manage my health.
- As a patient in need of healthcare services, I want to utilize Geo-location services to easily find nearby healthcare providers, pharmacies, or medical facilities, so I can ensure accessibility and convenience.
- As a patient, I want the option for virtual consultations with doctors through the Tele-medicine feature, providing a convenient and flexible healthcare experience without the need to physically visit a clinic.
- As a user, I want to schedule appointments seamlessly through the app, so I can save time and ensure timely access to healthcare services.
- As a patient, I expect healthcare providers to electronically prescribe medications through the app, streamlining the process and allowing prescriptions to be sent directly to my preferred pharmacies.
- As a patient managing multiple medications, I want to set up reminders and track my medication adherence within the app, so I can stay on top of my prescribed treatment plan.

Doctor:

- As a doctor, I want to conduct virtual consultations with patients through the Tele-medicine feature, so I can provide a flexible and efficient way to deliver healthcare services.
- As a healthcare provider, I want to efficiently manage appointments through the app, so I can ensure a smooth scheduling process and effective use of my time.
- As a doctor, I want to electronically prescribe medications to patients through the app, so I can simplify the prescription process and improve coordination with pharmacies.

Pharmacy:

- As a pharmacy, I want to seamlessly integrate with the app to receive electronic prescriptions and coordinate efficiently with healthcare providers, so I can ensure accurate and timely medication dispensing.
- As a pharmacy, I want to receive and process medication refill requests from patients through the app, streamlining the refill process and enhancing customer service.
  <br><br>

<!-- Prototyping -->
<img src="./readme/title3.svg"/>

> We designed MedConnect using wireframes and mockups, iterating on the design until we reached the ideal layout for easy navigation and a seamless user experience.
> The database structure was first drafted in [Excalidraw](https://excalidraw.com/) for basic planning, then refined with detailed designs and animations in Figma.

> <img src="./readme/app-diagram.svg"/>

### Wireframes

| Login screen                            | Register screen                       | Landing screen                        |
| --------------------------------------- | ------------------------------------- | ------------------------------------- |
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |

### Mockups

| Home screen                             | Menu Screen                           | Order Screen                          |
| --------------------------------------- | ------------------------------------- | ------------------------------------- |
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |

<br><br>

<!-- Implementation -->
<img src="./readme/title4.svg"/>

> Using the wireframes and mockups as a guide, we implemented the MedConnect app with the following features:

### User Screens (Mobile)

| Login screen                              | Register screen                         | Landing screen                          | Loading screen                          |
| ----------------------------------------- | --------------------------------------- | --------------------------------------- | --------------------------------------- |
| ![Landing](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) |
| Home screen                               | Menu Screen                             | Order Screen                            | Checkout Screen                         |
| ![Landing](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) |

### Admin Screens (Web)

| Login screen                            | Register screen                       | Landing screen                        |
| --------------------------------------- | ------------------------------------- | ------------------------------------- |
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |
| Home screen                             | Menu Screen                           | Order Screen                          |
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |

<br><br>

<!-- Tech stack -->
<img src="./readme/title5.svg"/>

### MedConnect is built using the following technologies:

Here's a brief high-level overview of the tech stack the Well app uses:

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.

- The app uses [Node.js](https://nodejs.org/en/)for the backend. Node.js is a JavaScript runtime environment that allow running JavaScript code outside of a browser. Node.js is designed to build scalable network applications. Using [Express.js](https://expressjs.com/) which is a web application framework for Node.js. It provides a robust set of features to develop web and mobile applications.

- For trusted database foundation, the app uses the [MongoDB Atlas](https://www.mongodb.com/atlas/database) that enables you to work with data the way you want – easily and effortlessly.

- For notifications, the app uses [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging) which is a cross-platform messaging solution that lets you reliably deliver messages at no cost.

<br><br>

<!-- How to run -->
<img src="./readme/title6.svg"/>

> To set up MedConnect locally, follow these steps:

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.

- npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Clone the repo
   ```sh
   git clone https://github.com/marwaoneis/med-connect.git
   ```
2. Install [Node.js](https://nodejs.org/en/)
3. Install NPM packages
   ```sh
   npm install
   ```
4. Go to nodejs_server directory
   ```sh
   cd nodejs_server
   ```
5. Enter your URI in `monoDb.configs.js`
   ```js
   MONGODB_URI = "ENTER YOUR URI";
   ```
6. Run the server
   ```sh
   nodemon .
   ```
7. Install [Flutter SDK](https://docs.flutter.dev/get-started/install?gclid=Cj0KCQiAveebBhD_ARIsAFaAvrEXbca0gKEuW9ROxwC86eiEtJUUO5tm-AIIzds41AXpzsjkbESCw2EaAsTwEALw_wcB&gclsrc=aw.ds)
8. Go to flutter_app directory
   ```sh
   cd flutter_app
   ```
9. Run flutter_app
   ```sh
   flutter run
   ```

Now, you should be able to run MedConnect locally and explore its features.
