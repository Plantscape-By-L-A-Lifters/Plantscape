import { useContext, useState } from "react";
import { ProjectContext } from "../context/ProjectContext";
import { useNavigate } from "react-router-dom";

export default function ProjectForm() {
  const { addProject } = useContext(ProjectContext);
  const [projectName, setProjectName] = useState("");
  const [description, setDescription] = useState("");
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!projectName.trim()) return;

    addProject({ projectName, description });
    navigate("/project"); // redirect to project page or dashboard
  };

  return (
    <form onSubmit={handleSubmit} className="new-project-form">
      <h2>Create a New Project</h2>

      <label>
        Project Name:
        <input
          type="text"
          value={projectName}
          onChange={(e) => setProjectName(e.target.value)}
          required
        />
      </label>

      <label>
        Description (optional):
        <textarea
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />
      </label>

      <button type="submit">Create Project</button>
    </form>
  );
}

// import React, { useState, useContext } from 'react';
// import axios from 'axios';
// import { useNavigate } from 'react-router-dom';
// import { UserContext } from '../UserContext'; // Adjust path as needed
// // import { ProjectContext } from '../ProjectContext'; // Uncomment if you have a ProjectContext to update global project list

// const ProjectForm = () => {
//   const [projectName, setProjectName] = useState('');
//   const [projectDescription, setProjectDescription] = useState('');
//   const [submitting, setSubmitting] = useState(false);
//   const [submitError, setSubmitError] = useState(null);
//   const [submitSuccess, setSubmitSuccess] = useState(false);

//   const { userId, getHeaders } = useContext(UserContext); // Get userId and getHeaders from UserContext
//   // const { fetchProjects } = useContext(ProjectContext); // Uncomment if you have a way to refresh projects

//   const navigate = useNavigate();

//   const handleSubmit = async (e) => {
//     e.preventDefault(); // Prevent default form submission behavior

//     setSubmitting(true);
//     setSubmitError(null); // Clear previous errors
//     setSubmitSuccess(false); // Reset success state

//     // Basic validation
//     if (!projectName.trim()) {
//       setSubmitError('Project name cannot be empty.');
//       setSubmitting(false);
//       return;
//     }
//     if (!userId) {
//       setSubmitError('User not authenticated. Please log in.');
//       setSubmitting(false);
//       return;
//     }

//     try {
//       const projectData = {
//         name: projectName.trim(),
//         description: projectDescription.trim(),
//         userId: userId // Include the userId with the project data
//       };

//       const response = await axios.post('/api/projects', projectData, getHeaders());

//       // console.log('New project created:', response.data); // For debugging

//       setSubmitSuccess(true);
//       // Optionally, if you have a ProjectContext, you can call a function to refresh the project list:
//       // if (fetchProjects) {
//       //   fetchProjects();
//       // }

//       // Redirect to the new project's detail page or a projects list page
//       // Assuming your backend returns the new project's ID in response.data.id
//       navigate(`/myproject/${response.data.id}`); // Adjust path as per your routing
//     } catch (err) {
//       console.error('Error creating project:', err.response ? err.response.data : err.message);
//       setSubmitError(err.response?.data?.error || 'Failed to create project. Please try again.');
//     } finally {
//       setSubmitting(false);
//     }
//   };

//   return (
//     <div className="container mx-auto p-4 max-w-md">
//       <h1 className="text-3xl font-bold mb-6 text-center text-green-700">Create New Project</h1>

//       <form onSubmit={handleSubmit} className="bg-white shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
//         <div className="mb-4">
//           <label htmlFor="projectName" className="block text-gray-700 text-sm font-bold mb-2">
//             Project Name:
//           </label>
//           <input
//             type="text"
//             id="projectName"
//             className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
//             value={projectName}
//             onChange={(e) => setProjectName(e.target.value)}
//             required
//             disabled={submitting}
//           />
//         </div>

//         <div className="mb-6">
//           <label htmlFor="projectDescription" className="block text-gray-700 text-sm font-bold mb-2">
//             Description:
//           </label>
//           <textarea
//             id="projectDescription"
//             className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline h-32 resize-none"
//             value={projectDescription}
//             onChange={(e) => setProjectDescription(e.target.value)}
//             disabled={submitting}
//           ></textarea>
//         </div>

//         <div className="flex items-center justify-between">
//           <button
//             type="submit"
//             className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline disabled:opacity-50 disabled:cursor-not-allowed"
//             disabled={submitting}
//           >
//             {submitting ? 'Creating...' : 'Create Project'}
//           </button>
//         </div>

//         {submitSuccess && (
//           <p className="text-green-500 text-xs italic mt-4">Project created successfully!</p>
//         )}

//         {submitError && (
//           <p className="text-red-500 text-xs italic mt-4">{submitError}</p>
//         )}
//       </form>
//     </div>
//   );
// };

// export default ProjectForm;
