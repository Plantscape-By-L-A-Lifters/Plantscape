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
