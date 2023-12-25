const mongoose = require("mongoose");

const profileInfoSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  address: {
    type: String,
    required: true,
  },
  phone: {
    type: String,
    required: true,
  },
  additionalInfo: {
    type: Map,
    of: String, // or mongoose.Schema.Types.Mixed if the structure is not consistent
  },
});

module.exports = mongoose.model("ProfileInfo", profileInfoSchema);

// To structure the `AdditionalInfo` field in your MongoDB schema for the MedConnect application with the specified fields for each user type (patient, doctor, pharmacy), you will need to customize the JSON object for each. Here's how you can structure it:

// ### Patient `AdditionalInfo` Structure
// For patients, the `AdditionalInfo` JSON object can include fields like medical history, emergency contacts, and other health-related information:

// ```json
// {
//   "DateOfBirth": "1980-01-01",
//   "Gender": "Female",
//   "MedicalHistory": {
//     "Vaccinations": ["Hepatitis B", "Flu Shot"],
//     "Allergies": ["Peanuts", "Penicillin"],
//     "PriorSurgeries": ["Appendectomy", "Knee Surgery"],
//     "EmergencyContacts": [
//       {
//         "Name": "John Doe",
//         "Relationship": "Husband",
//         "Phone": "123-456-7890"
//       },
//       // ... additional emergency contacts
//     ]
//   },
//   "BloodGroup": "A+",
//   "Height": "170cm",
//   "Weight": "60kg"
// }
// ```

// ### Doctor `AdditionalInfo` Structure
// For doctors, the `AdditionalInfo` could include their specialization, qualifications, and experience:

// ```json
// {
//   "Specialization": "Cardiology",
//   "Qualifications": ["MD", "PhD"],
//   "YearsOfExperience": 15
// }
// ```

// ### Pharmacy `AdditionalInfo` Structure
// For pharmacies, the `AdditionalInfo` might be simpler, focusing on insurance information:

// ```json
// {
//   "InsuranceInfo": ["Provider A", "Provider B", "Provider C"]
// }
// ```

// ### Implementing in MongoDB with Mongoose
// Here's how you could implement this in your Mongoose schema:

// ```javascript
// const mongoose = require('mongoose');
// const Schema = mongoose.Schema;

// const profileInfoSchema = new Schema({
//   // Common fields for all user types
//   FullName: String,
//   Address: String,
//   Phone: String,
//   // ...

//   // AdditionalInfo as a Map to store JSON data
//   AdditionalInfo: {
//     type: Map,
//     of: String
//   }
// });

// const ProfileInfo = mongoose.model('ProfileInfo', profileInfoSchema);

// // Example of adding a new patient
// let newPatient = new ProfileInfo({
//   FullName: "Jane Doe",
//   Address: "123 Main St",
//   Phone: "555-1234",
//   AdditionalInfo: {
//     DateOfBirth: "1980-01-01",
//     Gender: "Female",
//     MedicalHistory: JSON.stringify({
//       Vaccinations: ["Hepatitis B", "Flu Shot"],
//       Allergies: ["Peanuts", "Penicillin"],
//       PriorSurgeries: ["Appendectomy", "Knee Surgery"],
//       EmergencyContacts: JSON.stringify([
//         {
//           Name: "John Doe",
//           Relationship: "Husband",
//           Phone: "123-456-7890"
//         }
//         // ... other contacts
//       ])
//     }),
//     BloodGroup: "A+",
//     Height: "170cm",
//     Weight: "60kg"
//   }
// });

// newPatient.save();
// ```

// In this implementation:
// - Each user type has a customized `AdditionalInfo` JSON object.
// - Use `JSON.stringify()` for nested objects within `AdditionalInfo`.
// - Ensure the frontend forms and API endpoints are designed to handle these data structures.

// Remember to handle sensitive information securely and comply with relevant privacy laws, especially when dealing with medical data.
