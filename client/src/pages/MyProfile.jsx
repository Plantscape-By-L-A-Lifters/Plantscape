import { Link } from "react-router";
import './myprofile.css';

export default function MyProfile({ user, projects = [] }) {
  return (
    <div className="myprofile-container">
      <h1>Welcome {user?.username}</h1>
      
      <h3>
        <Link to="/newproject">Start a New Project</Link>
      </h3>
      
      <h2>My Projects</h2>
      
      {/* Debug log */}
      {console.log('Projects data:', projects)}
      
      {projects.length === 0 ? (
        <p>You have no projects yet.</p>
      ) : (
        projects.map((project) => (
          <div key={project.id} className="projectObjects">
            <h3>{project.project_name}</h3>
            <ul>
              <li>
                <Link to="/myproject">My Project</Link>
              </li>
            </ul>
          </div>
        ))
      )}
    </div>
  );
}