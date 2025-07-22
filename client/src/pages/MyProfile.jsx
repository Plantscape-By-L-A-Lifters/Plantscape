export default function MyProfile({user, projects = []}) {
  return (
     <div>
      <h1>Welcome {user.username}</h1>

      <h2>My Projects</h2>
      
      <div className="projectsContainer">
        {console.log('Projects data:', projects)}
        {projects.length === 0 ? (
          <p>You have no projects yet.</p>
        ) : (
          projects.map(([project]) => (
            <div key={project.id} className="projectObjects">
              <h3>{project.project_name}</h3>
            </div>
          ))
        )}
      </div>
    </div>
  );
}
